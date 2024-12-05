import 'package:chat_with_gemini_app/core/provider/chat_provider.dart';
import 'package:chat_with_gemini_app/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:chat_with_gemini_app/features/chat_history/presentation/views/chat_history_view.dart';
import 'package:chat_with_gemini_app/features/chat_home/presentation/views/chat_home_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const ChatHistoryView(),
      const ChatHomeView(),
      const ProfileView()
    ];

    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        return Scaffold(
          body: pages[chatProvider.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xff0EA385),
            currentIndex: chatProvider.currentIndex,
            onTap: (index) {
              chatProvider.setCurrentIndex(newCurrentIndex: index);
            },
            selectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                backgroundColor: Color(0xff74AA9C),
                icon: Icon(Icons.history),
                label: 'Chat History',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  Icons.person,
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
