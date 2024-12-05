import 'package:chat_with_gemini_app/core/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class RowBottomMessage extends StatefulWidget {
  const RowBottomMessage({
    super.key,
    required this.timeSent,
    required this.message,
  });

  final DateTime timeSent;
  final String message;

  @override
  State<RowBottomMessage> createState() => _RowBottomMessageState();
}

class _RowBottomMessageState extends State<RowBottomMessage> {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;

  // تشغيل النص بصوت بناءً على اللغة
  Future<void> _speak(String text) async {
    // تحديد اللغة افتراضيًا أو بناءً على النص
    if (text.contains(RegExp(r'[ا-ي]'))) {
      await _flutterTts.setLanguage("ar-SA"); // اللغة العربية
    } else if (text.contains(RegExp(r'[a-zA-Z]'))) {
      await _flutterTts.setLanguage("en-US"); // اللغة الإنجليزية
    } else if (text.contains(RegExp(r'[а-яА-Я]'))) {
      await _flutterTts.setLanguage("ru-RU"); // اللغة الروسية
    } else {
      await _flutterTts.setLanguage("en-US"); // افتراضي: الإنجليزية
    }

    await _flutterTts.setPitch(1.0); // تعيين مستوى الصوت
    await _flutterTts.speak(text);

    setState(() {
      _isPlaying = true;
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  Future<void> _stop() async {
    await _flutterTts.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  String _formatTime(DateTime time) {
    int hour = time.hour % 12;
    hour = hour == 0 ? 12 : hour;
    String minute = time.minute.toString().padLeft(2, '0');
    String period = time.hour < 12 ? 'AM' : 'PM';

    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _formatTime(widget.timeSent),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (_isPlaying) {
                  _stop();
                } else {
                  _speak(widget.message);
                }
              },
              icon: Icon(
                _isPlaying ? Icons.stop : Icons.volume_up,
                color: Colors.white,
                size: 22,
              ),
            ),
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.message));
                CustomSnackBar.showSuccessSnackBar(
                  context,
                  'Message copied to clipboard!',
                );
              },
              icon: const Icon(
                Icons.copy,
                color: Colors.white,
                size: 22,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}
