import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:graduation_project/presentation/login_screen.dart';
import 'package:provider/provider.dart';

import '../constants/main_btn.dart';
import '../controllers/language_changer.dart';
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
    List lChanger;
    return Consumer<LanguageChanger>(
          builder: (_, languageChanger, __) {
            lChanger= languageChanger.data;
            return Scaffold(
            backgroundColor: cTheme.scaffoldBackgroundColor,
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
                  Text(lChanger[5]["title"], style: TextStyle(fontSize: 20, color: cTheme.primaryColorDark),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(lChanger[5]["subtitle"], textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.grey),),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MainBtn(wid>500?wid*0.35-80:wid-40, wid>500?62.0:72.0, cTheme.primaryColor, lChanger[5]["btn"], () {
                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                      return LoginScreen();
                    }));
                  }),
                ],
              ),
            ),
          );
        }
      );
  }
}
