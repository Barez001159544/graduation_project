import "package:flutter/material.dart";
import "package:graduation_project/constants.dart";
import "package:parallax_rain/parallax_rain.dart";
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
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return MaterialApp(
      theme: cTheme,
      debugShowCheckedModeBanner: false,
      home: Consumer<LanguageChanger>(
          builder: (_, languageChanger, __) {
            lChanger= languageChanger.data;
          return Scaffold(
            backgroundColor: Colors.black,
            body: Container(
              width: wid,
              height: hei,
              child: Center(
                child: ParallaxRain(
                  dropColors: [
                    cTheme.primaryColor,
                  ],
                  numberOfDrops: 80,
                  trail: true,
                  trailStartFraction: 0.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(Radius.circular(5),),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Facebook",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Multicolor",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Multicolor",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Multicolor",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5),),
                                ),
                                child: Icon(
                                  Icons.facebook,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5),),
                                ),
                                child: Icon(
                                  Icons.facebook,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5),),
                                ),
                                child: Icon(
                                  Icons.facebook,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(100),),
                          border: Border.all(
                            width: 1,
                            color: Colors.red,
                          ),
                        ),
                        child: Icon(Icons.arrow_back_rounded, color: Colors.white,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
