import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/presentation/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Future<Widget> getToken() async {
  //   String? rToken= await Auth().ReadToken();
  //   return Future.value(rToken==null?Login():UserDetails());
  // }
  @override
  Widget build(BuildContext context) {
    // precacheImage(AssetImage("lib/images/007-boy-2.jpg"), context);
    // precacheImage(AssetImage("lib/images/10780304_19197030.png"), context);
    // precacheImage(AssetImage("lib/images/11667132_20943447.png"), context);
    // precacheImage(AssetImage("lib/images/11668286_20945170.png"), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: EasySplashScreen(
            logo: Image.asset("lib/images/007-boy-2.jpg"),
            logoWidth: 40,
            backgroundColor: Color(0xff31344A),
            title: Text("Facebook", style: TextStyle(color: Colors.white, fontSize: 26, fontFamily: "NotoSans"),),
            navigator: OnboardingScreen(),
            durationInSeconds: 1,
            showLoader: false,
          ),
        ),
      ),
    );
  }
}
