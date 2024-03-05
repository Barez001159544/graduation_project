import 'package:flutter/material.dart';

// class ConfirmationCustomAlertDialog extends StatelessWidget {
//   final Color bgColor;
//       final Color txtColor;
//   final String title;
//       final String message;
//   final String btnMessage;
//       final String btnMessage2;
//   final BuildContext ctx;
//   final VoidCallback onGotIt;
//   final VoidCallback onDecline;
//   const ConfirmationCustomAlertDialog(this.bgColor, this.txtColor, this.title, this.message, this.btnMessage, this.btnMessage2, this.ctx, this.onGotIt, this.onDecline);
//   @override
//   Widget build(BuildContext context) {
//     return showDialog(
//         context: ctx,
//         builder: (BuildContext contex) {
//           return AlertDialog(
//             actionsPadding: EdgeInsets.all(0),
//             backgroundColor: bgColor,
//             surfaceTintColor: Colors.transparent,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             // Icon(Icons.error_rounded, size: 80, color: Color(0xffF04372),),
//             title: Text(
//               "$title",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontWeight: FontWeight.bold, color: txtColor),
//             ),
//             content: Row(
//               children: [
//                 Flexible(
//                   child: Text(
//                     "$message",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: txtColor.withOpacity(0.7),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             actionsAlignment: MainAxisAlignment.center,
//             actionsOverflowButtonSpacing: 8.0,
//             actions: [
//               Column(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       onGotIt();
//                       // Navigator.of(contex).pop();
//                     },
//                     child: Container(
//                       height: 40,
//                       margin: EdgeInsets.symmetric(horizontal: 10),
//                       decoration: BoxDecoration(
//                         color: cTheme.primaryColor,
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(20),
//                         ),
//                       ),
//                       child: Center(
//                           child: Text(
//                             '$btnMessage',
//                             style: TextStyle(
//                                 color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
//                           )),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       onDecline();
//                       Navigator.of(contex).pop();
//                     },
//                     child: Container(
//                       height: 40,
//                       margin: EdgeInsets.symmetric(vertical: 10),
//                       color: Colors.transparent,
//                       child: Center(
//                           child: Text(
//                             '$btnMessage2',
//                             style: TextStyle(
//                                 color: txtColor.withOpacity(0.7),
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold),
//                           )),
//                     ),
//                   ),
//                 ],
//               ),
//               // TextButton(
//               //   onPressed: () => Navigator.of(ctx).pop(),
//               //   child: Text('Got It!', style: TextStyle(color: Colors.black),),
//               // ),
//             ],
//           );});
//   }
// }

Future<dynamic> ConfirmationCustomAlertDialog(Color bgColor, Color txtColor, String title, String message, String btnMessage, String btnMessage2, ctx, void onGotIt(), void onDecline(), Color color){
  return showDialog(
      context: ctx,
      builder: (BuildContext contex) {
        return AlertDialog(
          actionsPadding: EdgeInsets.all(0),
          backgroundColor: bgColor,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          // Icon(Icons.error_rounded, size: 80, color: Color(0xffF04372),),
          title: Text(
            "$title",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: txtColor),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  "$message",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: txtColor.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsOverflowButtonSpacing: 8.0,
          actions: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    onGotIt();
                    // Navigator.of(contex).pop();
                  },
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: color,//cTheme.primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                        child: Text(
                          '$btnMessage',
                          style: TextStyle(
                              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onDecline();
                    Navigator.of(contex).pop();
                  },
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.transparent,
                    child: Center(
                        child: Text(
                          '$btnMessage2',
                          style: TextStyle(
                              color: txtColor.withOpacity(0.7),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ],
            ),
            // TextButton(
            //   onPressed: () => Navigator.of(ctx).pop(),
            //   child: Text('Got It!', style: TextStyle(color: Colors.black),),
            // ),
          ],
        );});
}