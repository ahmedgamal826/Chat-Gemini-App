import 'package:flutter/material.dart';

class ChatHomeAppBar extends StatelessWidget {
  const ChatHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/app_logo.png',
          width: MediaQuery.of(context).size.width * 0.12,
        ),
        const SizedBox(width: 10),
        const Text(
          'Chat With Gemini',
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
