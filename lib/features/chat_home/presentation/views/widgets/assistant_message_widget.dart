import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AssistantMessageWidget extends StatelessWidget {
  const AssistantMessageWidget(
      {super.key, required this.message, required this.timeSent});

  final String message;
  final DateTime timeSent;

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
                  color: Color(0xff0EA385),
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
                    Text(
                      _formatTime(timeSent),
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
              'assets/app_logo.png',
              width: MediaQuery.of(context).size.width * 0.1,
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
