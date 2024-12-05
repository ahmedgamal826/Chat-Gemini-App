import 'package:chat_with_gemini_app/core/hive/boxes.dart';
import 'package:chat_with_gemini_app/core/hive/chat_history.dart';
import 'package:chat_with_gemini_app/features/chat_history/presentation/views/widgets/chat_history_card.dart';
import 'package:chat_with_gemini_app/features/chat_history/presentation/views/widgets/empty_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatHistoryView extends StatefulWidget {
  const ChatHistoryView({super.key});

  @override
  State<ChatHistoryView> createState() => _ChatHistoryViewState();
}

class _ChatHistoryViewState extends State<ChatHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: const Text('Chat History'),
      ),
      body: ValueListenableBuilder<Box<ChatHistory>>(
        valueListenable: Boxes.getChatHistory().listenable(),
        builder: (context, box, _) {
          final chatHistory =
              box.values.toList().cast<ChatHistory>().reversed.toList();
          return chatHistory.isEmpty
              ? const EmptyHistoryWidget()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: chatHistory.length,
                    itemBuilder: (context, index) {
                      final chat = chatHistory[index];
                      return ChatHistoryCard(chatHistory: chat);
                    },
                  ),
                );
        },
      ),
    );
  }
}
