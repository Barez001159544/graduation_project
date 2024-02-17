import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/presentation/community_screen.dart';
import 'package:graduation_project/presentation/login_screen.dart';
import 'package:graduation_project/presentation/payment_screen.dart';
import 'package:graduation_project/presentation/profile_screen.dart';
import 'package:graduation_project/presentation/services_screen.dart';
import 'package:graduation_project/presentation/settings_screen.dart';
import 'package:graduation_project/presentation/support_screen.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'constants/confirmation_custom_alert_dialog.dart';
import 'controllers/get_token.dart';
import 'controllers/language_changer.dart';
import 'controllers/theme_changer.dart';
import 'custom theme data/themes.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    // double wid1= wid>600?wid*0.9/2-20:wid;
    // double hei1= wid>600?wid*0.5:hei/2;
    // double wid2= wid>600?wid*0.9/2-20:wid;
    // double hei2= wid>600?wid*0.5:hei/2;
    double wid1= wid>600?wid/2.2:wid;
    double hei1= wid>600?wid/2.2:hei/2;
    double wid2= wid>600?wid/2.2:wid;
    double hei2= wid>600?wid/2.2:hei/2;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer2<LanguageChanger, GetToken>(
        builder: (_, languageChanger, getToken, __) {
          lChanger= languageChanger.data;
          return Directionality(
              textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
          backgroundColor: cTheme.backgroundColor,
          body: SafeArea(
            child: Center(
              child: Flex(
                direction: wid>600?Axis.horizontal:Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      width: wid1,
                      height: hei1,
                      // color: Colors.blue,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          wid>600?Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  print("Log Out");
                                  ConfirmationCustomAlertDialog(cTheme.primaryColorLight, cTheme.primaryColorDark, lChanger[16]["popTitle"], lChanger[16]["popSubtitle"], lChanger[16]["agreeBtn"], lChanger[16]["declineBtn"], context, (){
                                    getToken.deleteToken("accessToken");
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                                      return LoginScreen();
                                    }), (route) => false);
                                  }, (){}, cTheme.primaryColor);
                                },
                                child: Container(
                                  height: hei1*0.25,
                                  width: hei1*0.25,
                                  decoration: BoxDecoration(
                                    color: cTheme.primaryColorLight,
                                    borderRadius: BorderRadius.all(Radius.circular(17.sp),),
                                  ),
                                  child: RotatedBox(
                                    quarterTurns: languageChanger.selectedLanguage=="ENG"?90:0,
                                      child: Icon(Icons.logout_rounded, color: Colors.red, size: 13.sp,)),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return ProfileScreen();
                                  }));
                                },
                                child: Container(
                                  height: hei1*0.25,
                                  width: hei1*0.25,
                                  padding: EdgeInsets.all(12.sp),
                                  decoration: BoxDecoration(
                                    color: cTheme.primaryColorLight,
                                    borderRadius: BorderRadius.all(Radius.circular(17.sp),),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: cTheme.primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100.sp),
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage("images/007-boy-2.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                      border: Border.all(
                                        width: 3,
                                        color: cTheme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return SettingsScreen();
                                  }));
                                },
                                child: Container(
                                  height: hei1*0.25,
                                  width: hei1*0.25,
                                  decoration: BoxDecoration(
                                    color: cTheme.primaryColorLight,
                                    borderRadius: BorderRadius.all(Radius.circular(17.sp),),
                                  ),
                                  child: Icon(Icons.settings_rounded, color: cTheme.primaryColorDark, size: 13.sp,),
                                ),
                              )
                            ],
                          ):Container(
                            width: wid,
                            height: 100,
                            decoration: BoxDecoration(
                              color: cTheme.primaryColorLight,
                              borderRadius: BorderRadius.all(Radius.circular(35),),
                            ),
                            padding: EdgeInsets.only(left: languageChanger.selectedLanguage=="ENG"?20:10, right: languageChanger.selectedLanguage=="ENG"?10:20),
                            // margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // GestureDetector(
                                //   onTap: (){
                                //     Navigator.push(context, MaterialPageRoute(builder: (context){
                                //       return ProfileScreen();
                                //     }));
                                //   },
                                //   child: Container(
                                //     width: 80,
                                //     height: 80,
                                //     decoration: BoxDecoration(
                                //       color: cTheme.primaryColor,
                                //       borderRadius: BorderRadius.all(
                                //         Radius.circular(30),
                                //       ),
                                //       image: DecorationImage(
                                //         image: AssetImage("images/007-boy-2.jpg"),
                                //         fit: BoxFit.cover,
                                //       ),
                                //       border: Border.all(
                                //         width: 1,
                                //         color: Colors.black
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(lChanger[6]["welcome"].toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, color: cTheme.primaryColorDark.withOpacity(0.8),),),
                                    Text("John Doe".toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, color: cTheme.primaryColorDark, fontWeight: FontWeight.bold,),),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return SettingsScreen();
                                    }));
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    // margin: EdgeInsets.only(left: index==0?0:10),
                                    decoration: BoxDecoration(
                                      color: cTheme.primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Icon(Icons.settings_rounded, color: Colors.white, size: 35,),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: wid>600?15.sp:20,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return PaymentScreen();
                                }));
                              },
                              child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(hei1*0.1),
                                    ),
                                    gradient: LinearGradient(
                                        colors: [
                                          cTheme.primaryColor,
                                          Color(0xff7895a6),
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        textDirection: TextDirection.ltr,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("14000\$/Month", textDirection: TextDirection.ltr, style: TextStyle(fontFamily: "Roboto", fontSize: hei1*0.05, color: Colors.white),),
                                          Container(
                                            width: hei1*0.15,
                                            height: hei1*0.15,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(100.sp),
                                              ),
                                            ),
                                            child: Center(
                                              child: Icon(CupertinoIcons.arrow_up_right, size: hei1*0.16,),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        textDirection: TextDirection.ltr,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("8 months = 112000\$", textDirection: TextDirection.ltr, style: TextStyle(color: Colors.white, fontSize: hei1*0.05, fontFamily: "Roboto"),),
                                          SizedBox(
                                            height: wid>600?1.sp:10,
                                          ),
                                          Row(
                                            textDirection: TextDirection.ltr,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Stack(
                                                alignment: Alignment.centerLeft,
                                                children: [
                                                  Container(
                                                    height: hei1*0.07,
                                                    width: wid1*0.7,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(100),
                                                      ),
                                                      color: Color(0xff749CAD),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: hei1*0.07,
                                                    width: (wid1*0.7)*(8/10),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(100),
                                                        topRight: Radius.circular(25),
                                                        bottomLeft: Radius.circular(100),
                                                        bottomRight: Radius.circular(25),
                                                      ),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xff749CAD),
                                                          Colors.white,
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ),
                                                    ),
                                                  ).animate().scaleX(duration: 1.seconds, curve: Curves.easeOut),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("8/10 mo",textDirection: TextDirection.ltr, style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: "Roboto"),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ),
                          ),
                          SizedBox(
                            height: wid>600?15.sp:20,
                          ),
                          wid>600?Container(
                            width: wid,
                            height: wid1*0.1,
                            decoration: BoxDecoration(
                              color: cTheme.primaryColorLight,
                              borderRadius: BorderRadius.all(Radius.circular(10.sp),),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(lChanger[6]["faq"], style: TextStyle(color: cTheme.primaryColorDark),),
                                Text("FAQ", style: TextStyle(color: cTheme.primaryColorDark, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ):SizedBox(),
                        ],
                      ),
                    ).animate().slideY(duration: 2.seconds, curve: Curves.linearToEaseOut),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: wid2,
                    height: hei2,
                    padding: EdgeInsets.all(10),
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return CommunityScreen();
                                }));
                              },
                              child: badges.Badge(
                                badgeContent: Text("1", style: TextStyle(color: cTheme.primaryColorDark),),
                                showBadge: true,
                                child: Container(
                                  width: wid2/2-20,
                                  height: hei2/2-20,
                                  decoration: BoxDecoration(
                                    color: cTheme.primaryColorLight,
                                    borderRadius: BorderRadius.all(Radius.circular(wid>600?20.sp:45.sp),),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.personalhotspot, color: cTheme.primaryColor, size: 40,),
                                      SizedBox(height: 10,),
                                      Text(lChanger[6]["community"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return ServicesScreen();
                                }));
                              },
                              child: badges.Badge(
                                badgeContent: Text("1", style: TextStyle(color: cTheme.primaryColorDark),),
                                showBadge: false,
                                child: Container(
                                  width: wid2/2-20,
                                  height: hei2/2-20,
                                  decoration: BoxDecoration(
                                    color: cTheme.primaryColorLight,
                                    borderRadius: BorderRadius.all(Radius.circular(wid>600?20.sp:45.sp),),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.rectangle_grid_2x2_fill, color: cTheme.primaryColor, size: 40,),
                                      SizedBox(height: 10,),
                                      Text(lChanger[6]["services"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return SupportCenter();
                                }));
                              },
                              child: badges.Badge(
                                badgeContent: Text("1", style: TextStyle(color: cTheme.primaryColorDark),),
                                showBadge: true,
                                child: Container(
                                  width: wid2/2-20,
                                  height: hei2/2-20,
                                  decoration: BoxDecoration(
                                    color: cTheme.primaryColorLight,
                                    borderRadius: BorderRadius.all(Radius.circular(wid>600?20.sp:45.sp),),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.chat_bubble_2, color: cTheme.primaryColor, size: 40,),
                                      SizedBox(height: 10,),
                                      Text(lChanger[6]["chat"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return ProfileScreen();
                                }));
                              },
                              child: Container(
                                width: wid2/2-20,
                                height: hei2/2-20,
                                decoration: BoxDecoration(
                                  color: cTheme.primaryColorLight,
                                  borderRadius: BorderRadius.all(Radius.circular(wid>600?20.sp:45.sp),),
                                  image: DecorationImage(
                                    image: AssetImage("images/city1-removebg-preview.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.transparent,
                                        Color(0x77343434),
                                        Colors.black,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(wid>600?20.sp:45.sp),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.chevron_up, color: Colors.white, size: 25,).animate(onComplete: (controller)=> controller.loop(reverse: true)).moveY(curve: Curves.easeInOut, duration: 2.seconds),
                                      Text(lChanger[6]["area"], style: TextStyle(color: Colors.white, fontSize: 16),),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ).animate().slideY(duration: 2.seconds, curve: Curves.linearToEaseOut, begin: 1),
                ],
              ),
            ),
          ),
        ),);
      }
    );
  }
}
