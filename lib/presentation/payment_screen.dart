import "dart:convert";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_styled_toast/flutter_styled_toast.dart";
import "package:graduation_project/controllers/get_payment.dart";
import "package:graduation_project/controllers/get_token.dart";
import "package:graduation_project/fib_login/return_info.dart";
import "package:graduation_project/presentation/payment_scanner_screen.dart";
import "package:provider/provider.dart";

import "../constants.dart";
import "../controllers/language_changer.dart";
import "../controllers/theme_changer.dart";
import "../custom theme data/themes.dart";
import "../models/fib_login_parameters.dart";

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

bool isDark = true;
ThemeData cTheme = isDark ? lightTheme : darkTheme;

class _PaymentScreenState extends State<PaymentScreen> {
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
      home: Consumer3<LanguageChanger, GetPayment, GetToken>(
          builder: (_, languageChanger, getPayment, getToken, __) {
            lChanger= languageChanger.data;
            return Directionality(
              textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
              backgroundColor: Color(0xff08A99F),
              appBar: customAppbar(Color(0xff08A99F), lChanger[7]["title"], Colors.white, context),
              body: SafeArea(
                child: Flex(
                  direction: or?Axis.horizontal:Axis.vertical,
                  children: [
                    Expanded(
                      child: Container(
                        width: or?wid-400:wid,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            alignment: or?Alignment.center:Alignment.topCenter,
                            image: AssetImage("images/fib-transparent.png"),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: or?400:wid,
                      height: or?hei:300,
                      decoration: BoxDecoration(
                        gradient: or?null:LinearGradient(
                          colors: [
                            Color(0xffffff),
                            // Color(0x9dffffff),
                            Colors.white,
                          ],
                          begin: or?Alignment.centerLeft:Alignment.topCenter,
                          end: or?Alignment.centerRight:Alignment.bottomCenter,
                          stops: [
                            0.05,
                            // 0.2,
                            0.2,
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: or?MainAxisAlignment.center:MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("8/10 months", style: TextStyle(color: or?Colors.white:Colors.black, fontSize: 16,),),
                                SizedBox(
                                  height: 10,
                                ),
                                Stack(
                                  alignment: Alignment.centerLeft,
                                  fit: StackFit.passthrough,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: or?250:wid*0.8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: wid>500?(250)*(8/10):(wid*0.8)*(8/10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(100),
                                          topRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(100),
                                          bottomRight: Radius.circular(25),
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.amberAccent,
                                            Colors.green,
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () async {
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
                                var request= FIBLoginParameters("client_credentials", "koya-uni", "1fb32463-c472-4572-8797-670b15be7e3c");
                                ReturnInfo rInfo= ReturnInfo();
                                var logSuccess= await rInfo.returnInfo(request);
                                // print(logSuccess);
                                if(logSuccess!=null){
                                  await getPayment.getPaymentInformation(logSuccess.accessToken);
                                  if(getPayment.createPaymentResponse?.qrCode==null){
                                    customToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), "An error occurred");
                                    print("ID or Secret invalid!: 2");
                                  }else{
                                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                                      return PaymentScannerScreen();
                                    }));
                                  }
                                }else{
                                  customToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), "An error occurred");
                                    print("ID or Secret invalid!");
                                }
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: or?Colors.white:cTheme.primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                              child: Center(
                                child: Icon(Icons.arrow_forward_rounded, color: or?Colors.black:Colors.white, size: 40,),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: or?0:30,
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
