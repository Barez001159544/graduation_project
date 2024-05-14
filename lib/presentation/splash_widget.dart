import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    double wid= MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      wid>600?DeviceOrientation.landscapeLeft:DeviceOrientation.portraitUp,
      wid>600?DeviceOrientation.landscapeRight:DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: const Color(0xff155E7D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Container(
              width: 200,
              height: 200,
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  "images/rcms-logo-2.png",
                ),
              ).animate().fade(delay: 1.seconds, duration: 1.seconds).then().shimmer(duration: 3.seconds, curve: Curves.easeOut, color: Colors.grey, delay: 0.seconds),
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