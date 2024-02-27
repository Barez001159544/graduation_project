import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/controllers/get_payment.dart';
import 'package:graduation_project/controllers/get_token.dart';
import 'package:graduation_project/controllers/language_changer.dart';
import 'package:graduation_project/controllers/theme_changer.dart';
import 'package:graduation_project/custom%20theme%20data/themes.dart';
import 'package:graduation_project/presentation/about_app.dart';
import 'package:graduation_project/presentation/community_screen.dart';
import 'package:graduation_project/presentation/fib_login.dart';
import 'package:graduation_project/presentation/maintenance_screen.dart';
import 'package:graduation_project/presentation/payment_scanner_screen.dart';
import 'package:graduation_project/presentation/payment_screen.dart';
import 'package:graduation_project/presentation/forgot_password_reset.dart';
import 'package:graduation_project/presentation/forgot_password_screen.dart';
import 'package:graduation_project/presentation/forgot_password_success.dart';
import 'package:graduation_project/presentation/home_screen.dart';
import 'package:graduation_project/presentation/login_screen.dart';
import 'package:graduation_project/presentation/onboarding_screen.dart';
import 'package:graduation_project/presentation/home_screen.dart';
import 'package:graduation_project/presentation/payment_test.dart';
import 'package:graduation_project/presentation/profile_screen.dart';
import 'package:graduation_project/presentation/protest_screen.dart';
import 'package:graduation_project/presentation/repair_screen.dart';
import 'package:graduation_project/presentation/services_screen.dart';
import 'package:graduation_project/presentation/services_screen.dart';
import 'package:graduation_project/presentation/settings_screen.dart';
import 'package:graduation_project/presentation/payment_screen.dart';
import 'package:graduation_project/presentation/home_screen.dart';
import 'package:graduation_project/presentation/support_screen.dart';
import 'package:graduation_project/presentation/taxi_home.dart';
import 'package:graduation_project/presentation/taxi_onway.dart';
import 'package:graduation_project/presentation/taxi_services.dart';
import 'package:graduation_project/test.dart';
import 'package:graduation_project/tokenManager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runApp(
    AppInfo(
      data: await AppInfoData.get(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => ThemeChanger(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => LanguageChanger(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => GetToken(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => GetPayment(),
          ),
        ],
        child: DevicePreview(
          enabled: !kReleaseMode,
          tools: [
            ...DevicePreview.defaultTools
          ],
          builder: (context)=>const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData cTheme =
        Provider.of<ThemeChanger>(context).isDark ? darkTheme : lightTheme;
    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (_, child) {
          return MaterialApp(
            theme: cTheme,
            locale: const Locale("ar"),
            home: const MyHomePage(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('firstTime');
    String? rToken = await TokenManager().readToken("accessToken");
    Timer(
      const Duration(seconds: 1),
      () => Navigator.of(context, rootNavigator: false).pushReplacement(
        MaterialPageRoute(
          builder: (
            context,
          ) =>
              // const ServicesScreen(),
          firstTime==false?(rToken==null?const LoginScreen():const Test()):const OnboardingScreen(),
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ThemeChanger>(context, listen: false).getDefaultTheme();
      Provider.of<LanguageChanger>(context, listen: false).readJson();
      Provider.of<GetToken>(context, listen: false).readToken("accessToken");
      // print(">>>>>>>>>>>>>>>${Provider.of<GetToken>(context, listen: false).dToken}");
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
    return const SplashWidget();
  }
}

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
