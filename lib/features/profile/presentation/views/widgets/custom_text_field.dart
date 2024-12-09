import 'package:flutter/material.dart';

Widget CustomTextField(
  BuildContext context, {
  required String label,
  required TextEditingController controller,
  required Function(String) onChanged,
  required bool isDarkMode,
}) {
  return Container(
    decoration: BoxDecoration(
      color: isDarkMode ? Colors.black45 : Colors.grey[200], // Color for fill
      borderRadius: BorderRadius.circular(12), // Rounded corners
      boxShadow: [
        BoxShadow(
          color: isDarkMode
              ? const Color.fromARGB(255, 98, 94, 94).withOpacity(0.6)
              : Colors.grey.withOpacity(0.3),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
    ),
    child: TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isDarkMode ? Colors.white70 : Colors.black87,
        ),
        filled: true, // Enables the fill color
        fillColor: const Color.fromARGB(
            0, 218, 179, 179), // Transparent fill for more styling
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12), // Rounded corners for the input border
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode
                ? Colors.blueAccent
                : Colors.blueAccent.withOpacity(0.8),
          ),
        ),
        prefixIcon: Icon(
          label == 'Name' ? Icons.person : Icons.email,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      style: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    ),
  );
}
