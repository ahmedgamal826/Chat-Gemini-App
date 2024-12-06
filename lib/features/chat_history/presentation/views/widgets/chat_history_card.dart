import 'package:chat_with_gemini_app/core/hive/chat_history.dart';
import 'package:chat_with_gemini_app/core/provider/chat_provider.dart';
import 'package:chat_with_gemini_app/core/services/formatted_date_and_time_services.dart';
import 'package:chat_with_gemini_app/core/widgets/show_animated_dialog.dart';
import 'package:chat_with_gemini_app/core/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatHistoryCard extends StatelessWidget {
  const ChatHistoryCard({super.key, required this.chatHistory});

  final ChatHistory chatHistory;

  @override
  Widget build(BuildContext context) {
    final FormattedDateAndTimeServices formattedDate =
        FormattedDateAndTimeServices();
    return InkWell(
      onTap: () {
        // Navigate to chat home view when tapped
        final chatProvider = context.read<ChatProvider>();

        chatProvider.prepareChatRoom(
            chatId: chatHistory.chatId, newChat: false);

        chatProvider.setCurrentIndex(newCurrentIndex: 1);
      },
      onLongPress: () {
        // Show dialog to delete chat history
        showAnimatedDialog(
          title: 'Confirm Deletion',
          context: context,
          description: 'Are you sure you want to delete this chat history?',
          onConfirm: () {
            chatHistory.delete();

            // Show the success snack bar after deletion
            CustomSnackBar.showSuccessSnackBar(
              context,
              'Chat history deleted successfully!',
            );
          },
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color.fromARGB(255, 47, 44, 44),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: const Icon(
            Icons.chat,
            size: 30,
            color: Colors.white,
          ),
          title: Text(
            chatHistory.prompt,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Row(
            children: [
              Expanded(
                child: Text(
                  chatHistory.response,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white70,
                  ),
                ),
              ),
              Text(
                formattedDate.formatDate(chatHistory.timestamp.toString()),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
