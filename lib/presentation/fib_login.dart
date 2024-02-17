import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/fib_login/auth.dart';
import 'package:graduation_project/models/fib_login_parameters.dart';
import 'package:graduation_project/presentation/payment_screen.dart';
import 'package:graduation_project/presentation/taxi_home.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../constants/login_fields.dart';
import '../constants/main_btn.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';
import '../tokenManager.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';

class FIBLogin extends StatefulWidget {
  const FIBLogin({super.key});

  @override
  State<FIBLogin> createState() => _FIBLoginState();
}

bool isShown=true;
TextEditingController id= TextEditingController();
TextEditingController secret= TextEditingController();
String errorMessage="";

class _FIBLoginState extends State<FIBLogin> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer<LanguageChanger>(
          builder: (_, languageChanger, __) {
            lChanger= languageChanger.data;
            return Directionality(
              textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: wid>600?cTheme.backgroundColor:cTheme.primaryColorLight,
                  leading: Builder(
                    builder: (BuildContext){
                      return IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      },
                        icon: Icon(Icons.arrow_back_rounded, color: cTheme.primaryColorDark,),
                      );
                    },
                  ),
                ),
                backgroundColor: cTheme.backgroundColor,//Color(0xff155E7D),
                body: SafeArea(
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: wid>600?wid*0.35:wid,
                          height: wid>600?wid*0.4:hei,
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
                              Text(lChanger[14]["title"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 36), textAlign: TextAlign.center,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                      child: LoginFields(id, false, lChanger[14]["ph1"], cTheme.primaryColorDark, cTheme.primaryColorDark)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: LoginFields(secret, isShown, lChanger[14]["ph2"], cTheme.primaryColorDark, cTheme.primaryColorDark),
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
                              MainBtn(wid>600?wid*0.35-80:wid-80, wid>600?62.0:72.0, cTheme.primaryColor, lChanger[14]["btn"], () async {
                                  if(id.text.isEmpty || secret.text.isEmpty){
                                    setState(() {
                                      errorMessage="leave no field empty";
                                    });
                                  }else{
                                    var request= FIBLoginParameters("client_credentials", id.text, secret.text);//"koya-uni", "1fb32463-c472-4572-8797-670b15be7e3c");
                                    Authentication auth= Authentication();
                                    var logSuccess= await auth.login(request);
                                    print("----------");
                                    print(logSuccess?.scope);
                                    print("----------");
                                    if(logSuccess!=null){
                                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                                        return PaymentScreen();
                                      }));
                                    }else{
                                      setState(() {
                                        errorMessage="ID or Secret invalid!";
                                      });
                                    }
                                  }

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
                                  child: Text(lChanger[14]["fbtn"],
                                    style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
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
