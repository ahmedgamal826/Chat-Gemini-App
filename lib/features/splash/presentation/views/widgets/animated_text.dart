import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_with_gemini_app/features/profile/data/Providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimatedText extends StatelessWidget {
  final VoidCallback onFinished;

  const AnimatedText({Key? key, required this.onFinished}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return AnimatedTextKit(
      animatedTexts: [
        TyperAnimatedText(
          'Chat With Gemini',
          textStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: profileProvider.isDarkMode
                ? Colors.white
                : const Color(0xff1E1E1E),
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2, 2),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          speed: const Duration(milliseconds: 150),
        ),
      ],
      totalRepeatCount: 1,
      pause: const Duration(milliseconds: 900),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
      onFinished: onFinished,
    );
  }
}
