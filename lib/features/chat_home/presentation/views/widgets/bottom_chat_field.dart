import 'dart:math';
import 'package:chat_with_gemini_app/core/provider/chat_provider.dart';
import 'package:chat_with_gemini_app/features/chat_home/presentation/views/widgets/images_preview_widget.dart';
import 'package:chat_with_gemini_app/core/widgets/show_animated_dialog.dart';
import 'package:chat_with_gemini_app/features/profile/data/Providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BottomChatField extends StatefulWidget {
  const BottomChatField({super.key, required this.chatProvider});

  final ChatProvider chatProvider;

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  final ImagePicker imagePicker = ImagePicker();

  void pickImage() async {
    try {
      final pickImages = await imagePicker.pickMultiImage(
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 90,
      );

      widget.chatProvider.setFileListImages(listValue: pickImages);
    } on Exception catch (e) {
      log('e' as num);
    }
  }

  // Method to format the time
  String _formatDateTime(DateTime dateTime) {
    final DateFormat dateFormat =
        DateFormat('yyyy-MM-dd HH:mm:ss'); // Modify as per your needs
    return dateFormat.format(dateTime);
  }

  Future<void> sendChatMesage({
    required String message,
    required ChatProvider chatProvider,
    required bool isTextOnly,
  }) async {
    try {
      String formattedTime =
          _formatDateTime(DateTime.now()); // Format the time as string

      // Send the message with the formatted time
      await chatProvider.sendMessage(
        message: message, isTextOnly: isTextOnly,
        // timeSent: formattedTime, // Include formatted time when sending
      );
    } catch (e) {
      log('error : $e' as num);
    } finally {
      widget.chatProvider
          .setFileListImages(listValue: []); // Clear images after sending
      controller.clear();
      focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasImages = widget.chatProvider.imagesFileList != null &&
        widget.chatProvider.imagesFileList!.isNotEmpty;

    final profileProvider = Provider.of<ProfileProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Theme.of(context).textTheme.titleLarge!.color!,
          ),
        ),
        child: Column(
          children: [
            if (hasImages)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImagesPreviewWidget(),
              ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (hasImages) {
                      // Show delete dialog to delete image
                      showAnimatedDialog(
                        title: 'Confirm Deletion',
                        description:
                            'Are you sure you want to delete this image?',
                        context: context,
                        onConfirm: () {
                          setState(() {
                            widget.chatProvider
                                .setFileListImages(listValue: []);
                          });
                        },
                      );
                    } else {
                      pickImage();
                    }
                  },
                  icon: Icon(hasImages ? Icons.delete_forever : Icons.image),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (String value) {
                      if (value.isNotEmpty) {
                        sendChatMesage(
                          message: controller.text,
                          chatProvider: widget.chatProvider,
                          isTextOnly: hasImages ? false : true,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Write a message...',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (controller.text.isNotEmpty) {
                      sendChatMesage(
                        message: controller.text,
                        chatProvider: widget.chatProvider,
                        isTextOnly: hasImages ? false : true,
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: profileProvider.isDarkMode
                          ? const Color.fromARGB(255, 47, 44, 44)
                          : Colors.blueAccent.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(5),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
