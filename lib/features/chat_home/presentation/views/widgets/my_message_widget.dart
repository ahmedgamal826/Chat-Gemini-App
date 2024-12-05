import 'package:chat_with_gemini_app/features/chat_home/data/models/message.dart';
import 'package:chat_with_gemini_app/features/chat_home/presentation/views/widgets/images_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MyMessageWidget extends StatelessWidget {
  const MyMessageWidget({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: width * 0.5,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xff74AA9C),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (message.imagesUrls.isNotEmpty)
                      ImagesPreviewWidget(
                        message: message,
                      ),
                    const SizedBox(height: 8),
                    SelectableText(
                      message.message.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _formatTime(message.timeSent),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Image.asset(
              'assets/user.png',
              width: MediaQuery.of(context).size.width * 0.07,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    int hour = time.hour % 12; // تحويل الساعة إلى صيغة 12 ساعة
    hour = hour == 0 ? 12 : hour; // إذا كانت الساعة 0، يتم تحويلها إلى 12
    String minute = time.minute
        .toString()
        .padLeft(2, '0'); // إضافة صفر أمام الدقائق إذا كانت أقل من 10
    String period = time.hour < 12 ? 'AM' : 'PM'; // تحديد ما إذا كان AM أو PM

    return "$hour:$minute $period";
  }
}
