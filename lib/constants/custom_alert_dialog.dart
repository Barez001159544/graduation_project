import 'package:flutter/material.dart';

Future<dynamic> CustomAlertDialog(Color bgColor, Color txtColor, String title, String message, String btnMessage, bool barrierDismissible, ctx, void onGotIt(), Color color){
  return showDialog(
      context: ctx,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext contex) {
        return AlertDialog(
          actionsPadding: EdgeInsets.only(bottom: 10),
          backgroundColor: bgColor,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          icon: Icon(Icons.check_rounded, size: 80, color: Colors.green,),
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
                    // onGotIt();
                    Navigator.of(contex).pop();
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
              ],
            ),
            // TextButton(
            //   onPressed: () => Navigator.of(ctx).pop(),
            //   child: Text('Got It!', style: TextStyle(color: Colors.black),),
            // ),
          ],
        );});
}