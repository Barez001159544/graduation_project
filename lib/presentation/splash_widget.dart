import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff155E7D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: SvgPicture.asset(
                  height: 40,
                  width: 40,
                  "images/007-boy-2.svg",
                  semanticsLabel: 'App logo'),
            ).animate().shimmer(duration: 3.seconds, curve: Curves.easeOut),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "RCMS",
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: "NotoSans"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}