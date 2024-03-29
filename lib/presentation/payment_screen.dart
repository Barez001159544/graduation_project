import "dart:convert";
import "package:flutter/painting.dart";
import 'package:flutter_svg/svg.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_styled_toast/flutter_styled_toast.dart";
import "package:graduation_project/controllers/deprecated_controller/get_fib_auth.dart";
import "package:graduation_project/controllers/get_payment.dart";
import "package:graduation_project/controllers/get_payment_status.dart";
import "package:graduation_project/controllers/get_token.dart";
import "package:graduation_project/controllers/get_what_is_paid.dart";
import "package:graduation_project/presentation/payment_scanner_screen.dart";
import "package:graduation_project/constants/tokenManager.dart";
import "package:provider/provider.dart";

import "../constants/custom_alert_dialog.dart";
import "../constants/custom_appbar.dart";
import "../constants/custom_toast_notification.dart";
import "../constants/loading_indicator.dart";
import "../constants/main_btn.dart";
import "../controllers/language_changer.dart";
import "../controllers/theme_changer.dart";
import "../custom theme data/themes.dart";
import "../models/fib_auth_parameters.dart";

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

bool isDark = true;
ThemeData cTheme = isDark ? lightTheme : darkTheme;

class _PaymentScreenState extends State<PaymentScreen> {

  PageController pageViewController= PageController();
  int currentPage=0;
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer3<LanguageChanger, GetPayment, GetWhatIsPaid>(
          builder: (_, languageChanger, getPayment, getWhatIsPaid, __) {
            lChanger= languageChanger.data;
            return Directionality(
              textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
              backgroundColor: cTheme.scaffoldBackgroundColor,
              appBar: CustomAppBar( cTheme.scaffoldBackgroundColor, lChanger[7]["title"], cTheme.primaryColorDark, context), ///Color(0xff08A99F)
              body: SafeArea(
                child: Center(
                  child: SizedBox(
                    width: wid>600?wid/2:wid-20,
                    height: hei-100,
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              PageView.builder(
                                itemCount: 2,
                                  controller: pageViewController,
                                  onPageChanged: (cPage){
                                  print(cPage);
                                  setState(() {
                                    currentPage=cPage;
                                  });
                                  },
                                  itemBuilder: (context, index){
                                return Container(
                                  width: wid,
                                  // height: wid,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: cTheme.primaryColorLight,
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    // image: DecorationImage(
                                    //   scale: 2,
                                    //   image: AssetImage("images/payment.png",),
                                    // ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          scale: 2,
                                          "images/${index==0?"receive-money":"songkran"}.png",
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),

                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    currentPage==0?SizedBox():IconButton(
                                        onPressed: (){
                                          pageViewController.previousPage(duration: Duration(seconds: 1), curve: Curves.ease);
                                        },
                                        icon: Icon(Icons.keyboard_arrow_left_rounded, color: cTheme.primaryColorDark,),
                                    ),
                                    currentPage==1?SizedBox():IconButton(
                                        onPressed: (){
                                          pageViewController.nextPage(duration: Duration(seconds: 1), curve: Curves.ease);
                                        },
                                        icon: Icon(Icons.keyboard_arrow_right_rounded, color: cTheme.primaryColorDark,),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: wid,
                          padding: EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: cTheme.primaryColorLight,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Column(
                            children: [
                              Text(currentPage==0?"Monthly Fee":"Monthly Water", style: TextStyle(fontSize: 24, color: cTheme.primaryColorDark),),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset(
                                      height: 70,
                                      width: 70,
                                      "images/fib-logo.svg",
                                      color: cTheme.primaryColorDark,
                                      semanticsLabel: 'FIB logo'),
                                  Container(
                                    width: 1,
                                    height: 30,
                                    color: cTheme.primaryColorDark,
                                  ),
                                  SvgPicture.asset(
                                      height: 70,
                                      width: 70,
                                      "images/fib-logo.svg",
                                      color: cTheme.primaryColorDark,
                                      semanticsLabel: 'FIB logo'),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MainBtn(wid, wid>600?62.0:72.0, cTheme.primaryColor, lChanger[7]["btn"],
                                () async {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context){
                                  //   return PaymentScannerScreen();
                                  // }));
                                  // getToken.readToken();
                                  // print("${getToken.dToken}----------------)");
                                  // final userMap = jsonDecode(getToken.dToken) as Map<String, dynamic>;
                                  // final user = FIBLoginParameters.fromJson(userMap);
                                  // print(user.id);
                                  // FIBLoginParameters flp= FIBLoginParameters(user.grantType, user.id, user.secret);
                                  // FIBLoginParameters fibLogin= FIBLoginParameters.fromJson(flp.toJson());
                                  // print("$fibLogin<><<<<<<<<<<>>>>>>");
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
                                  var request= FIBLoginParameters("client_credentials", "koya-uni", "1fb32463-c472-4572-8797-670b15be7e3c");
                                  // FIBAuthentication rInfo= FIBAuthentication();
                                  await getPayment.getAuth(request);
                                  var logSuccess= getPayment.fibLoginResponse; //await rInfo.fibAuthenticate(request);
                                  // print(logSuccess);
                                  if(logSuccess!=null){
                                    print("--------------");
                                    // await getToken.writeToken("FIBToken", logSuccess.accessToken);
                                    /// TokenManager().saveToken("FIBToken", logSuccess.accessToken);
                                    print("--------------");
                                    await getPayment.getPaymentInformation(logSuccess.accessToken, 1);
                                    getWhatIsPaid.getWhatIsPaid(currentPage==0?"Fee":"Water", "1");
                                    if(getPayment.createPaymentResponse?.qrCode==null){
                                      CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), "An error occurred", cTheme.primaryColorLight, cTheme.primaryColorDark);
                                      print("ID or Secret invalid!: 2");
                                    }else{
                                      Navigator.of(context).pop();
                                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                                        return PaymentScannerScreen();
                                      }));
                                      CustomAlertDialog(cTheme.primaryColorLight, cTheme.primaryColorDark, "Title", "Some text will be shown here", "Thumbs Up", true, context, (){
                                        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                                        //   return Test();
                                        // }), (route) => false);
                                        // Navigator.of(context).pop();
                                      }, cTheme.primaryColor);
                                    }
                                  }else{
                                    Navigator.of(context).pop();
                                    CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), "An error occurred", cTheme.primaryColorLight, cTheme.primaryColorDark);
                                    print("ID or Secret invalid!");
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                        ),
            );
        }
      );
  }
}

