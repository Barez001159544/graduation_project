import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class TaxiServices extends StatefulWidget {
  const TaxiServices({super.key});

  @override
  State<TaxiServices> createState() => _TaxiServicesState();
}

// bool isDark = true;
// ThemeData cTheme = isDark ? lightTheme : darkTheme;

class _TaxiServicesState extends State<TaxiServices> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer<LanguageChanger>(
          builder: (_, languageChanger, __) {
            lChanger= languageChanger.data;
            return Directionality(
              textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
              backgroundColor: cTheme.backgroundColor,
              appBar: customAppbar(cTheme.backgroundColor, lChanger[10]["title"], cTheme.primaryColorDark, context),
              body: SafeArea(
                child: Center(
                  child: Flex(
                    direction: or?Axis.horizontal:Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Image.asset("images/car-taxi.png", fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 10,
                            decoration: BoxDecoration(
                              color: cTheme.primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(lChanger[10]["subtitle"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: cTheme.primaryColorDark),),
                          SizedBox(
                            height: 10,
                          ),
                          Text(lChanger[10]["subtitle2"], style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark), textAlign: TextAlign.center,),
                          SizedBox(
                            height: 30,
                          ),
                          mainBtn(wid>600?wid*0.35-80:wid-40, wid>600?62.0:72.0, cTheme.primaryColor, lChanger[10]["btn"], () {
                            setState(() {
                              //
                            });
                          }),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
                        ),
            );
        }
      );
  }
}
