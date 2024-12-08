import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  late Box userBox;
  String name = 'Username';
  String email = 'Email';
  File? image;
  bool isDarkMode = false;

  ProfileProvider() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    userBox = await Hive.openBox('userBox');
    name = userBox.get('name', defaultValue: 'اسم المستخدم');
    email = userBox.get('email', defaultValue: 'البريد الإلكتروني');
    final imagePath = userBox.get('imagePath', defaultValue: '');
    isDarkMode = userBox.get('isDarkMode', defaultValue: false);

    if (imagePath.isNotEmpty) {
      image = File(imagePath);
    }
    notifyListeners();
  }

  Future<void> saveUserData() async {
    await userBox.put('name', name);
    await userBox.put('email', email);
    if (image != null) {
      await userBox.put('imagePath', image!.path);
    }
    await userBox.put('isDarkMode', isDarkMode);

    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      await userBox.put('imagePath', pickedFile.path);
      notifyListeners();
    }
  }

  void toggleDarkMode() async {
    isDarkMode = !isDarkMode;
    await userBox.put('isDarkMode', isDarkMode);
    notifyListeners();
  }
}
