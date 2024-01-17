import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:graduation_project/presentation/payment_screen.dart';

Widget mainBtn(double wid, double hei, color, String text, void onTapFunction()){
  return GestureDetector(
    onTap: (){
      onTapFunction();
    },
    child: Container(
      width: wid,//wid>600?wid*0.35-80:wid*0.5,
      height: hei,//wid>600?62:72,
      decoration: BoxDecoration(
        color: color,//cTheme.primaryColor,//Color(0xff155E7D),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: Center(
        child: Text(
          "$text".toUpperCase(),
          style: TextStyle(
              fontSize: 20, color: Colors.white),
        ),
      ),
    ),
  );
}

Widget customDropDownMenu(double wid, double height, List<String>? items, String? value, void onChange(val),) {
  return Container(
    width: wid,
    height: height,
    padding: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      color: Color(0xfff8f8f8),
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton(
        dropdownColor: Color(0xfff8f8f8),
        isExpanded: true,
        disabledHint: Text("Code", style: TextStyle(fontFamily: "NotoSans"),),
        hint: Text("Code", style: TextStyle(fontFamily: "NotoSans"),),
        value: value != null ? value : null,
        style: TextStyle(color: Colors.black),
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          size: 30,
          color: Colors.black54,
        ),
        items: List<String>.from(items as Iterable)
            .map((String itemss) {
          return DropdownMenuItem(
            value: itemss,
            child: Center(
                child: Text(
                  itemss,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: "NotoSans"),
                )),
          );
        }).toList(),
        onChanged: (val) {
          onChange(val);
        },
      ),
    ),
  );
}

Widget loginFields(TextEditingController controller, bool isShown, String hint, Color primaryColor, Color textColor){
  return TextField(
    controller: controller,
    obscureText: isShown,
    cursorColor: primaryColor,
    textAlignVertical: TextAlignVertical.bottom,
    style: TextStyle(
      color: primaryColor,
      fontSize: hint=="### ####"?24:16,
    ),
    decoration: InputDecoration(
      hintText: "$hint",
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: hint=="### ####"?24:14,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1, color: Colors.grey, style: BorderStyle.solid,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1, color: Color(0xff155E7D), style: BorderStyle.solid,
        ),
      ),
    ),
  );
}

AppBar customAppbar(Color bgColor, String title, Color titleColor, BuildContext context){
  return AppBar(
    backgroundColor: bgColor,
    scrolledUnderElevation: 0,
    title: Text(title, style: TextStyle(color: titleColor),),
    centerTitle: true,
    leading: Builder(
      builder: (BuildContext){
        return IconButton(onPressed: (){
          Navigator.of(context).pop();
        },
          icon: Icon(Icons.arrow_back_rounded, color: titleColor,),
        );
      },
    ),
  );
}

Widget loadingIndicator(){
  return Center(
    child: Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100),),
        color: Colors.white,
      ),
      child: Center(
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100),),
            color: Colors.green,
          ),
        ).animate(onComplete: (controller)=> controller.loop(reverse: true)).scale(begin: Offset(0.5, 0.5), curve: Curves.easeInOut, duration: 2.seconds),
      ),
    ),
  );
}

Future cofirmationCustomAlertDialog(
    Color bgColor,
    Color txtColor,
    String title,
    String message,
    String btnMessage,
    String btnMessage2,
    ctx,
    void onGotIt(),
    void onDecline()) {
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
              // Navigator.of(ctx).pop();
            },
            child: Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: cTheme.primaryColor,
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
              // Navigator.of(ctx).pop();
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