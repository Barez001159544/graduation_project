import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/presentation/fib_login.dart';
import 'package:graduation_project/presentation/payment_screen.dart';
import 'package:graduation_project/presentation/profile_screen.dart';
import 'package:graduation_project/presentation/services_screen.dart';
import 'package:graduation_project/presentation/settings_screen.dart';
import 'package:provider/provider.dart';

import '../controllers/get_token.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// bool isDark=true;
// ThemeData cTheme = isDark?lightTheme:darkTheme;
List servicesIcons=[
  Icons.handyman_rounded,
  Icons.local_taxi_rounded,
  Icons.phone_rounded,
  Icons.more_horiz_rounded,
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    // bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    double wid1=wid>600?hei/2:wid;
    double hei1=wid>600?hei/2:wid;
    double wid2=wid>600?(wid-(hei/2)):wid;
    double hei2=wid>600?hei/2:300;
    double wid3=wid>600?hei/2:wid;
    double hei3=wid>600?hei/2:wid;
    double wid4=wid>600?(wid-(hei/2)):wid;
    double hei4=wid>600?hei/2:hei*0.6;
    SystemChrome.setPreferredOrientations([
      wid>600?DeviceOrientation.landscapeLeft:DeviceOrientation.portraitUp,
      wid>600?DeviceOrientation.landscapeRight:DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: cTheme,
      home: Consumer2<LanguageChanger, GetToken>(
        builder: (_, languageChanger, getToken, __) {
          lChanger= languageChanger.data;
          return Directionality(
            textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              backgroundColor: cTheme.backgroundColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Flex(
                        direction: wid>600?Axis.horizontal:Axis.vertical,
                        children: [
                          wid>600?Container(
                            // color: Colors.red,
                            width: wid1,
                            height: hei1,
                            padding: EdgeInsets.all(10),
                            child: Flex(
                                direction: Axis.vertical,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return ProfileScreen();
                                      }));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: wid>600?10.sp:30.sp),
                                      decoration: BoxDecoration(
                                        color: cTheme.primaryColorLight,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(wid>600?25.sp:70.sp),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Hero(
                                            tag: 1,
                                            child: Container(
                                              width: wid>600?40.sp:100.sp,
                                              height: wid>600?40.sp:100.sp,
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
                                                  width: 4,
                                                  color: cTheme.primaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "John Doe",
                                                  style: TextStyle(color: cTheme.primaryColorDark, fontWeight: FontWeight.bold, fontSize: wid>600?8.sp:16.sp,)
                                              ),
                                              Text(
                                                "example@gmail.com",
                                                  style: TextStyle(color: Colors.grey, fontSize: wid>600?6.sp:14.sp)
                                              ),
                                              Text(
                                                "0123 456 7890",
                                                  style: TextStyle(color: Colors.grey, fontSize: wid>600?6.sp:14.sp)
                                              ),
                                              // Flexible(child: Container(child: Text(overflow: TextOverflow.ellipsis,"John Doe", style: TextStyle(color: cTheme.primaryColorDark, fontWeight: FontWeight.bold, fontSize: 20,),))),
                                              // Flexible(child: Container(child: Text(overflow: TextOverflow.ellipsis,"example@gmail.com", style: TextStyle(color: Colors.grey, fontSize: 16),))),
                                              // Flexible(child: Container(child: Text(overflow: TextOverflow.ellipsis,"0123 456 7890", style: TextStyle(color: Colors.grey, fontSize: 16),))),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                  width: 10,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return SettingsScreen();
                                      }));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: cTheme.primaryColorLight,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(wid>600?25.sp:70.sp),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(lChanger[6]["settings"].toUpperCase(), style: TextStyle(fontSize: wid>600?10.sp:22.sp, color: Colors.grey,),),
                                          SizedBox(
                                            height: wid>600?5.sp:20.sp,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: List.generate(3, (index){
                                              return Container(
                                                width: wid>600?29.sp:80.sp,
                                                height: wid>600?29.sp:80.sp,
                                                // margin: EdgeInsets.only(left: index==0?0:10),
                                                decoration: BoxDecoration(
                                                  color: cTheme.primaryColor,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(100.sp),
                                                  ),
                                                ),
                                                child: Icon(index==0?Icons.edit_rounded:(index==1?Icons.question_mark_rounded:CupertinoIcons.arrow_up_right), color: Colors.white, size: wid>600?20.sp:46.sp,),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ):Container(
                            width: wid,
                            height: 100,
                            decoration: BoxDecoration(
                              color: cTheme.primaryColorLight,
                              borderRadius: BorderRadius.all(Radius.circular(35),),
                            ),
                            padding: EdgeInsets.only(left: languageChanger.selectedLanguage=="ENG"?20:10, right: languageChanger.selectedLanguage=="ENG"?10:20),
                            margin: EdgeInsets.all(10),
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
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return PaymentScreen();
                              }));
                            },
                            child: Container(
                              width: wid2,
                              height: hei2,
                              // color: Colors.green,
                              child: Container(
                                height: hei2,
                                width: wid2,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(wid>500?30:20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(wid>500?25.sp:60),
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
                                        Text("14000\$/Month", style: TextStyle(fontFamily: "Roboto", fontSize: wid>600?12.sp:24.sp, color: Colors.white),),
                                        Container(
                                          width: wid>600?40.sp:80.sp,
                                          height: wid>600?40.sp:80.sp,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(100.sp),
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(CupertinoIcons.arrow_up_right, size: wid>600?30.sp:70.sp,),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      textDirection: TextDirection.ltr,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("8 months = 112000\$", style: TextStyle(color: Colors.white, fontSize: wid>600?12.sp:24.sp, fontFamily: "Roboto"),),
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
                                                  height: 30,
                                                  width: wid>600?wid2*0.6:wid-130,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(100),
                                                    ),
                                                    color: Color(0xff749CAD),
                                                  ),
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: wid>600?(wid2*0.6)*(8/10):(wid-130)*(8/10),
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
                                            Text("8/10 mo", style: TextStyle(color: Colors.white, fontSize: wid>600?7.sp:10.sp, fontFamily: "Roboto"),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Flex(
                        direction: wid>600?Axis.horizontal:Axis.vertical,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return ProfileScreen();
                              }));
                            },
                            child: Container(
                              width: wid3,
                              height: hei3,
                              // color: Colors.blue,
                              child: Container(
                                height: hei3,
                                width: wid3,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(wid>600?25.sp:60),
                                  ),
                                  color: cTheme.primaryColorLight,
                                  image: DecorationImage(
                                    image: AssetImage("images/city1.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(wid>600?5.sp:20.sp),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                        Color(0x77343434),
                                        Colors.black,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(wid>600?25.sp:60),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.chevron_up, color: Colors.white, size: wid>600?12.sp:32.sp,).animate(onComplete: (controller)=> controller.loop(reverse: true)).moveY(curve: Curves.easeInOut, duration: 2.seconds),
                                      Text(lChanger[6]["area"], style: TextStyle(color: Colors.white, fontSize: wid>600?10.sp:24.sp),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: wid4,
                            height: wid>600?hei4:(hei4).sp,
                            // color: Colors.deepPurple,
                            child: Column(
                              children: [
                                threeBtns(2000, wid>600?hei4/3-20:(hei4/4).sp, cTheme.primaryColorLight, null, languageChanger.selectedLanguage=="ENG"?EdgeInsets.only(left: wid>600?10.sp:30.sp,):EdgeInsets.only(right: wid>600?10.sp:30.sp),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(wid>600?35:30.sp),),
                                      // color: Colors.red,
                                      image: DecorationImage(
                                        alignment: Alignment.centerRight,
                                        image: AssetImage("images/art 01.png"),
                                        opacity: wid>500?1:0,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      mainAxisAlignment: wid>500?MainAxisAlignment.spaceBetween:MainAxisAlignment.start,
                                      crossAxisAlignment: wid>500?CrossAxisAlignment.center:CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(lChanger[6]["comTitle"].toUpperCase(), style: TextStyle(fontSize: wid>600?6.sp:20.sp, fontWeight: FontWeight.bold, color: cTheme.primaryColorDark),),
                                            Text(lChanger[6]["comSubtitle"], style: TextStyle(fontSize: wid>600?4.sp:14.sp, color: Colors.grey),),
                                          ],
                                        ),
                                        // Image.asset("images/Group 19.png", fit: BoxFit.cover,),
                                        // wid>500?Container(
                                        //   width: ((hei*0.6)/2),
                                        //   height: (((hei-(hei*0.5))/3)-(50)/3)-30,
                                        //   decoration: BoxDecoration(
                                        //     color: cTheme.primaryColor,
                                        //     borderRadius: BorderRadius.all(
                                        //       Radius.circular(30),
                                        //     ),
                                        //   ),
                                        //   child: Row(
                                        //     mainAxisAlignment: MainAxisAlignment.center,
                                        //     children: [
                                        //       Text("Check out", style: TextStyle(color: Colors.white, fontSize: 16)),
                                        //       Icon(Icons.chevron_right_rounded, color: Colors.white, size: 26),
                                        //     ],
                                        //   ),
                                        // ):SizedBox(),
                                      ],
                                    ),
                                  ), (){
                                    print("Community Engagement Functionality");
                                  },
                                ),
                                threeBtns(2000, wid>600?hei4/3-20:(hei4/2-60).sp, cTheme.primaryColorLight, null, languageChanger.selectedLanguage=="ENG"?EdgeInsets.only(left: wid>600?10.sp:30.sp, right: wid>600?10:0):EdgeInsets.only(right: wid>600?10.sp:30.sp, left: wid>600?10:0),
                                  Flex(
                                    direction: wid>600?Axis.horizontal:Axis.vertical,
                                    mainAxisAlignment: wid>600?MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
                                    crossAxisAlignment: wid>600?CrossAxisAlignment.center:CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(lChanger[6]["serTitle"].toUpperCase(), style: TextStyle(fontSize: wid>600?6.sp:20.sp, fontWeight: FontWeight.bold, color: cTheme.primaryColorDark),),
                                          Text(lChanger[6]["serSubtitle"], style: TextStyle(fontSize: wid>600?4.sp:14.sp, color: Colors.grey),),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment: wid>600?MainAxisAlignment.spaceAround:MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: List.generate(4, (index) {
                                          return Container(
                                            width: wid>600?25.sp:60.sp,
                                            height: wid>600?25.sp:60.sp,
                                            margin: languageChanger.selectedLanguage=="ENG"?EdgeInsets.only(right: index==3?0:10):EdgeInsets.only(left: index==3?0:10),
                                            decoration: BoxDecoration(
                                              color: Color(index==0?0xff6B67E7:(index==1?0xffE76767:(index==2?0xff74E767:0xff679EE7))),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(wid>600?10.sp:20.sp),
                                              ),
                                            ),
                                            child: Icon(servicesIcons[index], color: Colors.white,),
                                          );
                                        }),
                                      ),
                                    ],
                                  ), (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                      return ServicesScreen();
                                    }));
                                  },
                                ),
                                threeBtns(2000, wid>600?hei4/3-20:(hei4/4).sp, cTheme.primaryColor, LinearGradient(
                                  colors: [
                                    cTheme.primaryColor,
                                    Color(0xff7895a6),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ), EdgeInsets.symmetric(horizontal: 0.sp),
                                  Center(
                                      child: Text(wid>600?lChanger[6]["bigBtn1"].toUpperCase():lChanger[6]["bigBtn2"].toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: wid>600?10.sp:20.sp, color: Colors.white, ), textAlign: TextAlign.center,),
                                  ),(){
                                    print("Some Large Heading Functionality");
                                  },
                                ),
                              ],
                            ),
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
      ),
    );
  }
}

Widget threeBtns(double wid, double hei, Color bgColor, LinearGradient? lg, EdgeInsets padding, Widget widgetChild, void onTap()){
  return GestureDetector(
    onTap: (){
      onTap();
    },
    child: Container(
      width: wid,
      height: hei,
      padding: padding,
      margin: EdgeInsets.all(wid>600?10:10.sp),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(
          Radius.circular(wid>600?35:40.sp),
        ),
        gradient: lg,
        image: lg!=null?DecorationImage(
          image: AssetImage("images/chevron-right.png"),
          opacity: 0.1,
          // fit: BoxFit.cover,
          alignment: Alignment.centerRight,
          repeat: ImageRepeat.repeatX,
        ):null,
      ),
      child: widgetChild,
    ),
  );
}