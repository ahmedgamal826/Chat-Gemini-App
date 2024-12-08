import 'package:chat_with_gemini_app/core/provider/chat_provider.dart';
import 'package:chat_with_gemini_app/features/chat_home/data/services/sound_services.dart';
import 'package:chat_with_gemini_app/features/profile/data/Providers/profile_provider.dart';
import 'package:chat_with_gemini_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init hive
  await ChatProvider.initHive();
  // await Hive.openBox('userBox'); // فتح صندوق Hive لتخزين بيانات المستخدم

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => SoundService()),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
      ],
      child: const ChatWithGeminiApp(),
    ),
  );
}

class ChatWithGeminiApp extends StatelessWidget {
  const ChatWithGeminiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
