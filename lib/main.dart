import 'dart:async';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/presentation/login_screen.dart';
import 'package:graduation_project/presentation/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   // Future<Widget> getToken() async {
//   //   String? rToken= await Auth().ReadToken();
//   //   return Future.value(rToken==null?Login():UserDetails());
//   // }
//   @override
//   Widget build(BuildContext context) {
//     // precacheImage(AssetImage("lib/images/007-boy-2.jpg"), context);
//     // precacheImage(AssetImage("lib/images/10780304_19197030.png"), context);
//     // precacheImage(AssetImage("lib/images/11667132_20943447.png"), context);
//     // precacheImage(AssetImage("lib/images/11668286_20945170.png"), context);
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: SafeArea(
//           child: EasySplashScreen(
//             logo: Image.asset("lib/images/007-boy-2.jpg"),
//             logoWidth: 40,
//             backgroundColor: Color(0xff31344A),
//             title: Text("Facebook", style: TextStyle(color: Colors.white, fontSize: 26, fontFamily: "NotoSans"),),
//             navigator: OnboardingScreen(),
//             durationInSeconds: 1,
//             showLoader: false,
//           ),
//         ),
//       ),
//     );
//   }
// }


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    // LoginScreen(),
                OnboardingScreen(),
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Color(0xff31344A),
        body: Container(
          // color: Colors.green,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff155E7D),
                Color(0xff0B2F3F),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: SvgPicture.asset(
                        height: 40,
                        width: 40,
                        "images/007-boy-2.svg",
                        semanticsLabel: 'App logo'
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Facebook", style: TextStyle(color: Colors.white, fontSize: 26, fontFamily: "NotoSans"),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

