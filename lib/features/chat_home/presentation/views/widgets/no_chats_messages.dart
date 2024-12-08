import 'package:chat_with_gemini_app/features/profile/data/Providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NoChatMessages extends StatelessWidget {
  const NoChatMessages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final profileProvider = Provider.of<ProfileProvider>(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/gemini_lottie.json',
            width: width * 0.9,
            height: height * 0.3,
          ),
          Text(
            "Let's start a new chat!",
            style: TextStyle(
              fontSize: 23,
              color: profileProvider.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
