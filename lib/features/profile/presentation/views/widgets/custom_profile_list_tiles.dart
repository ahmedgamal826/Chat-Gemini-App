import 'package:chat_with_gemini_app/features/profile/data/Providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget CustomProfileListTiles(
  BuildContext context, {
  required String title,
  required bool value,
  required Function(bool) onChanged,
  required bool isDarkMode,
  required Function() onDeleteAllPressed,
}) {
  final profileProvider = Provider.of<ProfileProvider>(context);
  return Column(
    children: [
      Card(
        color: profileProvider.isDarkMode
            ? Colors.grey.withOpacity(0.1)
            : Colors.blueAccent.withOpacity(0.8),
        child: ListTile(
          leading: Icon(
            value ? Icons.nightlight_round : Icons.wb_sunny,
            color: value ? Colors.blueAccent : Colors.white,
            size: 30,
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          trailing: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blueAccent,
            inactiveThumbColor: Colors.grey,
          ),
          onTap: () {
            onChanged(!value);
          },
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Card(
        color: profileProvider.isDarkMode
            ? Colors.grey.withOpacity(0.1)
            : Colors.blueAccent.withOpacity(0.8),
        child: ListTile(
          leading: Icon(
            Icons.delete,
            color: isDarkMode ? Colors.blueAccent : Colors.white,
            size: 27,
          ),
          title: const Text(
            'Delete All',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onTap: onDeleteAllPressed, // عند الضغط على "Delete All"
        ),
      ),
    ],
  );
}
