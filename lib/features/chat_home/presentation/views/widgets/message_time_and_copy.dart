import 'package:chat_with_gemini_app/core/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageTimeAndCopy extends StatelessWidget {
  const MessageTimeAndCopy({
    super.key,
    required this.timeSent,
    required this.message,
  });

  final DateTime timeSent;
  final String message;

  @override
  Widget build(BuildContext context) {
    String _formatTime(DateTime time) {
      int hour = time.hour % 12;
      hour = hour == 0 ? 12 : hour;
      String minute = time.minute.toString().padLeft(2, '0');
      String period = time.hour < 12 ? 'AM' : 'PM';

      return "$hour:$minute $period";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _formatTime(timeSent),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: message));

            CustomSnackBar.showSuccessSnackBar(
              context,
              'Message copied to clipboard!',
            );
          },
          icon: const Icon(
            Icons.copy,
            color: Colors.white,
            size: 22,
          ),
        )
      ],
    );
  }
}
