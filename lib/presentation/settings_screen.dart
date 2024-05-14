import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/controllers/get_get_self.dart';
import 'package:graduation_project/controllers/get_token.dart';
import 'package:graduation_project/controllers/get_user_properties.dart';
import 'package:graduation_project/controllers/language_changer.dart';
import 'package:graduation_project/controllers/theme_changer.dart';
import 'package:graduation_project/presentation/about_app.dart';
import 'package:graduation_project/presentation/login_screen.dart';
import 'package:graduation_project/presentation/properties_payment_history.dart';
import 'package:graduation_project/presentation/profile_screen.dart';
import 'package:provider/provider.dart';

import '../constants/confirmation_custom_alert_dialog.dart';
import '../constants/custom_appbar.dart';
import '../constants/custom_dropdown_menu.dart';
import '../constants/custom_switch_notification.dart';
import '../constants/custom_toast_notification.dart';
import '../constants/loading_indicator.dart';
import '../custom theme data/themes.dart';
import '../models/fully_aparments_reponse.dart';
import '../models/fully_houses_response.dart';
import 'faq_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

// bool isDark = true;


class _SettingsScreenState extends State<SettingsScreen> {

  String? selectedProperty;
  String? selectedType;
  int? selectedId;

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    return Consumer5<ThemeChanger, LanguageChanger, GetToken, GetUserProperties, GetGetSelf>(
        builder: (_, tChanger, lChanger, getToken, getUserProperties, getGetSelf, child) {
          return Directionality(
            textDirection: lChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              appBar: CustomAppBar(or?cTheme.scaffoldBackgroundColor:cTheme.primaryColor, lChanger.data[0]["title"], Colors.white, context),
              // backgroundColor: cTheme.scaffoldBackgroundColor,
              body: SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Flex(
                      direction: or?Axis.horizontal:Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: or?2:1,
                          child: Container(
                            width: 2000,
                            decoration: BoxDecoration(
                              color: cTheme.primaryColor,
                              borderRadius: or?BorderRadius.all(
                                Radius.circular(or?25:0),
                              ):BorderRadius.vertical(
                                bottom: Radius.circular(50),
                              ),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: or?20:0, vertical: or?20:0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: or?120:hei*0.11,
                                  height: or?120:hei*0.11,
                                  decoration: BoxDecoration(
                                    color: cTheme.primaryColor,
                                    image: DecorationImage(
                                      image: AssetImage("images/007-boy-2.jpg"),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return ProfileScreen();
                                    }));
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.blue,
                                        style: BorderStyle.solid,
                                      ),
                                      color: Colors.transparent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        lChanger.data[0]["gotoProfile"],
                                        style: TextStyle(color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            // color: Colors.yellow,
                            width: wid,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: or?MainAxisAlignment.center:MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  settings(lChanger.data[0]["theme"], cTheme.primaryColorDark,wid,
                                    CustomSwitchBtn(tChanger.isDark, cTheme.primaryColorLight, (val) {
                                      tChanger.changeTheme();
                                    })

                                  //   FToggleButton(
                                  //   isEnable: tChanger.isDark,
                                  //   onChangeStatus: (bool val) {
                                  //     // setState(() {
                                  //     //   print(val);
                                  //     //   // tChanger.isDark=!tChanger.isDark;
                                  //     //   if(tChanger.isDark){
                                  //     //     cTheme=darkTheme;
                                  //     //   }else{
                                  //     //     cTheme=lightTheme;
                                  //     //   }
                                  //     // });
                                  //     tChanger.changeTheme();
                                  //   },
                                  //   bgCircleEnable: Colors.white,
                                  //   bgCircleDisable: Color(0xff5CD254),
                                  //   bgDisable: Color(0xffCBCBCB),
                                  //   borderColorEnable: Colors.transparent,
                                  //   borderColorDisEnable: Colors.transparent,
                                  // ),
                                  ),
                                  settings(lChanger.data[0]["lang"], cTheme.primaryColorDark, wid, CustomDropDownMenu("Lang", 100, 30, 5, cTheme.primaryColorLight, cTheme.primaryColorDark, ["KRD", "ARB", "ENG"], lChanger.selectedLanguage, (val) {
                                    print(val);
                                    lChanger.changeLanguage(val);
                                  })),
                                // settings(lChanger.data[0]["notification"], cTheme.primaryColorDark,wid,
                                //     CustomSwitchBtn(false, cTheme.primaryColorLight, (val) {
                                //       // tChanger.changeTheme();
                                //     })),
                                  // settings("More", cTheme.primaryColorDark, wid, FToggleButton(
                                  //   isEnable: false,
                                  //   onChangeStatus: (bool val) {},
                                  //   bgCircleEnable: Colors.white,
                                  //   bgCircleDisable: Color(0xff5CD254),
                                  //   bgDisable: tChanger.isDark?cTheme.primaryColorLight:Color(0xffCBCBCB),
                                  //   borderColorEnable: Colors.transparent,
                                  //   borderColorDisEnable: Colors.transparent,
                                  // ),),
                                  // settings("More", cTheme.primaryColorDark, wid, FToggleButton(
                                  //   isEnable: false,
                                  //   onChangeStatus: (bool val) {},
                                  //   bgCircleEnable: Colors.white,
                                  //   bgCircleDisable: Color(0xff5CD254),
                                  //   bgDisable: tChanger.isDark?cTheme.primaryColorLight:Color(0xffCBCBCB),
                                  //   borderColorEnable: Colors.transparent,
                                  //   borderColorDisEnable: Colors.transparent,
                                  // ),),
                                  GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                          return FAQScreen();
                                        }));
                                      },
                                      child: settings("FAQ - ${lChanger.data[0]["faq"]}", cTheme.primaryColorDark, wid, SizedBox(),)),
                                  GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return AboutApp();
                                        }));
                                      },
                                      child: settings(lChanger.data[0]["about"], cTheme.primaryColorDark, wid,
                                        SizedBox(),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 20,
                      child: GestureDetector(
                        onTap: (){
                          print("Log Out");
                          ConfirmationCustomAlertDialog(cTheme.primaryColorLight, cTheme.primaryColorDark, lChanger.data[0]["confirmationTitle"], lChanger.data[0]["confirmationSubtitle"], lChanger.data[0]["confirmationAccept"], lChanger.data[0]["confirmationDecline"], context, () async {
                            showDialog(
                                context: context,
                                // barrierColor: cTheme.backgroundColor,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    actionsPadding: EdgeInsets.all(0),
                                    contentPadding: EdgeInsets.all(5),
                                    backgroundColor: Colors.transparent,
                                    surfaceTintColor: Colors.transparent,
                                    // shape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(45),
                                    // ),
                                    content: LoadingIndicator(cTheme.scaffoldBackgroundColor),
                                  );
                                });
                            await getGetSelf.getLogoff();
                            if(getGetSelf.logOutStatus!="Success" || getGetSelf.logOutStatus==null){
                              CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger.data[7]["notification2"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                              Navigator.of(context).pop();
                            }else{
                              getToken.deleteToken("accessToken");
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                                return LoginScreen();
                              }), (route) => false);
                            }
                          }, (){}, cTheme.primaryColor);
                        },
                        child: Container(
                          height: 50,
                          // width: 80,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: cTheme.primaryColorLight,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RotatedBox(
                                  child: Icon(Icons.logout_rounded, color: Colors.red,),
                                  quarterTurns: lChanger.selectedLanguage=="ENG"?90:0),
                              SizedBox(width: 10,),
                              Text(lChanger.data[0]["out"], style: TextStyle(color: Colors.red),),
                            ],
                          ),
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

Widget settings(String label, labelColor, double wid, Widget widgetFunction){
  return Container(
    height: 50,
    width: wid>500?500:wid,
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      // color: Colors.blue.withOpacity(0.1),
      border: Border(
        bottom: BorderSide(
          width: 1,
          color: Colors.grey,
          style: BorderStyle.solid,
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(),),
        widgetFunction,
      ],
    ),
  );
}