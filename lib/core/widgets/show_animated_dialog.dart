import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showAnimatedDialog({
  required String title,
  required BuildContext context,
  required VoidCallback onConfirm,
  required String description,
}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.question,
    animType: AnimType.topSlide,
    title: title,
    desc: description,
    btnCancelOnPress: () {},
    btnOkOnPress: onConfirm,
    titleTextStyle: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    descTextStyle: const TextStyle(fontSize: 18),
    btnOkColor: Colors.red,
    btnCancelColor: Colors.grey,
  ).show();
}
