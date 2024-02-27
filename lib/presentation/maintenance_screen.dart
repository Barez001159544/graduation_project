import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../constants/confirmation_custom_alert_dialog.dart';
import '../constants/custom_dropdown_menu.dart';
import '../constants/custom_textfields.dart';
import '../constants/custom_appbar.dart';
import '../constants/main_btn.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController coreController = TextEditingController();
  String? maintainType=null;
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer2<ThemeChanger, LanguageChanger>(
        builder: (_, tChanger, languageChanger, child) {
          lChanger=languageChanger.data;
          return Directionality(
            textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: cTheme.backgroundColor,
              appBar: CustomAppBar(cTheme.backgroundColor, "Maintenance", cTheme.primaryColorDark, context),
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
                          margin: wid>600?EdgeInsets.symmetric(horizontal: wid*0.1, vertical: hei*0.1):EdgeInsets.symmetric(horizontal: wid*0.05, vertical: hei*0.1),
                          decoration: BoxDecoration(
                            color: cTheme.primaryColorLight,
                            borderRadius: BorderRadius.all(Radius.circular(35),),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: wid,
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                child: Text(lChanger[16]["subtitle"], style: TextStyle(fontSize: 20, color: Colors.grey.shade700),),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // CustomTextFields(titleController, lChanger[16]["ph1"], cTheme.primaryColorDark, cTheme.primaryColorDark, cTheme.backgroundColor, 25, 1),
                              CustomDropDownMenu("What exactly do you require?", wid, 50, 25, cTheme.backgroundColor, cTheme.primaryColorDark, ["KRD", "ARB", "ENG"], maintainType, (val){
                                setState(() {
                                  maintainType=val;
                                  print(val);
                                });
                              }),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(child: CustomTextFields(coreController, lChanger[16]["ph2"], cTheme.primaryColorDark, cTheme.primaryColorDark, cTheme.backgroundColor, 25, null)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MainBtn(wid>600?wid*0.35-80:wid-40, wid>600?62.0:72.0, cTheme.primaryColor, lChanger[16]["btn"], () {
                        // Navigator.of(context).pop();
                        ConfirmationCustomAlertDialog(cTheme.primaryColorLight, cTheme.primaryColorDark, lChanger[16]["popTitle"], lChanger[16]["popSubtitle"], lChanger[16]["agreeBtn"], lChanger[16]["declineBtn"], context, (){}, (){}, cTheme.primaryColor);
                      }),
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
