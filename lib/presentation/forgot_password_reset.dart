import 'package:flutter/material.dart';
import 'package:graduation_project/presentation/forgot_password_success.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class ForgotPasswordReset extends StatefulWidget {
  const ForgotPasswordReset({super.key});

  @override
  State<ForgotPasswordReset> createState() => _ForgotPasswordResetState();
}

bool isShown1=true;
bool isShown2=true;
TextEditingController resetPassword1= TextEditingController();
TextEditingController resetPassword2= TextEditingController();
// bool isDark=true;
// ThemeData cTheme = isDark?lightTheme:darkTheme;
String errorMessage="";

class _ForgotPasswordResetState extends State<ForgotPasswordReset> {
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
              backgroundColor: cTheme.backgroundColor,
              body: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: wid<500?20:wid-(wid-300)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: wid,
                        child: Text(lChanger[4]["title"], style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: cTheme.primaryColorDark),),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: loginFields(resetPassword1, isShown1, lChanger[4]["ph1"], cTheme.primaryColorDark, cTheme.primaryColorDark),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isShown1=!isShown1;
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                width: 40,
                                height: 40,
                                child: Align(
                                  alignment: languageChanger.selectedLanguage=="ENG"?Alignment.bottomRight:Alignment.bottomLeft,
                                  child: Icon(isShown1?Icons.lock_outline_rounded:Icons.lock_open_rounded, size: 20, color: cTheme.primaryColorDark,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: loginFields(resetPassword2, isShown2, lChanger[4]["ph2"], cTheme.primaryColorDark, cTheme.primaryColorDark),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isShown2=!isShown2;
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                width: 40,
                                height: 40,
                                child: Align(
                                  alignment: languageChanger.selectedLanguage=="ENG"?Alignment.bottomRight:Alignment.bottomLeft,
                                  child: Icon(isShown2?Icons.lock_outline_rounded:Icons.lock_open_rounded, size: 20, color: cTheme.primaryColorDark,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text("$errorMessage", style: TextStyle(fontSize: 10, color: Colors.red),),
                      ),
                      mainBtn(wid>500?wid*0.35-80:wid-40, wid>500?62.0:72.0, cTheme.primaryColor, lChanger[4]["btn"], () {
                        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                          return ForgotPasswordSuccess();
                        }));
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
