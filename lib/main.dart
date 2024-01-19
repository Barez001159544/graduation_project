import 'dart:async';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/controllers/get_payment.dart';
import 'package:graduation_project/controllers/get_token.dart';
import 'package:graduation_project/controllers/language_changer.dart';
import 'package:graduation_project/controllers/theme_changer.dart';
import 'package:graduation_project/custom%20theme%20data/themes.dart';
import 'package:graduation_project/presentation/about_app.dart';
import 'package:graduation_project/presentation/community_screen.dart';
import 'package:graduation_project/presentation/fib_login.dart';
import 'package:graduation_project/presentation/payment_scanner_screen.dart';
import 'package:graduation_project/presentation/payment_screen.dart';
import 'package:graduation_project/presentation/forgot_password_reset.dart';
import 'package:graduation_project/presentation/forgot_password_screen.dart';
import 'package:graduation_project/presentation/forgot_password_success.dart';
import 'package:graduation_project/presentation/home_screen.dart';
import 'package:graduation_project/presentation/login_screen.dart';
import 'package:graduation_project/presentation/onboarding_screen.dart';
import 'package:graduation_project/presentation/home_screen.dart';
import 'package:graduation_project/presentation/profile_screen.dart';
import 'package:graduation_project/presentation/repair_screen.dart';
import 'package:graduation_project/presentation/services_screen.dart';
import 'package:graduation_project/presentation/services_screen.dart';
import 'package:graduation_project/presentation/settings_screen.dart';
import 'package:graduation_project/presentation/payment_screen.dart';
import 'package:graduation_project/presentation/home_screen.dart';
import 'package:graduation_project/presentation/taxi_home.dart';
import 'package:graduation_project/presentation/taxi_onway.dart';
import 'package:graduation_project/presentation/taxi_services.dart';
import 'package:graduation_project/tokenManager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) =>ThemeChanger(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context)=>LanguageChanger(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context)=>GetToken(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context)=>GetPayment(),
        ),
      ],
      child: MyApp(),
    ),
  );
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
    return ScreenUtilInit(
        minTextAdapt: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_ , child) {
        return MaterialApp(
          locale: Locale("ar"),
          home: MyHomePage(),
          debugShowCheckedModeBanner: false,
        );
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  getToken() async {
    String? rToken= await TokenManager().readToken();
    // print(rToken);
    Timer(Duration(seconds: 1),
      ()=>Navigator.of(context, rootNavigator: false).pushReplacement(MaterialPageRoute(builder:
          (context,) =>
      rToken==null?FIBLogin():PaymentScannerScreen(),
        // OnboardingScreen(),
      ),),
      //     ()=>Navigator.pushReplacement(context,
      //   MaterialPageRoute(builder:
      //       (context,) =>
      //   getToken()==null?FIBLogin():HomeScreen(),
      //     // OnboardingScreen(),
      //   ),
      // ),
    );
    // print(rToken);
  }
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ThemeChanger>(context, listen: false).getDefaultTheme();
      Provider.of<LanguageChanger>(context, listen: false).readJson();
      // Provider.of<GetToken>(context, listen: false).readToken();
      // Map<String, dynamic> decodedToken = {};
      // Map<String, dynamic> jwtToken;
      // Map<String, dynamic> getDecodedToken() {
      //   jwtToken = Provider.of<GetToken>(context, listen: false).dToken;
      //   print(jwtToken);
      //   return jwtToken;
      // }
      // decodedToken= getDecodedToken();
      // print(decodedToken);
    });
    getToken();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
      );
  }
}

