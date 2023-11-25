import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/presentation/forgot_password_reset.dart';

import '../custom theme data/themes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

bool isDark=true;
ThemeData cTheme = isDark?lightTheme:darkTheme;
PageController pageController= PageController();

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    List views=[
      Container(
        margin: EdgeInsets.symmetric(horizontal: wid<500?0:wid-(wid-300)),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: wid,
                  child: Text("Recover Password", style: TextStyle(fontFamily: "NotoSans", fontSize: 28, color: cTheme.primaryColorDark),),
                ),
                Container(
                  width: wid,
                  child: Text("Please enter your phone number", style: TextStyle(fontFamily: "NotoSans", color: Colors.grey.shade700),),
                ),
                SizedBox(
                  height: 10,
                ),
                Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    customDropDownMenu(120.0, 30.0, ["IRAQ +964", "USA +006"], null, (val) {}),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: loginFields(TextEditingController(), false, "Enter phone number", cTheme.primaryColorDark, cTheme.primaryColorDark),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                mainBtn(wid>500?wid*0.35-80:wid*0.5, wid>500?62.0:72.0, cTheme.primaryColor, "SEND", () {
                  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                    return ForgotPasswordReset();
                  }));
                }),
              ],
            ),
            GestureDetector(
              onTap: (){
                pageController.page!=1?pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ):print("END");
              },
              child: Container(
                color: Colors.transparent,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Try Your G-Mail", style: TextStyle(color: cTheme.primaryColorDark),),
                      Icon(Icons.arrow_drop_down, color: cTheme.primaryColorDark,),
                    ],
                  ),
              ),
            ),
          ],
        ),
      ),
      Column(
        children: [
          GestureDetector(
            onTap: (){
              pageController.page!=0?pageController.previousPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ):print("END");
            },
            child: Container(
              margin: EdgeInsets.only(top: 50),
              color: Colors.transparent,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Try Your Phone Number", style: TextStyle(color: cTheme.primaryColorDark),),
                  Icon(Icons.arrow_drop_up, color: cTheme.primaryColorDark,),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: wid,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                color: cTheme.primaryColorLight,
              ),
              margin: EdgeInsets.only(top: 100),
              child: Container(
                width: wid<500?wid:500,
                padding: EdgeInsets.symmetric(horizontal: wid<500?20:wid-(wid-300)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: wid,
                      child: Text("Recover Password", style: TextStyle(fontFamily: "NotoSans", fontSize: 28, color: cTheme.primaryColorDark),),
                    ),
                    Container(
                      width: wid,
                      child: Text("Please enter your G-Mail", style: TextStyle(fontFamily: "NotoSans", color: Colors.grey.shade700),),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                        Flexible(
                          child: loginFields(TextEditingController(), false, "Enter G-Mail", cTheme.primaryColorDark, cTheme.primaryColorDark),
                        ),
                    SizedBox(
                      height: 60,
                    ),
                    mainBtn(wid>500?wid*0.35-80:wid*0.5, wid>500?62.0:72.0, cTheme.primaryColor, "SEND", () {
                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                        return ForgotPasswordReset();
                      }));
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: cTheme,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          leading: Builder(
            builder: (BuildContext){
              return IconButton(onPressed: (){
                Navigator.of(context).pop();
              },
                icon: Icon(Icons.keyboard_arrow_left_rounded, color: cTheme.primaryColorDark,),
              );
            },
          ),
        ),
        backgroundColor: cTheme.backgroundColor,
        body: SafeArea(
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
              itemCount: 2,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, index){
                return views[index];
              }),
        ),
      ),
    );
  }
}

