import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:graduation_project/controllers/theme_changer.dart";
import "package:provider/provider.dart";

import "../constants.dart";
import "../custom theme data/themes.dart";

class TaxiHomeScreen extends StatefulWidget {
  const TaxiHomeScreen({super.key});

  @override
  State<TaxiHomeScreen> createState() => _TaxiHomeScreenState();
}

// bool isDark = true;
// ThemeData cTheme = isDark ? lightTheme : darkTheme;

class _TaxiHomeScreenState extends State<TaxiHomeScreen> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    return Consumer<ThemeChanger>(
      builder: (context, tChanger, child) {
        return MaterialApp(
          theme: cTheme,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: cTheme.backgroundColor,
            appBar: AppBar(
              backgroundColor: cTheme.primaryColorLight,
              scrolledUnderElevation: 0,
              title: Text("Taxi Driver", style: TextStyle(color: cTheme.primaryColorDark),),
              centerTitle: true,
              leading: Builder(
                builder: (BuildContext){
                  return IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  },
                    icon: RotatedBox(
                      quarterTurns: 2,
                        child: Icon(Icons.logout_rounded, color: cTheme.primaryColorDark,)),
                  );
                },
              ),
              actions: [
                Builder(
                  builder: (BuildContext){
                    return IconButton(onPressed: (){
                      // setState(() {
                      //   if(tChanger.isDark){
                      //     cTheme=darkTheme;
                      //   }else{
                      //     cTheme=lightTheme;
                      //   }
                      // });
                      tChanger.changeTheme();
                    },
                      icon: Icon(tChanger.isDark==true?Icons.light_mode_rounded:Icons.dark_mode_rounded, color: cTheme.primaryColorDark,),
                    );
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: wid,
                      decoration: BoxDecoration(
                        color: cTheme.primaryColorLight,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 1,
                          ),
                          Flex(
                            direction: wid>500?Axis.horizontal:Axis.vertical,
                            mainAxisAlignment: wid>500?MainAxisAlignment.center:MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: cTheme.primaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(110),
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
                              SizedBox(
                                height: 20,
                                width: 20,
                              ),
                              Text("John Doe", style: TextStyle(color: cTheme.primaryColorDark, fontSize: wid>500?12.sp:24.sp, fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Flex(
                            direction: wid>500?Axis.horizontal:Axis.vertical,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("No.", style: TextStyle(color: Colors.grey, fontSize: wid>500?10.sp:20.sp,),),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Text("05", style: TextStyle(color: cTheme.primaryColor, fontSize: wid>500?82.sp:164.sp, fontWeight: FontWeight.bold, height: wid>500?0.3.sp:0.9.sp),),
                            ],
                          ),
                          Flex(
                            direction: wid>500?Axis.horizontal:Axis.vertical,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Model ", style: TextStyle(color: Colors.grey, fontSize: wid>500?12.sp:20.sp,),),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Text("Toyota - Corolla", style: TextStyle(color: cTheme.primaryColor, fontSize: wid>500?12.sp:24.sp, fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100),),
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("You are now available", style: TextStyle(color: Colors.grey, fontSize: wid>500?10.sp:20.sp,),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: wid,
                    height: 110,
                    // color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: wid>600?MainAxisAlignment.end:MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: wid>600?62.0:72.0,
                          height: wid>600?62.0:72.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100),),
                            color: cTheme.primaryColorLight,
                          ),
                          child: Icon(Icons.qr_code_rounded, color: cTheme.primaryColorDark, size: 40,),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: wid>600?20:0),
                          child: mainBtn(wid>600?wid*0.35-80:wid-120, wid>600?62.0:72.0, Colors.green, "AVAILABLE", () {
                            setState(() {
                              //
                            });
                          }),
                        ),
                      ],
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
