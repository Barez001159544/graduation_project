import 'package:f_toggle_button/f_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/controllers/theme_changer.dart';
import 'package:graduation_project/presentation/forgot_password_reset.dart';
import 'package:graduation_project/presentation/profile_screen.dart';
import 'package:provider/provider.dart';

import '../custom theme data/themes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

// bool isDark = true;


class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    return MaterialApp(
      theme: cTheme,
      debugShowCheckedModeBanner: false,
      home: Consumer<ThemeChanger>(
        builder: (context, tChanger, child) {
          return Scaffold(
            appBar: customAppbar(or?cTheme.backgroundColor:cTheme.primaryColor, "Settings", or?cTheme.primaryColorDark:Colors.white, context),
            backgroundColor: cTheme.backgroundColor,
            body: SafeArea(
              child: Flex(
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
                          Hero(
                            tag: 1,
                            child: Container(
                              width: or?120:90,
                              height: or?120:90,
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
                                  "Edit Profile",
                                  style: TextStyle(color: Colors.grey),
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
                            settings("Dark Mode", cTheme.primaryColorDark,wid, FToggleButton(
                              isEnable: tChanger.isDark,
                              onChangeStatus: (bool val) {
                                // setState(() {
                                //   print(val);
                                //   // tChanger.isDark=!tChanger.isDark;
                                //   if(tChanger.isDark){
                                //     cTheme=darkTheme;
                                //   }else{
                                //     cTheme=lightTheme;
                                //   }
                                // });
                                tChanger.changeTheme();
                              },
                              bgCircleEnable: Colors.white,
                              bgCircleDisable: Color(0xff5CD254),
                              bgDisable: Color(0xffCBCBCB),
                              borderColorEnable: Colors.transparent,
                              borderColorDisEnable: Colors.transparent,
                            ),),
                            settings("Language", cTheme.primaryColorDark, wid, customDropDownMenu(100, 30, ["KRD", "ARB", "ENG"], "KRD", (val) { })),
                            settings("Notifications", cTheme.primaryColorDark, wid, FToggleButton(
                              isEnable: false,
                              onChangeStatus: (bool val) {},
                              bgCircleEnable: Colors.white,
                              bgCircleDisable: Color(0xff5CD254),
                              bgDisable: Color(0xffCBCBCB),
                              borderColorEnable: Colors.transparent,
                              borderColorDisEnable: Colors.transparent,
                            ),),
                            settings("More", cTheme.primaryColorDark, wid, FToggleButton(
                              isEnable: false,
                              onChangeStatus: (bool val) {},
                              bgCircleEnable: Colors.white,
                              bgCircleDisable: Color(0xff5CD254),
                              bgDisable: Color(0xffCBCBCB),
                              borderColorEnable: Colors.transparent,
                              borderColorDisEnable: Colors.transparent,
                            ),),
                            settings("More", cTheme.primaryColorDark, wid, FToggleButton(
                              isEnable: false,
                              onChangeStatus: (bool val) {},
                              bgCircleEnable: Colors.white,
                              bgCircleDisable: Color(0xff5CD254),
                              bgDisable: Color(0xffCBCBCB),
                              borderColorEnable: Colors.transparent,
                              borderColorDisEnable: Colors.transparent,
                            ),),
                            settings("More", cTheme.primaryColorDark, wid, FToggleButton(
                              isEnable: false,
                              onChangeStatus: (bool val) {},
                              bgCircleEnable: Colors.white,
                              bgCircleDisable: Color(0xff5CD254),
                              bgDisable: Color(0xffCBCBCB),
                              borderColorEnable: Colors.transparent,
                              borderColorDisEnable: Colors.transparent,
                            ),),
                            settings("More", cTheme.primaryColorDark, wid, FToggleButton(
                              isEnable: false,
                              onChangeStatus: (bool val) {},
                              bgCircleEnable: Colors.white,
                              bgCircleDisable: Color(0xff5CD254),
                              bgDisable: Color(0xffCBCBCB),
                              borderColorEnable: Colors.transparent,
                              borderColorDisEnable: Colors.transparent,
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
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
        Text(label, style: TextStyle(color: labelColor),),
        widgetFunction,
      ],
    ),
  );
}