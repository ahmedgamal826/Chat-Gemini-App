import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SoundService extends ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  String? _currentPlayingMessage;

  bool isPlaying(String message) => _currentPlayingMessage == message;

  Future<void> speak(String message, String text) async {
    if (text.isEmpty) return;

    if (_currentPlayingMessage != null && _currentPlayingMessage != message) {
      await stop(_currentPlayingMessage!);
    }

    String languageCode = await _getLanguageCode(text);
    try {
      await _flutterTts.setLanguage(languageCode);
      await _flutterTts.setPitch(1.0);
      await _flutterTts.speak(text);

      _currentPlayingMessage = message;
      notifyListeners();

      _flutterTts.setCompletionHandler(() {
        _currentPlayingMessage = null;
        notifyListeners();
      });
    } catch (e) {
      print("Error in SoundService: $e");
    }
  }

  Future<void> stop(String message) async {
    try {
      await _flutterTts.stop();
      if (_currentPlayingMessage == message) {
        _currentPlayingMessage = null;
      }
      notifyListeners();
    } catch (e) {
      print("Error stopping sound: $e");
    }
  }

  Future<String> _getLanguageCode(String text) async {
    if (text.contains(RegExp(r'[ا-ي]'))) {
      return "ar-SA"; // اللغة العربية
    } else if (text.contains(RegExp(r'[a-zA-Z]'))) {
      return "en-US"; // اللغة الإنجليزية
    } else if (text.contains(RegExp(r'[а-яА-Я]'))) {
      return "ru-RU"; // اللغة الروسية
    } else if (text.contains(RegExp(r'[çğıöşüÇĞİÖŞÜ]'))) {
      return "tr-TR"; // اللغة التركية
    } else if (text.contains(RegExp(r'[éèêëàâäöôü]'))) {
      return "fr-FR"; // اللغة الفرنسية
    } else if (text.contains(RegExp(r'[éèàùç]'))) {
      return "fr-CA"; // اللغة الفرنسية الكندية
    } else if (text.contains(RegExp(r'[éáíóúñ]'))) {
      return "es-ES"; // اللغة الإسبانية
    } else if (text.contains(RegExp(r'[ščžč]'))) {
      return "hr-HR"; // اللغة الكرواتية
    } else if (text.contains(RegExp(r'[äöüß]'))) {
      return "de-DE"; // اللغة الألمانية
    } else if (text.contains(RegExp(r'[中文]'))) {
      return "zh-CN"; // اللغة الصينية
    } else if (text.contains(RegExp(r'[हिंदी]'))) {
      return "hi-IN"; // اللغة الهندية
    } else if (text.contains(RegExp(r'[ญี่ปุ่น]'))) {
      return "ja-JP"; // اللغة اليابانية
    } else if (text.contains(RegExp(r'[한국어]'))) {
      return "ko-KR"; // اللغة الكورية
    } else if (text.contains(RegExp(r'[pt]'))) {
      return "pt-PT"; // اللغة البرتغالية
    } else if (text.contains(RegExp(r'[ar]'))) {
      return "ar-SA"; // اللغة العربية
    } else if (text.contains(RegExp(r'[el]'))) {
      return "el-GR"; // اللغة اليونانية
    } else if (text.contains(RegExp(r'[th]'))) {
      return "th-TH"; // اللغة التايلاندية
    } else if (text.contains(RegExp(r'[vi]'))) {
      return "vi-VN"; // اللغة الفيتنامية
    } else if (text.contains(RegExp(r'[pl]'))) {
      return "pl-PL"; // اللغة البولندية
    } else if (text.contains(RegExp(r'[ru]'))) {
      return "ru-RU"; // اللغة الروسية
    } else {
      return "en-US"; // الافتراضي: الإنجليزية
    }
  }
}
