import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/constants/loading_indicator.dart';
import 'package:graduation_project/constants/main_btn.dart';
import 'package:graduation_project/controllers/get_auth.dart';
import 'package:graduation_project/controllers/get_get_self.dart';
import 'package:graduation_project/controllers/get_token.dart';
import 'package:graduation_project/models/auth_request.dart';
import 'package:graduation_project/presentation/forgot_password_screen.dart';
import 'package:graduation_project/presentation/home_screen.dart';
import 'package:graduation_project/presentation/taxi_home.dart';
import 'package:graduation_project/presentation/home_screen.dart';
import 'package:graduation_project/constants/tokenManager.dart';
import 'package:provider/provider.dart';

import '../constants/custom_dropdown_menu.dart';
import '../constants/login_fields.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isShown=true;
TextEditingController username= TextEditingController();
TextEditingController password= TextEditingController();
String errorMessage="";
// bool isDark=true;
// ThemeData cTheme = isDark?lightTheme:darkTheme;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    SystemChrome.setPreferredOrientations([
      wid>600?DeviceOrientation.landscapeLeft:DeviceOrientation.portraitUp,
      wid>600?DeviceOrientation.landscapeRight:DeviceOrientation.portraitUp,
    ]);
    return Consumer5<LanguageChanger, ThemeChanger, GetToken, GetAuth, GetGetSelf>(
          builder: (_, languageChanger, tChanger, getToken, getAuth, getGetSelf, __) {
            lChanger= languageChanger.data;
            return Directionality(
              textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
              backgroundColor: wid>600?cTheme.scaffoldBackgroundColor:cTheme.primaryColorLight,//Color(0xff155E7D),
              body: SafeArea(
                child: getAuth.isLoading?LoadingIndicator(cTheme.scaffoldBackgroundColor):Stack(
                  children: [
                    Center(
                      child: Container(
                          width: wid>600?wid*0.4:wid,
                          height: wid>600?wid*0.45:hei,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: cTheme.primaryColorLight,
                            borderRadius: BorderRadius.all(
                              Radius.circular(wid>600?45:0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Text(wid>600?lChanger[2]["title1"]:lChanger[2]["title2"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 36), textAlign: TextAlign.center,),
                              Icon(Icons.login_rounded, size: 56, color: cTheme.primaryColorDark.withOpacity(0.6),),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                      child: LoginFields(username, false, lChanger[2]["ph1"], cTheme.primaryColorDark, cTheme.primaryColorDark)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: LoginFields(password, isShown, lChanger[2]["ph2"], cTheme.primaryColorDark, cTheme.primaryColorDark),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              isShown=!isShown;
                                            });
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            width: 40,
                                            height: 40,
                                            child: Align(
                                              alignment: languageChanger.selectedLanguage=="ENG"?Alignment.bottomRight:Alignment.bottomLeft,
                                              child: Icon(isShown?Icons.lock_outline_rounded:Icons.lock_open_rounded, size: 20, color: cTheme.primaryColorDark,),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 40,),
                                    child: Text("$errorMessage", style: TextStyle(fontSize: 10, color: Colors.red),),
                                  ),
                                ],
                              ),
                              MainBtn(wid>600?wid*0.35-80:wid-80, wid>600?62.0:72.0, cTheme.primaryColor, lChanger[2]["btn"], () async {
                                // getAuth.isLoading?print("NABW"):print("BW");
                                  if(username.text.isEmpty || password.text.isEmpty){
                                    setState(() {
                                      errorMessage="leave no field empty";
                                    });
                                  }else {
                                    await getAuth.authwemailpass(AuthRequest(username.text, password.text));
                                    if(getAuth.data?.status=="OK"){
                                      // TokenManager().saveToken("accessToken", getAuth.data!.bearerToken);
                                      await getToken.writeToken("accessToken", getAuth.data!.bearerToken);
                                      await getGetSelf.getGetSelf();
                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                                        return HomeScreen();
                                      }), (route) => false);
                                      setState(() {
                                        errorMessage="Successful";
                                      });
                                    }else{
                                      setState(() {
                                        errorMessage="Invalid username or password";
                                      });
                                    }
                                    print("**************");
                                    print(getAuth.data?.status);
                                    print("**************");
                                    // TokenManager().saveToken("AuthenticationToken", getAuth.data as String);
                                  }
                                  // else if(username.text=="john" && password.text=="taxi"){
                                  //   Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                                  //     return TaxiHomeScreen();
                                  //   }));
                                  // }else if(username.text=="john" && password.text=="res"){
                                  //   Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                                  //     return Test();
                                  //   }));
                                  // }
                                  // else{
                                  //   errorMessage="username or password incorrect";
                                  // }

                              }),
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                                    return ForgotPasswordScreen();
                                  }));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(width: 1, color: Colors.grey,),
                                    ),
                                    color: Colors.transparent,
                                  ),
                                  child: Text(lChanger[2]["fbtn"],
                                    style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: SizedBox(
                        width: wid-20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(onPressed: (){
                              tChanger.changeTheme();
                            },
                              icon: Icon(tChanger.isDark?Icons.dark_mode_rounded:Icons.light_mode_rounded, color: cTheme.primaryColorDark,),
                            ),
                            //
                            CustomDropDownMenu("Lang", 80, 30, 5, cTheme.scaffoldBackgroundColor, cTheme.primaryColorDark, ["KRD", "ARB", "ENG"], languageChanger.selectedLanguage, (val) {
                              print(val);
                              languageChanger.changeLanguage(val);
                            }),
                          ],
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: (){
                      //     // setState(() {
                      //     //   cTheme = cTheme==lightTheme?darkTheme:lightTheme;
                      //     //   print(isDark);
                      //     // });
                      //   },
                      //   child: Container(
                      //     width: 70,
                      //     height: 70,
                      //     padding: EdgeInsets.only(top: 10),
                      //     decoration: BoxDecoration(
                      //       color: Colors.yellow,
                      //       borderRadius: BorderRadius.all(
                      //         Radius.circular(5),
                      //       ),
                      //     ),
                      //     child: SvgPicture.asset(
                      //         height: 40,
                      //         width: 40,
                      //         "images/007-boy-2.svg",
                      //         semanticsLabel: 'App logo'
                      //     ),
                      //   ),
                      // ),
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

