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
              width: 150,
              height: 150,
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(
                  "images/rcms-logo-2.png",
                ),
              ).animate().shimmer(duration: 3.seconds, curve: Curves.easeOut, color: Colors.grey),
              // SvgPicture.asset(
              //     height: 40,
              //     width: 40,
              //     "images/007-boy-2.svg",
              //     semanticsLabel: 'App logo'),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "Home Management",
                style: TextStyle(
                    color: Colors.white70, fontSize: 14, fontFamily: "NotoSans"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}