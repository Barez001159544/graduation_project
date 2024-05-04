import "dart:convert";
import "package:flutter/painting.dart";
import 'package:flutter_svg/svg.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_styled_toast/flutter_styled_toast.dart";
import "package:graduation_project/controllers/get_payment.dart";
import "package:graduation_project/controllers/get_token.dart";
import "package:graduation_project/controllers/get_user_payments.dart";
import "package:graduation_project/controllers/get_user_properties.dart";
import "package:graduation_project/controllers/get_what_is_paid.dart";
import "package:graduation_project/presentation/payment_scanner_screen.dart";
import "package:graduation_project/constants/tokenManager.dart";
import "package:provider/provider.dart";

import "../constants/custom_alert_dialog.dart";
import "../constants/custom_appbar.dart";
import "../constants/custom_dropdown_menu.dart";
import "../constants/custom_toast_notification.dart";
import "../constants/loading_indicator.dart";
import "../constants/main_btn.dart";
import "../controllers/language_changer.dart";
import "../controllers/theme_changer.dart";
import "../custom theme data/themes.dart";
import "../models/fib_auth_parameters.dart";
import "../models/fully_aparments_reponse.dart";
import "../models/fully_houses_response.dart";
import "../models/this_month_payment.dart";

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

bool isDark = true;
ThemeData cTheme = isDark ? lightTheme : darkTheme;

class _PaymentScreenState extends State<PaymentScreen> {

  String? selectedProperty;
  String? selectedType;
  int? selectedId;
  List<HouseFee> justWater=[];
  List<HouseFee> justFee=[];

  PageController pageViewController= PageController();
  int currentPage=0;
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer5<LanguageChanger, GetPayment, GetWhatIsPaid, GetUserPayments, GetUserProperties>(
          builder: (_, languageChanger, getPayment, getWhatIsPaid, getUserPayments, getUserProperties, __) {
            lChanger= languageChanger.data;
            return Directionality(
              textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
              backgroundColor: cTheme.scaffoldBackgroundColor,
              appBar: CustomAppBar( cTheme.scaffoldBackgroundColor, lChanger[7]["title"], cTheme.primaryColorDark, context), ///Color(0xff08A99F)
              body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                                      // print(selectedType);
                                      // getUserPayments.getThisMonthPayment("$selectedType", "$selectedId");
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
                                          icon: Icon(languageChanger.selectedLanguage=="ENG"?Icons.keyboard_arrow_left_rounded:Icons.keyboard_arrow_right_rounded, color: cTheme.primaryColorDark,),
                                      ),
                                      currentPage==1?SizedBox():IconButton(
                                          onPressed: (){
                                            pageViewController.nextPage(duration: Duration(seconds: 1), curve: Curves.ease);
                                          },
                                          icon: Icon(languageChanger.selectedLanguage=="ENG"?Icons.keyboard_arrow_right_rounded:Icons.keyboard_arrow_left_rounded, color: cTheme.primaryColorDark,),
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
                                Text(currentPage==0?lChanger[7]["fee"]:lChanger[7]["water"], style: TextStyle(fontSize: 24, color: cTheme.primaryColorDark),),
                                SizedBox(
                                  height: 10,
                                ),
                                getUserProperties.isLoading?Center(
                                  child: LoadingIndicator(cTheme.primaryColorDark),
                                ):SpecialCustomDropDownMenu(lChanger[7]["property"], 200, 40, 5, cTheme.scaffoldBackgroundColor, cTheme.primaryColorDark, getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses, getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.apartments, selectedProperty, (val) async {
                                  setState(() {
                                    selectedProperty=val;
                                  });
                                  selectedType="${val}".split("-")[0].toLowerCase();
                                  if("$val".split("-")[0]=="Houses"){
                                    EachHouseResponse? obj = getUserProperties.fullyHousesResponse?.eachHouseResponse?.firstWhere((obj) => obj?.name == "${val}".split("-")[1],);
                                    selectedId=obj?.id;
                                    print(">>>>>>>>>${selectedId}");
                                    await getUserPayments.getThisMonthPayment("houses", "$selectedId");
                                  }else{
                                    EachApartmentsResponse? obj = getUserProperties.fullyApartmentsResponse?.eachApartmentsResponse?.firstWhere((obj) => obj?.name == "${val}".split("-")[1],);
                                    selectedId=obj?.id;
                                    print(">>>>>>>>>${selectedId}");
                                    await getUserPayments.getThisMonthPayment("apartments", "$selectedId");
                                  }
                                  justWater.clear();
                                  justFee.clear();
                                  if(getUserPayments.thisMonthPayment?.eachHouseFee!=null){
                                    for(HouseFee each in getUserPayments.thisMonthPayment!.eachHouseFee!){
                                      if(each.feeType=="water"){
                                        justWater.add(each);
                                      }else if(each.feeType=="fee"){
                                        justFee.add(each);
                                      }
                                    }
                                  }
                                  print(">>>>>${justWater}");
                                  print(">>>>>>>>>${justFee}");
                                }),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    // SizedBox(
                                    //   height: 40,
                                    //   width: 100,
                                    //   child: SvgPicture.asset(
                                    //       height: 40,
                                    //       // width: 40,
                                    //       color: cTheme.primaryColorDark,
                                    //       "images/rcms-logo-2.svg",
                                    //       semanticsLabel: 'App logo'),
                                    //   // Image.asset(
                                    //   //     "images/rcms-logo-2.png",
                                    //   // ),
                                    // ),
                                    SvgPicture.asset(
                                        height: 30,
                                        width: 30,
                                        "images/rcms-logo-2.svg",
                                        color: cTheme.primaryColorDark,
                                        semanticsLabel: 'App logo'),
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
                                    if(selectedProperty==null){
                                      CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[7]["notification1"], cTheme.scaffoldBackgroundColor, cTheme.primaryColorDark);
                                    }else{
                                      if(currentPage==1){ ///Water
                                        if(justWater==null || justWater.isEmpty){
                                          CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[7]["notification2"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                        }else{
                                          if(getUserPayments.thisMonthPayment!.eachHouseFee![0].isPaid==1){
                                            CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[7]["notification3"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                          }else{
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
                                            print(">>>>>>>$logSuccess");
                                            if(logSuccess!=null){
                                              print("--------------");
                                              // await getToken.writeToken("FIBToken", logSuccess.accessToken);
                                              /// TokenManager().saveToken("FIBToken", logSuccess.accessToken);
                                              print("--------------");
                                              await getPayment.getPaymentInformation(logSuccess.accessToken, int.parse(getUserPayments.thisMonthPayment?.eachHouseFee?[0].amount?.split(".")[0]??"1000"));
                                              getWhatIsPaid.getWhatIsPaid("Water", justWater[0].amountPaid?.split(".")[0], selectedType, selectedId, selectedProperty, justWater[0].id);
                                              if(getPayment.createPaymentResponse?.qrCode==null){
                                                CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[7]["notification2"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                                print("ID or Secret invalid!: 2");
                                              }else{
                                                Navigator.of(context).pop();
                                                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                                                  return PaymentScannerScreen();
                                                }));
                                                CustomAlertDialog(cTheme.primaryColorLight, cTheme.primaryColorDark, lChanger[7]["dialogTitle"], lChanger[7]["dialogSubtitle"], lChanger[7]["dialogBtn"], true, context, (){
                                                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                                                  //   return Test();
                                                  // }), (route) => false);
                                                  // Navigator.of(context).pop();
                                                }, cTheme.primaryColor);
                                              }
                                            }else{
                                              Navigator.of(context).pop();
                                              CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[7]["notification2"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                              print("ID or Secret invalid!");
                                            }
                                          }
                                        }
                                      }else if(currentPage==0){ ///Fee
                                        if(justFee==null || justFee.isEmpty){
                                          CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[7]["notification2"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                        }else{
                                          if(getUserPayments.thisMonthPayment!.eachHouseFee![0].isPaid==1){
                                            CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[7]["notification3"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                          }else{
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
                                            print(">>>>>>>$logSuccess");
                                            if(logSuccess!=null){
                                              print("--------------");
                                              // await getToken.writeToken("FIBToken", logSuccess.accessToken);
                                              /// TokenManager().saveToken("FIBToken", logSuccess.accessToken);
                                              print("--------------");
                                              await getPayment.getPaymentInformation(logSuccess.accessToken, int.parse(getUserPayments.thisMonthPayment?.eachHouseFee?[0].amount?.split(".")[0]??"1000"));
                                              getWhatIsPaid.getWhatIsPaid("Fee", justFee[0].amountPaid?.split(".")[0], selectedType, selectedId, selectedProperty, justFee[0].id);
                                              if(getPayment.createPaymentResponse?.qrCode==null){
                                                CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[7]["notification2"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                                print("ID or Secret invalid!: 2");
                                              }else{
                                                Navigator.of(context).pop();
                                                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                                                  return PaymentScannerScreen();
                                                }));
                                                CustomAlertDialog(cTheme.primaryColorLight, cTheme.primaryColorDark, lChanger[7]["dialogTitle"], lChanger[7]["dialogSubtitle"], lChanger[7]["dialogBtn"], true, context, (){
                                                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                                                  //   return Test();
                                                  // }), (route) => false);
                                                  // Navigator.of(context).pop();
                                                }, cTheme.primaryColor);
                                              }
                                            }else{
                                              Navigator.of(context).pop();
                                              CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[7]["notification2"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                              print("ID or Secret invalid!");
                                            }
                                          }
                                        }
                                      }
                                    }
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
                        ),
            );
        }
      );
  }
}

