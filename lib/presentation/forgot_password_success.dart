import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/presentation/login_screen.dart';
import 'package:provider/provider.dart';

import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

// bool isDark=true;
// ThemeData cTheme = isDark?lightTheme:darkTheme;

class ForgotPasswordSuccess extends StatelessWidget {
  const ForgotPasswordSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    return MaterialApp(
      theme: cTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: cTheme.backgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: wid<500?wid-100:500,
                  height: wid<500?wid-100:500,
                  decoration: BoxDecoration(
                    color: cTheme.primaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.all(
                      Radius.circular(1000),
                    ),
                  ),
                  child: Icon(Icons.check_rounded, color: cTheme.primaryColor, size: wid<500?wid-250:300,),
                ).animate().scale(duration: 2.seconds, curve: Curves.fastEaseInToSlowEaseOut),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Password reset complete", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: cTheme.primaryColorDark),),
              Text("Your password reset was successful. You can now proceed to login to your account.", textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.grey),),
              SizedBox(
                height: 30,
              ),
              mainBtn(wid>500?wid*0.35-80:wid-40, wid>500?62.0:72.0, cTheme.primaryColor, "LOGIN", () {
                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                  return LoginScreen();
                }));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
