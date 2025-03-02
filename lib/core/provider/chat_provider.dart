import 'dart:typed_data';
import 'package:chat_with_gemini_app/core/constants/constants.dart';
import 'package:chat_with_gemini_app/core/hive/boxes.dart';
import 'package:chat_with_gemini_app/core/hive/chat_history.dart';
import 'package:chat_with_gemini_app/core/hive/settings.dart';
import 'package:chat_with_gemini_app/core/hive/user_model.dart';
import 'package:chat_with_gemini_app/features/chat_home/data/models/message.dart';
import 'package:chat_with_gemini_app/features/chat_home/data/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:uuid/uuid.dart';

class ChatProvider extends ChangeNotifier {
  // Variables
  List<Message> _messagesInChats = [];

  // final PageController _pageController = PageController();

  List<XFile>? _imagesFileList = [];

  int _currentIndex = 0;

  String _currentChatId = '';

  GenerativeModel? _model;

  GenerativeModel? _textModel;

  GenerativeModel? _visionModel;

  String _modelType = 'gemini-pro';

  bool _isLoading = false;

  // getters

  List<Message> get messagesInChat => _messagesInChats;

  // PageController get pageController => _pageController;

  List<XFile>? get imagesFileList => _imagesFileList;

  int get currentIndex => _currentIndex;

  String get chatCurrentId => _currentChatId;

  GenerativeModel? get model => _model;

  GenerativeModel? get textModel => _textModel;

  GenerativeModel? get visionModel => _visionModel;

  String get modelType => _modelType;

  bool get isLiading => _isLoading;

  Future<void> setInChatMessages({required String chatId}) async {
    final messagesFromDB = await loadMessagesFromDB(chatId: chatId);

    for (var message in messagesFromDB) {
      if (_messagesInChats.contains(message)) {
        print('message already exists');
        continue;
      }
      _messagesInChats.add(message);
    }

    notifyListeners();
  }

  Future<List<Message>> loadMessagesFromDB({required String chatId}) async {
    await Hive.openBox('${Constants.chatMessageBox}$chatId');

    final messageBox = Hive.box('${Constants.chatMessageBox}$chatId');

    final newData = messageBox.keys.map((e) {
      final message = messageBox.get(e);

      final messageData = Message.fromMap(Map<String, dynamic>.from(message));

      return messageData;
    }).toList();

    notifyListeners();
    return newData;
  }

  // set file list
  void setFileListImages({required List<XFile> listValue}) {
    _imagesFileList = listValue;
    notifyListeners();
  }

  // set new ai model
  String setNewMode({required String newModel}) {
    _modelType = newModel;
    notifyListeners();
    return newModel;
  }

  // gemini-1.0-pro know text and image
  Future<void> setModel({required bool isTextOnly}) async {
    try {
      if (isTextOnly) {
        _model = _textModel ??
            GenerativeModel(
              model: setNewMode(newModel: 'gemini-2.0-flash'),
              apiKey: ApiService.apiKey,
              generationConfig: GenerationConfig(
                // this attributes help model to get the highest probability for the answer
                temperature: 0.4,
                topK: 32,
                topP: 1,
                maxOutputTokens: 4096,
              ),
            );
      } else {
        _model = _visionModel ??
            GenerativeModel(
              model: 'gemini-1.5-flash',
              apiKey: ApiService.apiKey,
              generationConfig: GenerationConfig(
                temperature: 0.4,
                topK: 32,
                topP: 1,
                maxOutputTokens: 4096,
              ),
            );
      }

      notifyListeners();
      print("Model set successfully");
    } catch (e, stacktrace) {
      print("Error in setModel: $e");
      print(stacktrace);
    }
  }

  void setCurrentIndex({required int newCurrentIndex}) {
    _currentIndex = newCurrentIndex;
    notifyListeners();
  }

  void setCurrentChatId({required String newChatId}) {
    _currentChatId = newChatId;
    notifyListeners();
  }

  void setLoading({required bool value}) {
    _isLoading = value;
    notifyListeners();
  }

  // Define _formatDateTime here
  String _formatDateTime(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    return dateFormat.format(dateTime);
  }
  // send message to model

  Future<void> sendMessage({
    required String message,
    required bool isTextOnly,
  }) async {
    setModel(isTextOnly: isTextOnly);
    setLoading(value: true);
    String chatId = getChatId();
    List<Content> history = [];

    history = await getHistory(chatId: chatId);

    // get the image Urls
    List<String> imagesUrls = getImagesUrl(isTextOnly: isTextOnly);

    // open the messages box
    final messagesBox =
        await Hive.openBox('${Constants.chatMessageBox}$chatId');

    // get the last user message id
    final userMessageId = messagesBox.keys.length;

    // assistant messageId
    final assistantMessageId = messagesBox.keys.length + 1;

    // Get current DateTime and format it
    String formattedTime =
        _formatDateTime(DateTime.now()); // Call your formatting function
    // // // user message id
    // final userMessageId = const Uuid().v4();
    // user message
    final userMessage = Message(
      messageId: userMessageId.toString(),
      chatId: chatId,
      role: Role.user,
      message: StringBuffer(message),
      imagesUrls: imagesUrls,
      timeSent: formattedTime,
    );

    // add user message in list on chat screen
    _messagesInChats.add(userMessage);
    notifyListeners();

    if (chatCurrentId.isEmpty) {
      setCurrentChatId(newChatId: chatId);
    }

    await sendMessageAndWaitToResonse(
      message: message,
      chatId: chatId,
      isTextOnly: isTextOnly,
      history: history,
      userMessage: userMessage,
      modelMessageId: assistantMessageId.toString(),
      messagesBox: messagesBox,
    );
  }

  // send message to the model and wait to response
  Future<void> sendMessageAndWaitToResonse({
    required String message,
    required String chatId,
    required bool isTextOnly,
    required List<Content> history,
    required Message userMessage,
    required String modelMessageId,
    required Box messagesBox,
  }) async {
    // start char session with gemini
    final chatSession = _model!.startChat(
      history: !isTextOnly || history.isEmpty ? null : history,
    );

    // get content

    final content = await getContent(message: message, isTextOnly: isTextOnly);

    // assistant message id
    // user message id
    final modelMessageId = const Uuid().v4();

    // Get current DateTime and format it
    DateTime currentTime = DateTime.now();
    String formattedTime =
        _formatDateTime(currentTime); // Call your formatting function

    final assistantMessage = userMessage.copyWith(
      messageId: modelMessageId,
      role: Role.assistant,
      message: StringBuffer(),
      timeSent: formattedTime,
    );

    // add this message to the list on message in chat
    _messagesInChats.add(assistantMessage);
    notifyListeners();

    chatSession.sendMessageStream(content).asyncMap((event) {
      return event;
    }).listen(
      (event) {
        _messagesInChats
            .firstWhere((element) =>
                element.messageId == assistantMessage.messageId &&
                element.role.name == Role.assistant.name)
            .message
            .write(event.text);
        notifyListeners();
      },
      onDone: () async {
        // save message to hive database

        await saveMessageToDatabase(
          chatId: chatId,
          userMessage: userMessage,
          assistantMessage: assistantMessage,
          messagesBox: messagesBox,
        );

        setLoading(value: false);
      },
    ).onError((error, stackTrace) {
      setLoading(value: false);
    });
  }

  // Save message in database
  Future<void> saveMessageToDatabase({
    required String chatId,
    required Message userMessage,
    required Message assistantMessage,
    required Box messagesBox,
  }) async {
    // save user messages in hive database
    await messagesBox.add(userMessage.toMap());

    // save assistant message in hive database
    await messagesBox.add(assistantMessage.toMap());

    final chatHistoryBox = Boxes.getChatHistory();

    final chatHistory = ChatHistory(
      chatId: chatId,
      prompt: userMessage.message.toString(),
      response: assistantMessage.message.toString(),
      imagesUrls: userMessage.imagesUrls,
      timestamp: DateTime.now(),
    );

    await chatHistoryBox.put(chatId, chatHistory);

    // close the box
    await messagesBox.close();
  }

  Future<Content> getContent({
    required String message,
    required bool isTextOnly,
  }) async {
    if (isTextOnly) {
      // generate text from text-only input
      return Content.text(message);
    } else {
      // generate image from text and image input
      final imageFutures = _imagesFileList
          ?.map((imageFile) => imageFile.readAsBytes())
          .toList(growable: false);

      final imageBytes = await Future.wait(imageFutures!);
      final prompt = TextPart(message);
      final imageParts = imageBytes
          .map((bytes) => DataPart('image/jpeg', Uint8List.fromList(bytes)))
          .toList();

      return Content.multi([prompt, ...imageParts]);
    }
  }

  List<String> getImagesUrl({required bool isTextOnly}) {
    List<String> imagesUrls = [];
    if (!isTextOnly && imagesFileList != null) {
      //////// Update /////
      for (var image in imagesFileList!) {
        imagesUrls.add(image.path);
      }
    }

    return imagesUrls;
  }

  Future<List<Content>> getHistory({required String chatId}) async {
    List<Content> history = [];

    if (chatCurrentId.isNotEmpty) {
      await setInChatMessages(chatId: chatId);
      for (var message in messagesInChat) {
        if (message.role == Role.user) {
          history.add(Content.text(message.message.toString()));
        } else {
          history.add(Content.model([TextPart(message.message.toString())]));
        }
      }
    }

    return history;
  }

  String getChatId() {
    if (chatCurrentId.isEmpty) {
      return const Uuid().v4();
    } else {
      return chatCurrentId;
    }
  }

  // Delete Chat Message

  Future<void> deleteMessages({required String chatId}) async {
    if (!Hive.isBoxOpen('${Constants.chatMessageBox}$chatId')) {
      Hive.openBox('${Constants.chatMessageBox}$chatId');

      Hive.box('${Constants.chatMessageBox}$chatId').clear();

      Hive.box('${Constants.chatMessageBox}$chatId').close();
    }

    // delete all chat messages
    else {
      Hive.box('${Constants.chatMessageBox}$chatId').clear();
      Hive.box('${Constants.chatMessageBox}$chatId').close();
    }

    if (chatCurrentId.isNotEmpty) {
      if (chatCurrentId == chatId) {
        setCurrentChatId(newChatId: '');
        _messagesInChats.clear();
        notifyListeners();
      }
    }
  }

  // prepare chat room to new chat or navigate chat history to chat room
  Future<void> prepareChatRoom({
    required String chatId,
    required bool newChat,
  }) async {
    if (!newChat) {
      // navigate chat history to chat room
      // load messages from database
      final chatHistory = await loadMessagesFromDB(chatId: chatId);

      // delete chat messages
      _messagesInChats.clear();

      for (var message in chatHistory) {
        _messagesInChats.add(message);
      }

      setCurrentChatId(newChatId: chatId);
    } else {
      // prepare chat room to new chat
      _messagesInChats.clear();
      setCurrentChatId(newChatId: chatId);
    }
  }

  // Initialize Hive
  static initHive() async {
    final dir = await path.getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    await Hive.initFlutter(Constants.geminiDB);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ChatHistoryAdapter());
      await Hive.openBox<ChatHistory>(Constants.chatHistoryBox);
    }

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserModelAdapter());
      await Hive.openBox<UserModel>(Constants.userModelBox);
    }

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(SettingsAdapter());
      await Hive.openBox<Settings>(Constants.settingsBox);
    }
  }
}
