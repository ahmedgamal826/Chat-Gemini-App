import 'package:flutter/material.dart';

Widget BuildSwitchListTile(
  BuildContext context, {
  required String title,
  required bool value,
  required Function(bool) onChanged,
  required bool isDarkMode,
}) {
  return SwitchListTile(
    title: Text(
      title,
      style: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black,
        fontSize: 18,
      ),
    ),
    value: value,
    onChanged: onChanged,
    activeColor: Colors.blueAccent,
    inactiveThumbColor: Colors.grey,
  );
}
