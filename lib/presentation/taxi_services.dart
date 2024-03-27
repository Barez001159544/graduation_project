import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../constants/custom_appbar.dart';
import '../constants/main_btn.dart';
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
                backgroundColor: cTheme.scaffoldBackgroundColor,
                appBar: CustomAppBar( cTheme.scaffoldBackgroundColor, lChanger[10]["title"], cTheme.primaryColorDark, context), ///Color(0xff08A99F)
                body: SafeArea(
                  child: Center(
                    child: SizedBox(
                      width: wid>600?wid/2:wid-20,
                      height: hei-100,
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                                width: wid,
                                // height: wid,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: cTheme.primaryColorLight,
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  // image: DecorationImage(
                                  //   scale: 2,
                                  //   image: AssetImage("images/payment.png",),
                                  // ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      scale: 2,
                                      "images/car-taxi.png",
                                    ),
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: Text("Monthly Fee")),
                                  ],
                                ),
                              )
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: wid,
                            padding: EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              color: cTheme.primaryColorLight,
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(lChanger[10]["subtitle"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: cTheme.primaryColorDark),),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(lChanger[10]["subtitle2"], style: TextStyle(fontSize: 12, color: cTheme.primaryColorDark), textAlign: TextAlign.center,),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                MainBtn(wid, wid>600?62.0:72.0, cTheme.primaryColor, lChanger[10]["btn"],
                                      () async {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
        }
      );
  }
}
