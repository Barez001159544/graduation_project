import 'package:flutter/material.dart';
import 'package:graduation_project/constants/pick_media.dart';
import 'package:graduation_project/controllers/get_get_self.dart';
import 'package:graduation_project/controllers/theme_changer.dart';
import 'package:graduation_project/models/update_user_request.dart';
import 'package:provider/provider.dart';

import '../constants/custom_appbar.dart';
import '../constants/custom_toast_notification.dart';
import '../constants/loading_indicator.dart';
import '../constants/main_btn.dart';
import '../controllers/language_changer.dart';
import '../custom theme data/themes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

// bool isDark = true;
// ThemeData cTheme = isDark ? lightTheme : darkTheme;

class _ProfileScreenState extends State<ProfileScreen> {
  FocusNode _focus = FocusNode();
  bool obsecure=true;
  String passwordText="";
  String phoneNumberText="";
  String jobTitleText="";

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
    if(_focus.hasFocus){
      setState(() {
        obsecure=false;
      });
    }else{
      setState(() {
        obsecure=true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer2<LanguageChanger, GetGetSelf>(
          builder: (_, languageChanger, getGetSelf, __) {
            lChanger= languageChanger.data;
            TextEditingController name= TextEditingController(text: getGetSelf.getSelfResponse?.userDetails?.name);
            TextEditingController phoneNumber= TextEditingController(text: getGetSelf.getSelfResponse?.userDetails?.phoneNumber);
            TextEditingController email= TextEditingController(text: getGetSelf.getSelfResponse?.userDetails?.email);
            TextEditingController password= TextEditingController(text: "");
            TextEditingController jobTitle= TextEditingController(text: getGetSelf.getSelfResponse?.userDetails?.jobTitle);
            TextEditingController age= TextEditingController(text: "${getGetSelf.getSelfResponse?.userDetails?.age}");
            return Directionality(
              textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: cTheme.scaffoldBackgroundColor,
                  appBar: CustomAppBar(cTheme.primaryColorLight, lChanger[1]["title"], cTheme.primaryColorDark, context),
                  body: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: wid,
                            height: wid>600?hei-156:hei-176,
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                              color: cTheme.primaryColorLight,
                              // color: Colors.red,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(50),
                                bottomLeft: Radius.circular(50),
                              ),
                            ),
                            child: Flex(
                              direction: wid>600?Axis.horizontal:Axis.vertical,
                              mainAxisAlignment: wid>600?MainAxisAlignment.spaceAround:MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: wid>600?wid*0.25:wid,
                                  height: wid>600?hei:wid/3,
                                  // color: Colors.blue,
                                  padding: EdgeInsets.only(left: wid>600?0:0),
                                  // color: Colors.yellow,
                                  child: Align(
                                    alignment: wid>600?Alignment.centerLeft:Alignment.center,
                                    child: Container(
                                      width: wid>600?hei/4:wid/3,
                                      height: wid>600?hei/4:wid/3,
                                      decoration: BoxDecoration(
                                        color: cTheme.primaryColor,
                                        image: DecorationImage(
                                            image: AssetImage("images/007-boy-2.jpg"),
                                            fit: BoxFit.cover
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(1000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // (or && hei>600)?SizedBox(height: 100,):SizedBox(),
                                // SizedBox(
                                //   height: 50,
                                // ),
                                Column(
                                  children: [
                                    profileItem(lChanger[1]["ph1"], cTheme.primaryColor, cTheme.primaryColorDark, wid>600?wid*0.6:wid, name, false, true, FocusNode(), (value){   }),
                                    SizedBox(height: 10,),
                                    profileItem(lChanger[1]["ph2"], cTheme.primaryColor, cTheme.primaryColorDark, wid>600?wid*0.6:wid, phoneNumber, false, false, FocusNode(), (value){phoneNumberText=value;}),
                                    SizedBox(height: 10,),
                                    profileItem(lChanger[1]["ph3"], cTheme.primaryColor, cTheme.primaryColorDark, wid>600?wid*0.6:wid, email, false, true, FocusNode(), (value){   }),
                                    SizedBox(height: 10,),
                                    profileItem(lChanger[1]["ph4"], cTheme.primaryColor, cTheme.primaryColorDark, wid>600?wid*0.6:wid, password, obsecure, false, _focus, (value){passwordText=value;}),
                                    SizedBox(height: 10,),
                                    profileItem(lChanger[1]["ph5"], cTheme.primaryColor, cTheme.primaryColorDark, wid>600?wid*0.6:wid, jobTitle, false, false, FocusNode(), (value){jobTitleText=value;}),
                                    SizedBox(height: 10,),
                                    profileItem(lChanger[1]["ph6"], cTheme.primaryColor, cTheme.primaryColorDark, wid>600?wid*0.6:wid, age, false, true, FocusNode(), (value){   }),
                                  ],
                                ),
                                // profileItem("label", wid, Icon(Icons.edit_rounded),),
                                // profileItem("label", wid, Icon(Icons.edit_rounded),),
                                // profileItem("label", wid, Icon(Icons.edit_rounded),),
                                // profileItem("label", wid, Icon(Icons.edit_rounded),),

                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: wid>600?500:wid,
                            height: wid>600?100:120,
                            child: Center(
                              child: MainBtn(wid>600?wid*0.35-80:wid-40, wid>600?62.0:72.0, cTheme.primaryColor, lChanger[1]["btn"], () async {
                                if(passwordText=="" || passwordText.length<5){
                                  CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[1]["notification3"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                }else if(phoneNumber.text.isEmpty){
                                  CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[1]["notification4"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                }else if(jobTitle.text.isEmpty){
                                  CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[1]["notification5"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                }else{
                                  print(passwordText.length);
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
                                  print(phoneNumber.text);
                                  print(jobTitle.text);
                                  print(passwordText);
                                  await getGetSelf.getUpdateUser(UpdateUserRequest(phoneNumber.text, jobTitle.text, passwordText));
                                  await getGetSelf.getGetSelf();
                                  Navigator.of(context).pop();
                                  if(getGetSelf.getSelfResponse?.status=="success"){
                                    CustomToastNotification(context, Icon(Icons.check_circle_outline_rounded, color: Colors.green,), lChanger[1]["notification1"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                  }else{
                                    print(getGetSelf.getSelfResponse?.status);
                                    CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[1]["notification2"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                  }
                                }
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
           );
  }
}

Widget profileItem(String hint, Color cursorColor, Color txtColor, double wid,TextEditingController controller, bool obText, bool isReadOnly, FocusNode focus, void onChange(String value)){
  return SizedBox(
    width: wid>600?500:wid,
    height: 40,
    child: TextField(
      controller: controller,
      cursorColor: cursorColor,
      obscureText: obText,
      readOnly: isReadOnly,
      focusNode: focus,
      style: TextStyle(
        color: txtColor,
      ),
      decoration: InputDecoration(
        suffixIcon: Icon(isReadOnly?Icons.edit_off_rounded:Icons.edit_rounded, color: Colors.grey, size: 15,),
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
      onChanged: (value){
        onChange(value);
      },
    ),
  );
}