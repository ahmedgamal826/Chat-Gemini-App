import 'package:chat_with_gemini_app/features/splash/presentation/views/splash_view.dart';
import 'package:chat_with_gemini_app/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChatWithGeminiApp());
}

class ChatWithGeminiApp extends StatelessWidget {
  const ChatWithGeminiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      // home: SplashView()
      home: HomeScreen(),
    );
  }
}
