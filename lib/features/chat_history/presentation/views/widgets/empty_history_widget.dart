import 'package:chat_with_gemini_app/core/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmptyHistoryWidget extends StatelessWidget {
  const EmptyHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to chat room
        final chatProvider = context.read<ChatProvider>();
        chatProvider.prepareChatRoom(chatId: '', newChat: true);
        chatProvider.setCurrentChatId(newChatId: '1');
      },
      child: Center(
        child: Container(
          child: const Text(
            'No Found Chat, Start New Chat',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
