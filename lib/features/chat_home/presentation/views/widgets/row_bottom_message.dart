import 'package:auto_size_text/auto_size_text.dart';
import 'package:chat_with_gemini_app/core/services/formatted_date_and_time_services.dart';
import 'package:chat_with_gemini_app/core/widgets/custom_snack_bar.dart';
import 'package:chat_with_gemini_app/features/chat_home/data/models/message.dart';
import 'package:chat_with_gemini_app/features/chat_home/data/services/sound_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RowBottomMessage extends StatefulWidget {
  const RowBottomMessage({
    super.key,
    required this.timeSent,
    required this.message,
    required this.role,
  });

  final String timeSent;
  final String message;
  final Role role;

  @override
  State<RowBottomMessage> createState() => _RowBottomMessageState();
}

class _RowBottomMessageState extends State<RowBottomMessage> {
  final SoundService _soundService = SoundService();
  final FormattedDateAndTimeServices _formattedDateAndTimeServices =
      FormattedDateAndTimeServices();

  // Method to handle the state change of sound playing
  void _toggleSound() async {
    if (_soundService.isPlaying) {
      await _soundService.stop();
    } else {
      await _soundService.speak(widget.message);
    }
    setState(() {}); // Update the UI to reflect the change
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Use Expanded to allow the text to take available space without overflow
        Expanded(
          child: AutoSizeText(
            _formattedDateAndTimeServices.formatDateTime(widget.timeSent),
            style: const TextStyle(
              color: Color.fromARGB(255, 172, 164, 164),
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 15,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            if (widget.role == Role.assistant)
              IconButton(
                onPressed: _toggleSound, // Use the method to toggle sound
                icon: Icon(
                  _soundService.isPlaying ? Icons.stop : Icons.volume_up,
                  color: widget.role == Role.assistant
                      ? Colors.white
                      : Colors.black,
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
              icon: Icon(
                Icons.copy,
                color:
                    widget.role == Role.assistant ? Colors.white : Colors.black,
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
    _soundService.stop();
    super.dispose();
  }
}
