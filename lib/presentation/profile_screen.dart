import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/theme_changer.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../custom theme data/themes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

// bool isDark = true;
// ThemeData cTheme = isDark ? lightTheme : darkTheme;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: cTheme,
      home:
           Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: cTheme.backgroundColor,
            appBar: customAppbar(cTheme.primaryColorLight, "Profile", cTheme.primaryColorDark, context),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: wid,
                      height: or?hei-156:hei-176,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      // color: Colors.deepPurple,
                      decoration: BoxDecoration(
                        color: cTheme.primaryColorLight,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: or?NeverScrollableScrollPhysics():ScrollPhysics(),
                        child: Flex(
                          direction: or?Axis.horizontal:Axis.vertical,
                          mainAxisAlignment: or?MainAxisAlignment.spaceAround:MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: or?wid*0.25:wid,
                              padding: EdgeInsets.only(left: or?0:0),
                              // color: Colors.yellow,
                              child: Align(
                                alignment: or?Alignment.centerLeft:Alignment.center,
                                child: Container(
                                  width: wid>500?hei/3:wid/2,
                                  height: wid>500?hei/3:wid/2,
                                  decoration: BoxDecoration(
                                    color: cTheme.primaryColor,
                                    image: DecorationImage(
                                      image: AssetImage("images/007-boy-2.jpg"),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(1000),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // (or && hei>600)?SizedBox(height: 100,):SizedBox(),
                            SizedBox(
                              height: or?hei-200:hei-116,
                              child: SingleChildScrollView(
                                physics: or?ScrollPhysics():NeverScrollableScrollPhysics(),
                                child: Column(
                                  children: [
                                    profileItem("Name", cTheme.primaryColor, cTheme.primaryColorDark, or?wid*0.6:wid, TextEditingController(text: "John Doe"), false),
                                    profileItem("Phone Number", cTheme.primaryColor, cTheme.primaryColorDark, or?wid*0.6:wid, TextEditingController(text: "0751 123 4567"), false),
                                    profileItem("G-Mail", cTheme.primaryColor, cTheme.primaryColorDark, or?wid*0.6:wid, TextEditingController(text: "example@gmail.com"), false),
                                    profileItem("Password", cTheme.primaryColor, cTheme.primaryColorDark, or?wid*0.6:wid, TextEditingController(text: "Password"), true),
                                    profileItem("More1", cTheme.primaryColor, cTheme.primaryColorDark, or?wid*0.6:wid, TextEditingController(text: "Whatever"), false),
                                    profileItem("More2", cTheme.primaryColor, cTheme.primaryColorDark, or?wid*0.6:wid, TextEditingController(text: "Whatever"), false),
                                    profileItem("More3", cTheme.primaryColor, cTheme.primaryColorDark, or?wid*0.6:wid, TextEditingController(text: "Whatever"), false),
                                    profileItem("More4", cTheme.primaryColor, cTheme.primaryColorDark, or?wid*0.6:wid, TextEditingController(text: "Whatever"), false),
                                    profileItem("More5", cTheme.primaryColor, cTheme.primaryColorDark, or?wid*0.6:wid, TextEditingController(text: "Whatever"), false),
                                    profileItem("More6", cTheme.primaryColor, cTheme.primaryColorDark, or?wid*0.6:wid, TextEditingController(text: "Whatever"), false),
                                    profileItem("More7", cTheme.primaryColor, cTheme.primaryColorDark, or?wid*0.6:wid, TextEditingController(text: "Whatever"), false),
                                    profileItem("More8", cTheme.primaryColor, cTheme.primaryColorDark, or?wid*0.6:wid, TextEditingController(text: "Whatever"), false),
                                    profileItem("More9", cTheme.primaryColor, cTheme.primaryColorDark, or?wid*0.6:wid, TextEditingController(text: "Whatever9"), false),
                                    profileItem("More10", cTheme.primaryColor, cTheme.primaryColorDark, or?wid*0.6:wid, TextEditingController(text: "Whatever10"), false),
                                  ],
                                ),
                              ),
                            ),
                            // profileItem("label", wid, Icon(Icons.edit_rounded),),
                            // profileItem("label", wid, Icon(Icons.edit_rounded),),
                            // profileItem("label", wid, Icon(Icons.edit_rounded),),
                            // profileItem("label", wid, Icon(Icons.edit_rounded),),

                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: wid>500?500:wid,
                      height: or?100:120,
                      child: Center(
                        child: mainBtn(wid>600?wid*0.35-80:wid-40, wid>600?62.0:72.0, cTheme.primaryColor, "SAVE", () {
                          print("SAVE");
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

Widget profileItem(String hint, Color cursorColor, Color txtColor, double wid,TextEditingController controller, bool obText){
  return SizedBox(
    width: wid>500?500:wid,
    child: TextField(
      controller: controller,
      cursorColor: cursorColor,
      obscureText: obText,
      style: TextStyle(
        color: txtColor,
      ),
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.edit_rounded, color: Colors.grey,),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1, color: Colors.grey, style: BorderStyle.solid,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1, color: Color(0xff155E7D), style: BorderStyle.solid,
          ),
        ),
        // border: InputBorder.none,
      ),
    ),
  );
}