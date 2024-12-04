import 'dart:io';

import 'package:chat_with_gemini_app/core/provider/chat_provider.dart';
import 'package:chat_with_gemini_app/features/chat_home/data/models/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagesPreviewWidget extends StatelessWidget {
  ImagesPreviewWidget({this.message});

  final Message? message;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        final imagesShow =
            message != null ? message!.imagesUrls : chatProvider.imagesFileList;
        final padding = message != null
            ? EdgeInsets.zero
            : const EdgeInsets.only(right: 8, left: 8);
        return Padding(
          padding: padding,
          child: SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imagesShow.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(
                        message != null
                            ? message!.imagesUrls[index]
                            : chatProvider.imagesFileList[index].path,
                      ),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
