import 'dart:async';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/controllers/get_engineering.dart';
import 'package:graduation_project/controllers/get_protests.dart';
import 'package:graduation_project/controllers/get_get_self.dart';
import 'package:graduation_project/controllers/get_payment.dart';
import 'package:graduation_project/controllers/get_repairment.dart';
import 'package:graduation_project/controllers/get_token.dart';
import 'package:graduation_project/controllers/get_user_payments.dart';
import 'package:graduation_project/controllers/get_user_properties.dart';
import 'package:graduation_project/controllers/get_what_is_paid.dart';
import 'package:graduation_project/controllers/language_changer.dart';
import 'package:graduation_project/controllers/theme_changer.dart';
import 'package:graduation_project/custom%20theme%20data/themes.dart';
import 'package:graduation_project/models/auth_request.dart';
import 'package:graduation_project/models/auth_response.dart';
import 'package:graduation_project/presentation/about_app.dart';
import 'package:graduation_project/presentation/engineering_screen.dart';
import 'package:graduation_project/presentation/faq_screen.dart';
import 'package:graduation_project/presentation/refresh_login.dart';
import 'package:graduation_project/presentation/splash_widget.dart';
import 'package:graduation_project/presentation/protest_new.dart';
import 'package:graduation_project/presentation/payment_scanner_screen.dart';
import 'package:graduation_project/presentation/payment_screen.dart';
import 'package:graduation_project/presentation/home_screen.dart';
import 'package:graduation_project/presentation/login_screen.dart';
import 'package:graduation_project/presentation/onboarding_screen.dart';
import 'package:graduation_project/presentation/profile_screen.dart';
import 'package:graduation_project/presentation/properties_screen.dart';
import 'package:graduation_project/presentation/protest_history.dart';
import 'package:graduation_project/presentation/repair_new.dart';
import 'package:graduation_project/presentation/settings_screen.dart';
import 'package:graduation_project/presentation/payment_screen.dart';
import 'package:graduation_project/presentation/home_screen.dart';
import 'package:graduation_project/constants/tokenManager.dart';
import 'package:graduation_project/services/user/user.dart';
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
          ChangeNotifierProvider(
            create: (BuildContext context)=> GetEngineering(),
          ),
          // ChangeNotifierProvider(
          //   create: (BuildContext context)=> GetAuth(),
          // ),
          // ChangeNotifierProvider(
          //   create: (BuildContext context)=> GetPaymentStatus(),
          // ),
          // ChangeNotifierProvider(
          //   create: (BuildContext context)=> GetFIBAuth(),
          // ),
          ChangeNotifierProvider(
              create: (BuildContext context)=> GetGetSelf(),
          ),
          // ChangeNotifierProvider(
          //   create: (BuildContext context)=> GetUpdateUserController(),
          // ),
          ChangeNotifierProvider(
            create: (BuildContext context)=> GetUserProperties(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context)=> GetProtests(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context)=> GetRepairment(),
          ),
          ChangeNotifierProvider(
              create: (BuildContext context)=>GetWhatIsPaid(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context)=>GetUserPayments(),
          ),
        ],
        child: MyApp(),
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
  // getToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? firstTime = prefs.getBool('firstTime');
  //   String? rToken = await TokenManager().readToken("accessToken");
  //   ///---------------------------
  //   // AuthResponse? forFun= await GetAuthentication().authenticate(AuthRequest("zhya@gmail.com", "abcdef"));
  //   // print("$forFun<-------------");
  //   /// -----------------
  //   print("))))))))))$rToken");
  //   Timer(
  //     const Duration(seconds: 1),
  //     () => Navigator.of(context, rootNavigator: false).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (
  //           context,
  //         ) =>
  //             // const PropertiesScreen(),
  //         firstTime==false?(rToken==null?const LoginScreen():const HomeScreen()):const OnboardingScreen(),
  //       ),
  //     ),
  //   );
  // }

  void getToken() async {
    // Simulate some async operation to get the future boolean value
    bool? firstTime = await getFirstTime();
    String? rToken= await getRToken();
    print("&&&&&&&${rToken}");
    String? role= await getRole();
    await Future.delayed(Duration(seconds: 1)); // 6 seconds

    // Delay for 1 second before executing the navigation logic

    // Navigate based on the boolean value
    Navigator.of(context, rootNavigator: false).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            // const OnboardingScreen(),
        firstTime == false ? (rToken == null ? const LoginScreen() : (role=="Resident"?const HomeScreen():(role=="Employee"?const EngineeringScreen():const RefreshLogin()))) : const OnboardingScreen(),
      ),
    );
  }

  Future<bool?> getFirstTime() async {
    // Simulate some asynchronous operation to retrieve a boolean value
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('firstTime');
    return Future.value(firstTime);
  }

  Future<String?> getRToken() async {
    // Simulate some asynchronous operation to retrieve a String value
    String? rToken = await TokenManager().readToken("accessToken");
    // await TokenManager().deleteToken("accessToken");
    // print("deleted");
    return Future.value(rToken);
  }
  Future<String?> getRole() async {
    print("~~~~~~~~~");
    await Provider.of<GetGetSelf>(context, listen: false).getGetSelf();
    await Provider.of<GetGetSelf>(context, listen: false).getUserRoles("${Provider.of<GetGetSelf>(context, listen: false).getSelfResponse?.userDetails?.id}");
    print("************");
    print(Provider.of<GetGetSelf>(context, listen: false).rolesResponse?.roles);
    print("************");
    // Simulate some asynchronous operation to retrieve a String value
    // String? rToken = await TokenManager().readToken("accessToken");
    print("%%%%%%%%${Provider.of<GetGetSelf>(context, listen: false).getSelfResponse?.userDetails?.name}");
    // return Future.value(Provider.of<GetGetSelf>(context, listen: false).getSelfResponse?.userDetails?.name);
    //(Provider.of<GetGetSelf>(context, listen: false).rolesResponse!.roles!.contains("resident"))?"Resident":"Employee"
    return Future.value(Provider.of<GetGetSelf>(context, listen: false).getSelfResponse?.userDetails!=null?((Provider.of<GetGetSelf>(context, listen: false).rolesResponse!.roles!.contains("resident"))?"Resident":"Employee"):"None");
  // return "Resident";
  }

  final   List _allAsset = [
  "images/house_img.jpg",
  "images/building_img.jpg",
    "images/007-boy-2.jpg",
    "images/receive-money.png",
    "images/songkran.png",
  "images/onboard1.png",
  "images/onboard2.png",
  "images/onboard3.png",
    "images/rcms-logo-2.png",
        "images/rcms-logo-1.png",
        "images/houses+buildings.jpg",
  ];
  final   List _allSVGs = [
    "images/007-boy-2.svg",
    "images/fib-logo.svg",
    "images/rcms-logo-3.svg"
  ];
  @override
  initState() {
    super.initState();
    final binding = WidgetsFlutterBinding.ensureInitialized();
    binding.addPostFrameCallback((_) async {
      BuildContext context = binding.rootElement as BuildContext; //renderViewElement
        for (String element in _allSVGs) {
          SvgPicture.asset(element);
        }
      //-----------------------
      if(context != null) {
        for(var asset in _allAsset) {
          precacheImage(AssetImage(asset), context);
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ThemeChanger>(context, listen: false).getDefaultTheme();
      Provider.of<LanguageChanger>(context, listen: false).readJson();
      // Provider.of<GetToken>(context, listen: false).readToken("accessToken");
      // Provider.of<GetGetSelf>(context, listen: false).getGetSelf();
      // Provider.of<GetUserPayments>(context, listen: false).getThisMonthPayment("houses", "2");
      // Provider.of<GetUserProperties>(context, listen: false).getUserProperties();
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


