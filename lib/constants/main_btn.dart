import 'package:flutter/material.dart';

class MainBtn extends StatelessWidget {
  final double wid;
  final double hei;
  final Color color;
  final String text;
  final VoidCallback onTapFunction;
  const MainBtn(this.wid, this.hei, this.color, this.text, this.onTapFunction());
  @override
  Widget build(BuildContext context) {
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
}