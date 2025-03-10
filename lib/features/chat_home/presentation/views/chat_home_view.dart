import 'package:chat_with_gemini_app/core/provider/chat_provider.dart';
import 'package:chat_with_gemini_app/core/widgets/show_animated_dialog.dart';
import 'package:chat_with_gemini_app/features/chat_home/presentation/views/widgets/bottom_chat_field.dart';
import 'package:chat_with_gemini_app/features/chat_home/presentation/views/widgets/chat_home_app_bar.dart';
import 'package:chat_with_gemini_app/features/chat_home/presentation/views/widgets/chat_messages_list.dart';
import 'package:chat_with_gemini_app/features/chat_home/presentation/views/widgets/no_chats_messages.dart';
import 'package:chat_with_gemini_app/features/profile/data/Providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatHomeView extends StatefulWidget {
  const ChatHomeView({super.key});

  @override
  State<ChatHomeView> createState() => _ChatHomeViewState();
}

class _ChatHomeViewState extends State<ChatHomeView> {
  final _scrollController = ScrollController();
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients &&
          _scrollController.position.maxScrollExtent > 0.0) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(microseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        if (chatProvider.messagesInChat.isNotEmpty) {
          scrollToBottom();
        }

        // scroll to bottom on new message
        chatProvider.addListener(() {
          if (chatProvider.messagesInChat.isNotEmpty) {
            scrollToBottom();
          }
        });

        return Scaffold(
          backgroundColor: profileProvider.isDarkMode
              ? const Color(0xff1E1E1E)
              : Colors.white,
          appBar: AppBar(
            backgroundColor: profileProvider.isDarkMode
                ? const Color(0xff1E1E1E)
                : Colors.blueAccent.withOpacity(0.8),
            centerTitle: true,
            title: const ChatHomeAppBar(),
            actions: [
              if (chatProvider.messagesInChat.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    onPressed: () {
                      // start new chat
                      showAnimatedDialog(
                        title: 'Confirm Addition',
                        context: context,
                        description:
                            'Are you sure you want to start a new chat with gemini?',
                        onConfirm: () {
                          setState(() {
                            // start new chat
                            chatProvider.prepareChatRoom(
                              chatId: '',
                              newChat: true,
                            );
                          });
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.edit_square,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                )
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Expanded(
                    child: chatProvider.messagesInChat.isEmpty
                        ? const NoChatMessages()
                        : ChatMessagesList(
                            scrollController: _scrollController,
                            chatProvider: chatProvider,
                          ),
                  ),
                  BottomChatField(
                    chatProvider: chatProvider,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
