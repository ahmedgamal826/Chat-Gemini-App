import 'package:chat_with_gemini_app/features/chat_home/data/models/message.dart';
import 'package:chat_with_gemini_app/features/chat_home/presentation/views/widgets/row_bottom_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AssistantMessageWidget extends StatelessWidget {
  const AssistantMessageWidget(
      {super.key, required this.message, required this.timeSent});

  final String message;
  final String timeSent;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: width * 0.9,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 47, 44, 44),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    message.isEmpty
                        ? const SizedBox(
                            width: 50,
                            child: SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        : SelectableText(
                            message.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                    const SizedBox(height: 5),
                    RowBottomMessage(
                      role: Role.assistant,
                      timeSent: timeSent,
                      message: message,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Image.asset(
              'assets/app_logo.png',
              width: MediaQuery.of(context).size.width * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
