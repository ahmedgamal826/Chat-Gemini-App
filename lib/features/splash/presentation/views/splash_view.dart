import 'package:chat_with_gemini_app/features/profile/data/Providers/profile_provider.dart';
import 'package:chat_with_gemini_app/features/splash/data/splash_logic.dart';
import 'package:chat_with_gemini_app/features/splash/presentation/views/widgets/animated_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      backgroundColor:
          profileProvider.isDarkMode ? const Color(0xff1E1E1E) : Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LogoAnimation(width: width, height: height),
              Lottie.asset(
                'assets/gemini_lottie.json',
                width: width * 0.9,
                height: height * 0.3,
              ),
              const SizedBox(height: 20),
              AnimatedText(
                onFinished: () => SplashLogic.NavigateToChatHomeView(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
