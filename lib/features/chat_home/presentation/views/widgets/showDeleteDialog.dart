import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showDeleteDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.question,
    animType: AnimType.topSlide,
    title: 'Confirm Deletion',
    desc: 'Are you sure you want to delete this item?',
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
