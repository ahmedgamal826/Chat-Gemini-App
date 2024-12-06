// sound_service.dart
import 'package:flutter_tts/flutter_tts.dart';

class SoundService {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;

  // دالة لتحديد اللغة والنطق
  Future<void> speak(String text) async {
    String languageCode = await _getLanguageCode(text);

    await _flutterTts.setLanguage(languageCode); // تعيين اللغة
    await _flutterTts.setPitch(1.0); // تعيين مستوى الصوت
    await _flutterTts.speak(text);

    _isPlaying = true;

    // تعيين حدث اكتمال النطق
    _flutterTts.setCompletionHandler(() {
      _isPlaying = false;
    });
  }

  // دالة لإيقاف الصوت
  Future<void> stop() async {
    await _flutterTts.stop();
    _isPlaying = false;
  }

  // دالة لاكتشاف اللغة بناءً على النص
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

  // دالة للتحقق من حالة اللعب (هل الصوت قيد التشغيل)
  bool get isPlaying => _isPlaying;
}
