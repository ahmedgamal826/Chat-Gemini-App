import 'package:chat_with_gemini_app/core/widgets/custom_snack_bar.dart';
import 'package:chat_with_gemini_app/features/profile/presentation/views/widgets/animated_image_container.dart';
import 'package:chat_with_gemini_app/features/profile/presentation/views/widgets/animation_button.dart';
import 'package:chat_with_gemini_app/features/profile/presentation/views/widgets/custom_text_field.dart';
import 'package:chat_with_gemini_app/features/profile/presentation/views/widgets/custom_profile_list_tiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_with_gemini_app/features/profile/data/Providers/profile_provider.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      backgroundColor:
          profileProvider.isDarkMode ? const Color(0xff1E1E1E) : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: profileProvider.isDarkMode
            ? Colors.grey[900]
            : Colors.blueAccent.withOpacity(0.8),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              profileProvider.isDarkMode
                  ? Icons.nightlight_round
                  : Icons.wb_sunny,
              color: Colors.white,
            ),
            onPressed: () {
              profileProvider.toggleDarkMode();
            },
          ),
        ],
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const AnimatedImageContatiner(),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  label: 'Name',
                  controller: TextEditingController(text: profileProvider.name),
                  onChanged: (value) {
                    profileProvider.name = value;
                  },
                  isDarkMode: profileProvider.isDarkMode,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  context,
                  label: 'Email',
                  controller:
                      TextEditingController(text: profileProvider.email),
                  onChanged: (value) {
                    profileProvider.email = value;
                  },
                  isDarkMode: profileProvider.isDarkMode,
                ),
                const SizedBox(height: 20),
                CustomProfileListTiles(
                  onDeleteAllPressed: () {
                    profileProvider.clearProfileData();
                  },
                  context,
                  title: 'Dark Mode',
                  value: profileProvider.isDarkMode,
                  onChanged: (value) {
                    profileProvider.toggleDarkMode();
                  },
                  isDarkMode: profileProvider.isDarkMode,
                ),
                const SizedBox(height: 50),
                AnimatedButton(
                  onPressed: () async {
                    await profileProvider.saveUserData();

                    CustomSnackBar.showSuccessSnackBar(
                        context, 'Changes saved successfully!');
                  },
                  isDarkMode: profileProvider.isDarkMode,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
