// // import 'package:chat_with_gemini_app/features/chat_home/data/models/message.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_markdown/flutter_markdown.dart';

// // class MyMessageWidget extends StatelessWidget {
// //   const MyMessageWidget({super.key, required this.message});

// //   final Message message;

// //   @override
// //   Widget build(BuildContext context) {
// //     double width = MediaQuery.of(context).size.width;
// //     return Align(
// //       alignment: Alignment.centerRight,
// //       child: Padding(
// //         padding: const EdgeInsets.only(right: 20),
// //         child: Container(
// //           constraints: BoxConstraints(
// //             maxWidth: width * 0.7,
// //           ),
// //           decoration: BoxDecoration(
// //             color: Theme.of(context).colorScheme.primaryContainer,
// //             borderRadius: const BorderRadius.only(
// //               bottomLeft: Radius.circular(20),
// //               topLeft: Radius.circular(20),
// //               topRight: Radius.circular(20),
// //             ),
// //           ),
// //           padding: const EdgeInsets.all(15),
// //           margin: const EdgeInsets.only(bottom: 8),
// //           child: MarkdownBody(
// //             selectable: true,
// //             data: message.message.toString(),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:chat_with_gemini_app/features/chat_home/data/models/message.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';

// class MyMessageWidget extends StatelessWidget {
//   const MyMessageWidget({super.key, required this.message});

//   final Message message;

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Padding(
//         padding: const EdgeInsets.only(right: 10, bottom: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(right: 20),
//               child: Container(
//                 constraints: BoxConstraints(
//                   maxWidth: width * 0.7,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.primaryContainer,
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(20),
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 padding: const EdgeInsets.all(15),
//                 child: MarkdownBody(
//                   selectable: true,
//                   data: message.message.toString(),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 5),
//             Image.asset(
//               'assets/user.png',
//               width: MediaQuery.of(context).size.width * 0.07,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:chat_with_gemini_app/features/chat_home/data/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MyMessageWidget extends StatelessWidget {
  const MyMessageWidget({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: width * 0.7,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MarkdownBody(
                      selectable: true,
                      data: message.message.toString(),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _formatTime(message.timeSent),
                      style: Theme.of(context).textTheme.titleSmall,
                      // style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    int hour = time.hour % 12; // تحويل الساعة إلى صيغة 12 ساعة
    hour = hour == 0 ? 12 : hour; // إذا كانت الساعة 0، يتم تحويلها إلى 12
    String minute = time.minute
        .toString()
        .padLeft(2, '0'); // إضافة صفر أمام الدقائق إذا كانت أقل من 10
    String period = time.hour < 12 ? 'AM' : 'PM'; // تحديد ما إذا كان AM أو PM

    return "$hour:$minute $period";
  }
}
