import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class ProtestScreen extends StatefulWidget {
  const ProtestScreen({super.key});

  @override
  State<ProtestScreen> createState() => _ProtestScreenState();
}

class _ProtestScreenState extends State<ProtestScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController coreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: cTheme,
      home: Consumer2<ThemeChanger, LanguageChanger>(
          builder: (_, tChanger, languageChanger, child) {
            lChanger=languageChanger.data;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: cTheme.backgroundColor,
            appBar: customAppbar(cTheme.backgroundColor, lChanger[16]["title"], cTheme.primaryColorDark, context),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: wid>500?CrossAxisAlignment.end:CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: wid,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: cTheme.primaryColorLight,
                          borderRadius: BorderRadius.all(Radius.circular(35),),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: wid,
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                child: Text(lChanger[16]["subtitle"], style: TextStyle(fontSize: 25, color: Colors.grey.shade700),),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            customTextFields(titleController, lChanger[16]["ph1"], cTheme.primaryColorDark, cTheme.primaryColorDark, cTheme.backgroundColor, 25, 1),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(child: customTextFields(coreController, lChanger[16]["ph2"], cTheme.primaryColorDark, cTheme.primaryColorDark, cTheme.backgroundColor, 25, null)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    mainBtn(wid>600?wid*0.35-80:wid-40, wid>600?62.0:72.0, cTheme.primaryColor, lChanger[16]["btn"], () {
                      // Navigator.of(context).pop();
                      cofirmationCustomAlertDialog(cTheme.primaryColorLight, cTheme.primaryColorDark, lChanger[16]["popTitle"], lChanger[16]["popSubtitle"], lChanger[16]["agreeBtn"], lChanger[16]["declineBtn"], context, (){}, (){});
                      }),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
