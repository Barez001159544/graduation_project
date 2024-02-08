import "package:device_info_plus/device_info_plus.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app_info/flutter_app_info.dart";
import "package:glowy_borders/glowy_borders.dart";
import "package:graduation_project/constants.dart";
import "package:provider/provider.dart";

import "../controllers/language_changer.dart";
import "../controllers/theme_changer.dart";
import "../custom theme data/themes.dart";

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  List appInfo=[];

  @override
  Widget build(BuildContext context) {
    final info = AppInfo.of(context);
    appInfo.add(info.package.appName);
    appInfo.add(info.package.version);

    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer<LanguageChanger>(
          builder: (_, languageChanger, __) {
            lChanger= languageChanger.data;
            print(languageChanger.selectedLanguage);
          return Directionality(
            textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              backgroundColor: cTheme.backgroundColor,
              body: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedGradientBorder(
                          gradientColors: [
                            cTheme.primaryColor,
                            cTheme.primaryColor.withOpacity(0.6),
                          ],
                          borderSize: 1,
                          glowSize: 10,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          animationTime: 2,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  cTheme.primaryColor.withOpacity(0.5),
                                  cTheme.primaryColor,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black45,
                                    offset: Offset(2, 2),
                                    blurRadius: 5,
                                    spreadRadius: 0.5
                                ),
                              ],
                            ),
                            child: Icon(Icons.home_max_rounded, size: 100, color: Colors.white,),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(appInfo.length, (index) => Text(
                            "${appInfo[index]}",
                            style: TextStyle(color: cTheme.primaryColorDark, fontSize: 20),
                          ),),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 50,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(100),),
                            border: Border.all(
                              width: 1,
                              color: cTheme.primaryColorDark,
                            ),
                          ),
                          child: Icon(Icons.arrow_back_rounded, color: cTheme.primaryColorDark,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      );
  }
}



