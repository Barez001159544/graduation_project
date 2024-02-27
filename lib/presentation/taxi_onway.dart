import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../constants/main_btn.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class TaxiOnWay extends StatefulWidget {
  const TaxiOnWay({super.key});

  @override
  State<TaxiOnWay> createState() => _TaxiOnWayState();
}

// bool isDark = true;
// ThemeData cTheme = isDark ? lightTheme : darkTheme;

class _TaxiOnWayState extends State<TaxiOnWay> {
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
              body: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                        colors: [
                          Color(0xff4A7B90),
                          cTheme.primaryColor,
                        ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: wid,
                        height: 80,
                        color: Colors.green,
                        child: Center(
                          child: Text(lChanger[12]["title"], style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: wid>500?80.sp:150.sp,
                            height: wid>500?80.sp:150.sp,
                            decoration: BoxDecoration(
                              color: cTheme.primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(wid>500?80.sp:150.sp),
                              ),
                              image: DecorationImage(
                                image: AssetImage("images/007-boy-2.jpg"),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                width: 6,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          Column(
                            children: [
                              Text(lChanger[12]["name"], style: TextStyle(color: Colors.white, fontSize: 12,),),
                              Text("John Doe", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                            ],
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          Column(
                            children: [
                              Text(lChanger[12]["location"], style: TextStyle(color: Colors.white, fontSize: 12,),),
                              Text("B4:F4:R123", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                      // SizedBox(),
                      MainBtn(wid>600?wid*0.35-80:wid-40, wid>600?62.0:72.0, Colors.green, "Done", () {
                        setState(() {
                          // isAvailable=!isAvailable;
                        });
                      }),
                      // SizedBox(height: 20,),
                      // Text("Tap DONE when you finish, and close other wise to quit", style: TextStyle(color: Colors.grey, fontSize: 12, height: 1),),
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
