import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
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
    return MaterialApp(
      theme: cTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: cTheme.backgroundColor,
        appBar: customAppbar(cTheme.backgroundColor, "Taxi Services", cTheme.primaryColorDark, context),
        body: SafeArea(
          child: Center(
            child: Flex(
              direction: or?Axis.horizontal:Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(wid>480?0:50),
                    width: wid>480?400:wid,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/car-taxi.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
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
                    Text("How to get a ride?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: cTheme.primaryColorDark),),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Here, you can easily find and book\nan available taxi for your convenience.", style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark), textAlign: TextAlign.center,),
                    SizedBox(
                      height: 30,
                    ),
                    mainBtn(wid>600?wid*0.35-80:wid-40, wid>600?62.0:72.0, cTheme.primaryColor, "CONTINUE", () {
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
}
