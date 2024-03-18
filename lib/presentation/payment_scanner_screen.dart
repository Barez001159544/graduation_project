import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/controllers/get_fib_auth.dart';
import 'package:graduation_project/controllers/get_payment.dart';
import 'package:graduation_project/controllers/get_payment_status.dart';
import 'package:graduation_project/controllers/get_token.dart';
import 'package:graduation_project/presentation/home_screen.dart';
import 'package:graduation_project/constants/tokenManager.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../constants/confirmation_custom_alert_dialog.dart';
import '../constants/custom_alert_dialog.dart';
import '../constants/custom_appbar.dart';
import '../constants/custom_dropdown_menu.dart';
import '../constants/custom_toast_notification.dart';
import '../constants/loading_indicator.dart';
import '../constants/main_btn.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';
import '../models/fib_auth_parameters.dart';

class PaymentScannerScreen extends StatefulWidget {
  const PaymentScannerScreen({super.key});

  @override
  State<PaymentScannerScreen> createState() => _PaymentScannerScreenState();
}

// bool isDark=true;
// ThemeData cTheme = isDark?lightTheme:darkTheme;
String intToTimeLeft(int value) {
  int h, m, s;

  h = value ~/ 3600;

  m = ((value - h * 3600)) ~/ 60;

  s = value - (h * 3600) - (m * 60);

  // String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();

  String minuteLeft =
  m.toString().length < 2 ? "0" + m.toString() : m.toString();

  String secondsLeft =
  s.toString().length < 2 ? "0" + s.toString() : s.toString();

  String result = "$minuteLeft:$secondsLeft";

  return result;
}

class _PaymentScannerScreenState extends State<PaymentScannerScreen> {
  // late String? token;
  // Future<void> callToken()async{
  //   token= await TokenManager().readToken("FIBToken");
  // }
  // @override
  // void initState() {
  //   // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //   //   var request= FIBLoginParameters("client_credentials", "koya-uni", "1fb32463-c472-4572-8797-670b15be7e3c");
  //   //   ReturnInfo rInfo= ReturnInfo();
  //   //   var logSuccess= await rInfo.returnInfo(request);
  //   //   var paymentId= Provider.of<GetPayment>(context, listen: false).getPaymentInformation(logSuccess!.accessToken);
  //   //   Provider.of<GetPaymentStatus>(context, listen: false).getPaymentStatus(paymentId);
  //   // });
  //   super.initState();
  //   // callToken();
  // }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark?darkTheme:lightTheme;
    List lChanger;
    return Consumer5<LanguageChanger, GetPayment, GetPaymentStatus, GetFIBAuth, GetToken>(
          builder: (_, languageChanger, getPayment, getPaymentStatus, getFIBAuth, getToken, __) {
            lChanger= languageChanger.data;
            // Payment().checkPaymentStatus(getPayment.createPaymentResponse!.paymentId);
            return Directionality(
              textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
              backgroundColor: cTheme.primaryColorLight,
              appBar: CustomAppBar(cTheme.primaryColorLight, lChanger[8]["title"], cTheme.primaryColorDark, context),
              body: SafeArea(
                child: getPayment.isLoading?Center(
                  child: LoadingIndicator(cTheme.scaffoldBackgroundColor),
                ):Flex(
                  direction: or?Axis.horizontal:Axis.vertical,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: or?wid/5:wid*0.6,
                            height: or?wid/5:wid*0.6,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20),),
                            ),
                            child: Center(
                              child: Image.memory(
                                Uint8List.fromList(base64.decode(getPayment.createPaymentResponse!.qrCode.split(",")[1])),
                                fit: BoxFit.cover,
                              ),
                              //Icon(Icons.qr_code_2_rounded, size: 100, color: Colors.white,),
                            ),
                          ),
                          GestureDetector(
                            onLongPress: (){
                              Clipboard.setData(ClipboardData(text: getPayment.createPaymentResponse!.readableCode));
                              CustomToastNotification(context, Icon(Icons.check_circle_outline_rounded, color: Colors.green,), "Copied to clipboard", cTheme.scaffoldBackgroundColor, cTheme.primaryColorDark);
                            },
                              child: Text(getPayment.createPaymentResponse!.readableCode, style: TextStyle(fontSize: 18, color: cTheme.primaryColorDark),),
                          ),
                          // Text(getPaymentStatus.isLoading?"Loading...":"${getPaymentStatus.fibCheckPaymentStatusResponse?.status}", style: TextStyle(color: cTheme.primaryColorDark),),
                          Tooltip(
                            message: lChanger[8]["tooltip1"],
                            triggerMode: TooltipTriggerMode.tap,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.all(Radius.circular(10),),
                              ),
                              child: Countdown(
                                seconds: 900,
                                build: (BuildContext context, double time) => Text("${time.round()==0?"Invalid":intToTimeLeft(time.round())}", style: TextStyle(color: Colors.white),),
                                interval: Duration(seconds: 1),
                                onFinished: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: or?wid/2-20:wid,
                      height: or?hei:300,
                      // color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: or?MainAxisAlignment.center:MainAxisAlignment.end,
                        children: [
                          // Text(lChanger[8]["subtitle"], style: TextStyle(color: Colors.grey.shade600, fontSize: 14), textAlign: TextAlign.center,),
                          // FittedBox(
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 10),
                          //     decoration: BoxDecoration(
                          //       color: Colors.grey.shade200,
                          //       borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                          //     ),
                          //     child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                // crossAxisAlignment: CrossAxisAlignment.baseline,
                                // textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text("500,000", style: TextStyle(fontSize: 28, color: Colors.grey.shade700),),
                                      Text(" IQD", style: TextStyle(color: Colors.grey.shade700),),
                                    ],
                                  ),
                                  CustomDropDownMenu("Property", 110, 30, 5, cTheme.scaffoldBackgroundColor, cTheme.primaryColorDark, ["KRD", "ARB", "ENG"], null, (val) {
                                    print(val);
                                    // lChanger.changeLanguage(val);
                                  })
                                ],
                              ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: wid>600?wid*0.4:wid-40,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: cTheme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                                    // textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(lChanger[8]["from"], style: TextStyle(color: cTheme.primaryColorDark),),
                                      Text(lChanger[8]["you"], style: TextStyle(fontSize: 20, color: cTheme.primaryColorDark),),
                                    ],
                                  ),
                                ),
                                                  SizedBox(height: 5,),
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      color: cTheme.primaryColorDark,
                                                      borderRadius: BorderRadius.all(Radius.circular(100)),
                                                    ),
                                                      child: Icon(Icons.arrow_forward_rounded, color: cTheme.primaryColorLight)),
                                                  SizedBox(height: 5,),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                                    // textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(lChanger[8]["to"], style: TextStyle(color: cTheme.primaryColorDark),),
                                      Text("MRF", style: TextStyle(fontSize: 20, color: cTheme.primaryColorDark),),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MainBtn(wid>600?wid*0.4:wid-40, wid>600?62.0:72.0, cTheme.primaryColor, lChanger[8]["btn"], () async {
                            // Navigator.of(context).pop();
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
                            await getFIBAuth.getAuth(request);
                            var logSuccess= getFIBAuth.fibLoginResponse; //await rInfo.fibAuthenticate(request);
                            if(logSuccess!=null){
                              // await getToken.writeToken("FIBToken", logSuccess.accessToken);
                              await getPaymentStatus.getPaymentStatus(getPayment.createPaymentResponse!.paymentId, logSuccess.accessToken);
                              if(getPaymentStatus.fibCheckPaymentStatusResponse?.status!="PAID"){
                                Navigator.of(context).pop();
                                print('Not PAID');
                                CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[8]["error"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                              }else{
                                print(getPaymentStatus.fibCheckPaymentStatusResponse!.paidBy?.name);
                                CustomToastNotification(context, Icon(Icons.check_circle_outline_rounded, color: Colors.green,), lChanger[8]["success"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                                  return HomeScreen();
                                }), (route) => false);
                                /// CustomAlertDialog(cTheme.primaryColorLight, cTheme.primaryColorDark, "Title", "Some text will be shown here", "Thumbs Up", true, context, (){
                                ///   // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                                ///   //   return Test();
                                ///   // }), (route) => false);
                                ///   // Navigator.of(context).pop();
                                /// }, cTheme.primaryColor);
                              }
                            }else{
                              CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[8]["error"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                            }

                          }),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Container(
                          //   width: wid>600?wid*0.85-80:wid-40,
                          //   height: 70,
                          //   // color: Colors.blueGrey,
                          //   child: Center(
                          //     child: Text(lChanger[8]["sideBtn"], style: TextStyle(fontSize: 20, color: cTheme.primaryColor),),
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
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
