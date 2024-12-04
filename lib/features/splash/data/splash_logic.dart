import 'package:chat_with_gemini_app/features/chat_home/presentation/views/chat_home_view.dart';
import 'package:chat_with_gemini_app/home_screen.dart';
import 'package:flutter/material.dart';

class SplashLogic {
  static Future<void> NavigateToChatHomeView(BuildContext context) async {
    try {
      // Navigate to CalculatorView
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    } catch (e) {
      debugPrint("Error playing sound: $e");

      // Fallback navigation in case of error
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }
  }
}
