import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/get_payment.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../constants.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

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
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return MaterialApp(
      theme: cTheme,
      debugShowCheckedModeBanner: false,
      home: Consumer2<LanguageChanger, GetPayment>(
          builder: (_, languageChanger, getPayment, __) {
            lChanger= languageChanger.data;
            return Directionality(
              textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
              backgroundColor: cTheme.primaryColorLight,
              appBar: customAppbar(cTheme.primaryColorLight, lChanger[8]["title"], cTheme.primaryColorDark, context),
              body: SafeArea(
                child: getPayment.isLoading?Center(
                  child: loadingIndicator(),
                ):Flex(
                  direction: or?Axis.horizontal:Axis.vertical,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: or?wid/2:wid,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(50),),
                            ),
                            child: Center(
                              child: Image.memory(
                                Uint8List.fromList(base64.decode(getPayment.createPaymentResponse!.qrCode.split(",")[1])),
                                fit: BoxFit.cover,
                              ),
                              //Icon(Icons.qr_code_2_rounded, size: 100, color: Colors.white,),
                            ),
                          ),
                          SelectableText(getPayment.createPaymentResponse!.readableCode, style: TextStyle(fontSize: 18),),
                          Tooltip(
                            message: "Valid Until",
                            triggerMode: TooltipTriggerMode.tap,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.all(Radius.circular(10),),
                              ),
                              child: Countdown(
                                seconds: 300,
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
                      // color: Colors.white,
                      child: Column(
                        mainAxisAlignment: or?MainAxisAlignment.center:MainAxisAlignment.end,
                        children: [
                          // Text(lChanger[8]["subtitle"], style: TextStyle(color: Colors.grey.shade600, fontSize: 14), textAlign: TextAlign.center,),
                          Column(
                            children: [
                              Text("Koya University", style: TextStyle(fontSize: 28,),),
                              SizedBox(height: 5,),
                              Icon(Icons.arrow_upward_rounded, color: Colors.grey,),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text("500,000", style: TextStyle(fontSize: 28,),),
                                  Text(" IQD",),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          mainBtn(wid>600?wid*0.35-80:wid-40, wid>600?62.0:72.0, cTheme.primaryColor, lChanger[8]["btn"], () {
                            Navigator.of(context).pop();
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
      ),
    );
  }
}
