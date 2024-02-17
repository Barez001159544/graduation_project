import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingIndicator extends StatelessWidget {
  final Color color;
  const LoadingIndicator(this.color);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100),),
          color: color,//cTheme.backgroundColor,
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
}