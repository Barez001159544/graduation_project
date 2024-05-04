import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/controllers/get_get_self.dart';
import 'package:graduation_project/controllers/get_protests.dart';
import 'package:graduation_project/controllers/get_repairment.dart';
import 'package:graduation_project/controllers/get_user_payments.dart';
import 'package:graduation_project/controllers/get_user_properties.dart';
import 'package:graduation_project/models/entire_house_fee.dart';
import 'package:graduation_project/models/this_month_payment.dart';
import 'package:graduation_project/presentation/engineering_screen.dart';
import 'package:graduation_project/presentation/faq_screen.dart';
import 'package:graduation_project/presentation/protest_history.dart';
import 'package:graduation_project/presentation/repair_history.dart';
import 'package:graduation_project/presentation/repair_new.dart';
import 'package:graduation_project/presentation/login_screen.dart';
import 'package:graduation_project/presentation/payment_screen.dart';
import 'package:graduation_project/presentation/profile_screen.dart';
import 'package:graduation_project/presentation/properties_screen.dart';
import 'package:graduation_project/presentation/settings_screen.dart';
import 'package:provider/provider.dart';
// import 'package:badges/badges.dart' as badges;
import '../constants/confirmation_custom_alert_dialog.dart';
import '../constants/custom_dropdown_menu.dart';
import '../constants/custom_toast_notification.dart';
import '../constants/date_difference.dart';
import '../constants/loading_indicator.dart';
import '../controllers/get_token.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';
import '../models/fully_aparments_reponse.dart';
import '../models/fully_houses_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController scrollController= PageController();
  double _indicatorPosition=-30;

  String? selectedProperty;
  String? selectedType;
  int? selectedId;
  List<HouseFee> justHouseFee=[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await Provider.of<GetUserProperties>(context, listen: false).getUserProperties();
      await Provider.of<GetUserProperties>(context, listen: false).getAllHouses();
      await Provider.of<GetUserProperties>(context, listen: false).getAllApartments();
      if(Provider.of<GetUserProperties>(context, listen: false).userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses!=null){
        print("************HOUSE AVAILABLE");
        EachHouseResponse? obj = Provider.of<GetUserProperties>(context, listen: false).fullyHousesResponse?.eachHouseResponse?.firstWhere((obj) => obj?.name == "${Provider.of<GetUserProperties>(context, listen: false).userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses?[0].name}",);
        selectedId=obj?.id;
        setState(() {
          selectedProperty="Houses-${obj?.name}";
        });
        await Provider.of<GetUserPayments>(context, listen: false).getThisMonthPayment("houses", "${selectedId}");
        await Provider.of<GetUserPayments>(context, listen: false).getAllHousePayments("houses", "${selectedId}");
      }else{
        print("************APARTMENT AVAILABLE");
        EachApartmentsResponse? obj = Provider.of<GetUserProperties>(context, listen: false).fullyApartmentsResponse?.eachApartmentsResponse?.firstWhere((obj) => obj?.name == "${Provider.of<GetUserProperties>(context, listen: false).userHousesAndApartmentsResponse?.residentialPropertiesResponse?.apartments?[0].name}",);
        selectedId=obj?.id;
        setState(() {
          selectedProperty="Apartments-${obj?.name}";
        });
        await Provider.of<GetUserPayments>(context, listen: false).getThisMonthPayment("apartments", "${selectedId}");
        await Provider.of<GetUserPayments>(context, listen: false).getAllHousePayments("apartments", "${selectedId}");
      }
      // await Provider.of<GetUserPayments>(context, listen: false).getEntireHouseFee();
    });
    justHouseFee.clear();
    if(Provider.of<GetUserPayments>(context, listen: false).thisMonthPayment?.eachHouseFee!=null){
      for(HouseFee each in Provider.of<GetUserPayments>(context, listen: false).thisMonthPayment!.eachHouseFee!){
        if(each.feeType=="house fee"){
          justHouseFee.add(each);
        }
      }
    }

    for(HouseFee each in justHouseFee){
      print("!!!!!! ${each.feeType}");
    }
  }

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    // double wid1= wid>600?wid*0.9/2-20:wid;
    // double hei1= wid>600?wid*0.5:hei/2;
    // double wid2= wid>600?wid*0.9/2-20:wid;
    // double hei2= wid>600?wid*0.5:hei/2;
    double wid1= wid>600?wid/2.2:wid;
    double hei1= wid>600?wid/2.2:hei/2-10;
    double wid2= wid>600?wid/2.2:wid;
    double hei2= wid>600?wid/2.2:hei/2+10;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer5<LanguageChanger, GetToken, GetGetSelf, GetUserProperties, GetUserPayments>(
        builder: (_, languageChanger, getToken, getGetSelf, getUserProperties, getUserPayments, __) {
          lChanger= languageChanger.data;
          return Directionality(
              textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
          backgroundColor: cTheme.scaffoldBackgroundColor,
          body: SafeArea(
            child: GestureDetector(
              onVerticalDragUpdate: (details) async {
                setState(() {
                  // Update position of loading indicator within bounds and not during loading
                  if (_indicatorPosition < 101 && !getGetSelf.isLoading) {
                    _indicatorPosition += details.delta.dy;
                  } else if (_indicatorPosition < 101) {
                    _indicatorPosition = -30;
                  }
                });
              },
              onVerticalDragEnd: (details) async {
                // Check if the indicator has reached the refresh point
                if (_indicatorPosition >= 100) {
                  // Trigger refresh action
                  await getGetSelf.getGetSelf();
                  await getUserProperties.getUserProperties();
                  await getUserProperties.getAllHouses();
                  await getUserProperties.getAllApartments();
                  if(getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses!=null){
                    print("************HOUSE AVAILABLE");
                    EachHouseResponse? obj = getUserProperties.fullyHousesResponse?.eachHouseResponse?.firstWhere((obj) => obj?.name == "${getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses?[0].name}",);
                    selectedId=obj?.id;
                    setState(() {
                      selectedProperty="Houses-${obj?.name}";
                      print(selectedType);
                    });
                    await getUserPayments.getThisMonthPayment("houses", "${selectedId}");
                    await getUserPayments.getAllHousePayments("houses", "${selectedId}");
                  }else{
                    print("************APARTMENT AVAILABLE");
                    EachApartmentsResponse? obj = getUserProperties.fullyApartmentsResponse?.eachApartmentsResponse?.firstWhere((obj) => obj?.name == "${getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.apartments?[0].name}",);
                    selectedId=obj?.id;
                    setState(() {
                      selectedProperty="Apartments-${obj?.name}";
                      print(selectedType);
                    });
                    await getUserPayments.getThisMonthPayment("apartments", "${selectedId}");
                    await getUserPayments.getAllHousePayments("apartments", "${selectedId}");
                  }
                  // await getUserPayments.getThisMonthPayment("houses", "${selectedId}");
                  // await getUserPayments.getAllHousePayments("houses", "${selectedId}");
                  // await getUserPayments.getEntireHouseFee();
                  Future.delayed(const Duration(seconds: 1));
                }
                setState(() {
                  // Reset the indicator position after drag ends
                  _indicatorPosition = -30;
                });
              },
              child: Stack(
                children: [
                  Center(
                    child: Flex(
                      direction: wid>600?Axis.horizontal:Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            width: wid1,
                            height: hei1,
                            // color: Colors.blue,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                wid>600?Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        print("Log Out");
                                        ConfirmationCustomAlertDialog(cTheme.primaryColorLight, cTheme.primaryColorDark, lChanger[0]["confirmationTitle"], lChanger[0]["confirmationSubtitle"], lChanger[0]["confirmationAccept"], lChanger[0]["confirmationDecline"], context, (){
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
                                          getGetSelf.logOutLoading;
                                          getToken.deleteToken("accessToken");
                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                                            return LoginScreen();
                                          }), (route) => false);
                                        }, (){}, cTheme.primaryColor);
                                      },
                                      child: Container(
                                        height: hei1*0.25,
                                        width: hei1*0.25,
                                        padding: EdgeInsets.all(12.sp),
                                        decoration: BoxDecoration(
                                          color: cTheme.primaryColorLight,
                                          borderRadius: BorderRadius.all(Radius.circular(17.sp),),
                                        ),
                                        child: RotatedBox(
                                          quarterTurns: languageChanger.selectedLanguage=="ENG"?90:0,
                                            child: Icon(Icons.logout_rounded, color: Colors.red, size: 13.sp,)),
                                      ),
                                    ),
                                    Tooltip(
                                      message: lChanger[6]["tooltip1"],
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return ProfileScreen();
                                          }));
                                        },
                                        child: Container(
                                          height: hei1*0.25,
                                          width: hei1*0.25,
                                          padding: EdgeInsets.all(12.sp),
                                          decoration: BoxDecoration(
                                            color: cTheme.primaryColorLight,
                                            borderRadius: BorderRadius.all(Radius.circular(17.sp),),
                                          ),
                                          child: SvgPicture.asset(
                                              height: 70,
                                              width: 70,
                                              "images/fib-logo.svg",
                                              color: cTheme.primaryColorDark,
                                              semanticsLabel: 'FIB logo'),
                                          // Container(
                                          //   decoration: BoxDecoration(
                                          //     color: cTheme.primaryColor,
                                          //     borderRadius: BorderRadius.all(
                                          //       Radius.circular(100.sp),
                                          //     ),
                                          //     image: DecorationImage(
                                          //       image: AssetImage("images/007-boy-2.jpg"),
                                          //       fit: BoxFit.cover,
                                          //     ),
                                          //     border: Border.all(
                                          //       width: 3,
                                          //       color: cTheme.primaryColor,
                                          //     ),
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ),
                                    Tooltip(
                                      message: lChanger[6]["tooltip3"],
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return SettingsScreen();
                                          }));
                                        },
                                        child: Container(
                                          height: hei1*0.25,
                                          width: hei1*0.25,
                                          decoration: BoxDecoration(
                                            color: cTheme.primaryColorLight,
                                            borderRadius: BorderRadius.all(Radius.circular(17.sp),),
                                          ),
                                          child: Icon(Icons.settings_rounded, color: cTheme.primaryColorDark, size: 13.sp,),
                                        ),
                                      ),
                                    )
                                  ],
                                ):Row(
                                  children: [
                                    Tooltip(
                                      message: lChanger[6]["tooltip1"],
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: cTheme.primaryColorLight,
                                          borderRadius: BorderRadius.all(Radius.circular(30),),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        // margin: EdgeInsets.all(10),
                                        child: SvgPicture.asset(
                                            height: 60,
                                            width: 60,
                                            "images/fib-logo.svg",
                                            color: cTheme.primaryColorDark,
                                            semanticsLabel: 'FIB logo'),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Container(
                                      width: wid-110,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: cTheme.primaryColorLight,
                                        borderRadius: BorderRadius.all(Radius.circular(30),),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      // margin: EdgeInsets.all(10),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // GestureDetector(
                                          //   onTap: (){
                                          //     Navigator.push(context, MaterialPageRoute(builder: (context){
                                          //       return ProfileScreen();
                                          //     }));
                                          //   },
                                          //   child: Container(
                                          //     width: 80,
                                          //     height: 80,
                                          //     decoration: BoxDecoration(
                                          //       color: cTheme.primaryColor,
                                          //       borderRadius: BorderRadius.all(
                                          //         Radius.circular(30),
                                          //       ),
                                          //       image: DecorationImage(
                                          //         image: AssetImage("images/007-boy-2.jpg"),
                                          //         fit: BoxFit.cover,
                                          //       ),
                                          //       border: Border.all(
                                          //         width: 1,
                                          //         color: Colors.black
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Tooltip(
                                            message: lChanger[6]["tooltip3"],
                                            child: GestureDetector(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                                  return SettingsScreen();
                                                }));
                                              },
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                // margin: EdgeInsets.only(left: index==0?0:10),
                                                decoration: BoxDecoration(
                                                  color: cTheme.primaryColor,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(25),
                                                  ),
                                                ),
                                                child: Icon(Icons.settings_rounded, color: Colors.white, size: 25,),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(lChanger[6]["welcome"].toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: cTheme.primaryColorDark.withOpacity(0.8),),),
                                              Text("${getGetSelf.getSelfResponse?.userDetails?.name.split(" ")[0] ?? "Anonymous"}".toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark, fontWeight: FontWeight.bold,),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: wid>600?15.sp:20,
                                ),
                                Expanded(
                                  child: Tooltip(
                                    message: getUserPayments.thisMonthPayment?.eachHouseFee?.length==0?"N/A":("${lChanger[6]["cmonth"]}: ${getUserPayments.thisMonthPayment?.eachHouseFee?[0].isPaid==0?lChanger[6]["cstatus2"]:lChanger[6]["cstatus1"]}"),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return PaymentScreen();
                                        }));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(hei1*0.1),
                                          ),
                                          gradient: LinearGradient(
                                              colors: [
                                                cTheme.primaryColor,
                                                Color(0xff7895a6),
                                              ],
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              textDirection: TextDirection.ltr,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  textDirection: TextDirection.ltr,
                                                  children: [
                                                    (getUserProperties.isLoading || getUserPayments.isLoading)?Container(
                                                      width: 180,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white70,
                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                      ),
                                                    ):Row(
                                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                                      textBaseline: TextBaseline.alphabetic,
                                                      textDirection: TextDirection.ltr,
                                                      children: [
                                                        Text("${(justHouseFee==null || justHouseFee.isEmpty)?"N/A":justHouseFee[0].amount}".split(".")[0].replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'), textDirection: TextDirection.ltr, style: TextStyle(fontFamily: "Roboto", fontSize: 24, color: Colors.white),),
                                                        SizedBox(width: 5),
                                                        Text("IQD", textDirection: TextDirection.ltr, style: TextStyle(fontFamily: "Roboto", fontSize: 16, color: Colors.white),),
                                                      ],
                                                    ),
                                                    // SizedBox(
                                                    //   height: 2,
                                                    // ),
                                                    (getUserProperties.isLoading || getUserPayments.isLoading)?SizedBox(
                                                      height: 3,
                                                    ):Container(
                                                      width: 160,
                                                      height: 1,
                                                      margin: EdgeInsets.symmetric(vertical: 2),
                                                      decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            colors: [
                                                              Colors.white10,
                                                              Colors.white,
                                                              Colors.white10,
                                                            ]
                                                        ),
                                                      ),
                                                    ),
                                                    (getUserProperties.isLoading || getUserPayments.isLoading || getUserPayments.allHousePayments?.eachHousePayment==[])?Container(
                                                      width: 180,
                                                      height: 20,
                                                      margin: EdgeInsets.only(bottom: 5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white70,
                                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                                      ),
                                                    ):Row(
                                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                                      textBaseline: TextBaseline.alphabetic,
                                                      textDirection: TextDirection.ltr,
                                                      children: [
                                                        Text("${(justHouseFee==null || justHouseFee.isEmpty)?"N/A":(double.parse("${justHouseFee[0].amount??12}") /12)}".split(".")[0].replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'), textDirection: TextDirection.ltr, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Roboto"),),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text("IQD/Month", style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: "Roboto"),),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: hei1*0.15,
                                                  height: hei1*0.15,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(100.sp),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Icon((justHouseFee.length==0?false:(justHouseFee[0].isPaid==0))?CupertinoIcons.arrow_up_right:Icons.check_rounded, size: (justHouseFee.length==0?false:(justHouseFee[0].isPaid==0))?hei1*0.16:hei1*0.14, color: Colors.black,),
                                                  ),
                                                ).animate(onComplete: (controller)=> controller.loop(reverse: false, min: 0)).shimmer(curve: Curves.easeInOut, duration: 10.seconds),
                                              ],
                                            ),
                                            Column(
                                              textDirection: TextDirection.ltr,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                (getUserProperties.isLoading || getUserPayments.isLoading)?Container(
                                                  width: 150,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  ),
                                                ):SpecialCustomDropDownMenu("Property", 160, 30, 8, Color(0xff749CAD), Colors.white, getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses, getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.apartments, selectedProperty, (val) async {
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
                                                  justHouseFee.clear();
                                                  if(Provider.of<GetUserPayments>(context, listen: false).thisMonthPayment?.eachHouseFee!=null){
                                                    for(HouseFee each in Provider.of<GetUserPayments>(context, listen: false).thisMonthPayment!.eachHouseFee!){
                                                      if(each.feeType=="house fee"){
                                                        justHouseFee.add(each);
                                                      }
                                                    }
                                                  }

                                                  for(HouseFee each in justHouseFee){
                                                    print("!!!!!! ${each.feeType}");
                                                  }
                                                }),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  textDirection: TextDirection.ltr,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    (getUserProperties.isLoading || getUserPayments.isLoading || getUserPayments.allHousePayments?.eachHousePayment==[])?Container(
                                                      width: wid1*0.6,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white70,
                                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                                      ),
                                                    ):Stack(
                                                      alignment: Alignment.centerLeft,
                                                      children: [
                                                        Container(
                                                          height: 30,
                                                          width: wid1*0.6,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(
                                                              Radius.circular(100),
                                                            ),
                                                            color: Color(0xff749CAD),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 30, //differenceInMonths(DateTime.parse(getUserPayments.allHousePayments?.eachHousePayment?[0].startDate??"2023-03-22"), DateTime(2023, 3, 22))
                                                          width: (justHouseFee==null || justHouseFee.isEmpty)?0:(wid1*0.6)* (justHouseFee.length==0?0:(justHouseFee.length-(justHouseFee[0].isPaid==0?1:0)))/(differenceInMonths(DateTime(2023, 3, 22), DateTime.parse(justHouseFee[0].startDate??"2023-03-22"))!=0?differenceInMonths(DateTime(2023, 3, 22), DateTime.parse(justHouseFee[0].startDate??"2023-03-22")):1),//  (((getUserPayments.thisMonthPayment?.eachHouseFee?.length??12)-((getUserPayments.thisMonthPayment?.eachHouseFee?.length==0?false:(getUserPayments.thisMonthPayment?.eachHouseFee?[0].isPaid==0))?1:0))/12),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(100),
                                                              topRight: Radius.circular(25),
                                                              bottomLeft: Radius.circular(100),
                                                              bottomRight: Radius.circular(25),
                                                            ),
                                                            gradient: LinearGradient(
                                                              colors: [
                                                                Color(0xff749CAD),
                                                                Colors.white,
                                                              ],
                                                              begin: Alignment.centerLeft,
                                                              end: Alignment.centerRight,
                                                            ),
                                                          ),
                                                        ).animate().scaleX(duration: 1.seconds, curve: Curves.easeOut),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    (getUserProperties.isLoading || getUserPayments.isLoading)?Container(
                                                      width: 40,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white70,
                                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                                      ),
                                                    ):(justHouseFee==null || justHouseFee.isEmpty)?Text("N/A",textDirection: TextDirection.ltr, style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: "Roboto"),):Text("${(justHouseFee.length)-((justHouseFee.length==0?false:(justHouseFee[0].isPaid==0))?1:0)}/${differenceInMonths(DateTime.parse(justHouseFee[0].startDate??"2023-03-22"), DateTime.parse(justHouseFee[0].endDate??"2024-03-22"))}",textDirection: TextDirection.ltr, style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: "Roboto"),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ),
                                  ),
                                ),
                                wid>600?SizedBox(
                                  height: wid>600?15.sp:20,
                                ):SizedBox(),
                                wid>600?GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                      return FAQScreen();
                                    }));
                                  },
                                  child: Container(
                                    width: wid,
                                    height: wid1*0.1,
                                    decoration: BoxDecoration(
                                      color: cTheme.primaryColorLight,
                                      borderRadius: BorderRadius.all(Radius.circular(10.sp),),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(lChanger[6]["faq"], style: TextStyle(color: cTheme.primaryColorDark,),),
                                        Text("FAQ", style: TextStyle(color: cTheme.primaryColorDark, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ):SizedBox(),
                              ],
                            ),
                          ).animate().slideY(duration: 2.seconds, curve: Curves.linearToEaseOut),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          width: wid2,
                          height: hei2,
                          padding: EdgeInsets.all(10),
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // getGetSelf.getSelfResponse?.userDetails?.name=="Dr. Melany Feeney PhD"
                                  (!getGetSelf.rolesResponse!.roles!.contains("employee") || getGetSelf.rolesResponse!.roles!=null)?GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return EngineeringScreen();
                                      }));
                                    },
                                    child: Container(
                                      width: wid2/2-20,
                                      height: hei2/2-20,
                                      decoration: BoxDecoration(
                                        color: cTheme.primaryColorLight,
                                        borderRadius: BorderRadius.all(Radius.circular(wid>600?20.sp:45.sp),),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.engineering_rounded, color: cTheme.primaryColor, size: 40,),
                                          SizedBox(height: 10,),
                                          Text(lChanger[6]["employee"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                        ],
                                      ),
                                    )
                                  ):SizedBox(),
                                  // GestureDetector(
                                  //   onTap: (){
                                  //     Navigator.push(context, MaterialPageRoute(builder: (context){
                                  //       return ServicesScreen();
                                  //     }));
                                  //   },
                                  //   child: badges.Badge(
                                  //     badgeContent: Text("1", style: TextStyle(color: cTheme.primaryColorDark),),
                                  //     showBadge: false,
                                  //     child: Container(
                                  //       width: wid2/2-20,
                                  //       height: hei2/2-20,
                                  //       decoration: BoxDecoration(
                                  //         color: cTheme.primaryColorLight,
                                  //         borderRadius: BorderRadius.all(Radius.circular(wid>600?20.sp:45.sp),),
                                  //       ),
                                  //       child: Column(
                                  //         mainAxisAlignment: MainAxisAlignment.center,
                                  //         children: [
                                  //           Icon(CupertinoIcons.rectangle_grid_2x2_fill, color: cTheme.primaryColor, size: 40,),
                                  //           SizedBox(height: 10,),
                                  //           Text(lChanger[6]["services"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                  GestureDetector(
                                    onTap: () async{
                                      // showDialog(
                                      //     context: context,
                                      //     // barrierColor: cTheme.backgroundColor,
                                      //     builder: (BuildContext context){
                                      //       return AlertDialog(
                                      //         actionsPadding: EdgeInsets.all(0),
                                      //         contentPadding: EdgeInsets.all(5),
                                      //         backgroundColor: Colors.transparent,
                                      //         surfaceTintColor: Colors.transparent,
                                      //         // shape: RoundedRectangleBorder(
                                      //         //   borderRadius: BorderRadius.circular(45),
                                      //         // ),
                                      //         content: LoadingIndicator(cTheme.scaffoldBackgroundColor),
                                      //       );
                                      //     });
                                      // await getUserProperties.getUserProperties();
                                      // print(getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses);
                                      // if(getUserProperties.userHousesAndApartmentsResponse?.status=="success"){
                                      //   Navigator.of(context).pop();
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return PropertiesScreen();
                                      }));
                                      // }else{
                                      //   Navigator.of(context).pop();
                                      //   CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), "An error occurred", cTheme.primaryColorLight, cTheme.primaryColorDark);
                                      // }
                                    },
                                    child: Container(
                                      // width: getGetSelf.getSelfResponse?.userDetails?.name=="Dr. Melany Feeney PhD"
                                          width: !getGetSelf.rolesResponse!.roles!.contains("employee")?wid2/2-20:wid2-20,
                                      height: hei2/2-20,
                                      decoration: BoxDecoration(
                                        color: cTheme.primaryColorLight,
                                        borderRadius: BorderRadius.all(Radius.circular(wid>600?20.sp:45.sp),),
                                        image: DecorationImage(
                                          image: AssetImage("images/houses+buildings.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(wid>600?20.sp:45.sp),),
                                          color: Colors.black45,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.keyboard_arrow_up_rounded, color: Colors.white, size: 50,).animate(onComplete: (controller)=> controller.loop(reverse: true,)).moveY(duration: 2.seconds, curve: Curves.easeInOut),
                                            Text(lChanger[6]["properties"], style: TextStyle(color: Colors.white, fontSize: 16),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async{
                                      // showDialog(
                                      //     context: context,
                                      //     // barrierColor: cTheme.backgroundColor,
                                      //     builder: (BuildContext context){
                                      //       return AlertDialog(
                                      //         actionsPadding: EdgeInsets.all(0),
                                      //         contentPadding: EdgeInsets.all(5),
                                      //         backgroundColor: Colors.transparent,
                                      //         surfaceTintColor: Colors.transparent,
                                      //         // shape: RoundedRectangleBorder(
                                      //         //   borderRadius: BorderRadius.circular(45),
                                      //         // ),
                                      //         content: LoadingIndicator(cTheme.scaffoldBackgroundColor),
                                      //       );
                                      //     });
                                      //   await getRepairment.getAllRepair();
                                      //   Navigator.of(context).pop();
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                        return RepairHistory();
                                      }));
                                    },
                                    child: Container(
                                      width: wid2/2-20,
                                      height: hei2/2-20,
                                      decoration: BoxDecoration(
                                        color: cTheme.primaryColorLight,
                                        borderRadius: BorderRadius.all(Radius.circular(wid>600?20.sp:45.sp),),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.handyman_rounded, color: cTheme.primaryColor, size: 40,),
                                          SizedBox(height: 10,),
                                          Text(lChanger[6]["randm"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16), textAlign: TextAlign.center,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: (){
                                  //     Navigator.push(context, MaterialPageRoute(builder: (context){
                                  //       return ProfileScreen();
                                  //     }));
                                  //   },
                                  //   child: Container(
                                  //     width: wid2/2-20,
                                  //     height: hei2/2-20,
                                  //     decoration: BoxDecoration(
                                  //       color: cTheme.primaryColorLight,
                                  //       borderRadius: BorderRadius.all(Radius.circular(wid>600?20.sp:45.sp),),
                                  //       image: DecorationImage(
                                  //         image: AssetImage("images/city1-removebg-preview.png"),
                                  //         fit: BoxFit.contain,
                                  //       ),
                                  //     ),
                                  //     child: Container(
                                  //       padding: EdgeInsets.all(20),
                                  //       decoration: BoxDecoration(
                                  //         gradient: LinearGradient(
                                  //           colors: [
                                  //             Colors.transparent,
                                  //             Colors.transparent,
                                  //             Colors.transparent,
                                  //             Color(0x77343434),
                                  //             Colors.black,
                                  //           ],
                                  //           begin: Alignment.topCenter,
                                  //           end: Alignment.bottomCenter,
                                  //         ),
                                  //         borderRadius: BorderRadius.all(
                                  //           Radius.circular(wid>600?20.sp:45.sp),
                                  //         ),
                                  //       ),
                                  //       child: Column(
                                  //         mainAxisAlignment: MainAxisAlignment.end,
                                  //         children: [
                                  //           Icon(CupertinoIcons.chevron_up, color: Colors.white, size: 25,).animate(onComplete: (controller)=> controller.loop(reverse: true)).moveY(curve: Curves.easeInOut, duration: 2.seconds),
                                  //           Text(lChanger[6]["area"], style: TextStyle(color: Colors.white, fontSize: 16),),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                  GestureDetector(
                                    onTap: ()async{
                                      // showDialog(
                                      //     context: context,
                                      //     // barrierColor: cTheme.backgroundColor,
                                      //     builder: (BuildContext context){
                                      //       return AlertDialog(
                                      //         actionsPadding: EdgeInsets.all(0),
                                      //         contentPadding: EdgeInsets.all(5),
                                      //         backgroundColor: Colors.transparent,
                                      //         surfaceTintColor: Colors.transparent,
                                      //         // shape: RoundedRectangleBorder(
                                      //         //   borderRadius: BorderRadius.circular(45),
                                      //         // ),
                                      //         content: LoadingIndicator(cTheme.scaffoldBackgroundColor),
                                      //       );
                                      //     });
                                      //   await getProtests.getAllProtests();
                                      // Navigator.of(context).pop();
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                          return ProtestHistory();
                                        }));
                                    },
                                    child: Container(
                                      width: wid2/2-20,
                                      height: hei2/2-20,
                                      decoration: BoxDecoration(
                                        color: cTheme.primaryColorLight,
                                        borderRadius: BorderRadius.all(Radius.circular(wid>600?20.sp:45.sp),),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.note_alt_outlined, color: cTheme.primaryColor, size: 40,),
                                          SizedBox(height: 10,),
                                          Text(lChanger[6]["protest"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ).animate().slideY(duration: 2.seconds, curve: Curves.linearToEaseOut, begin: 1),
                      ],
                    ),
                  ),
                  Positioned(
                    top: _indicatorPosition,
                    left: 0,
                      right: 0,
                      child: _indicatorPosition>100?LoadingIndicator(cTheme.primaryColorLight):FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: cTheme.primaryColorLight,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(26/((_indicatorPosition>0?_indicatorPosition+30:0)/40)),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ),
        ),);
      }
    );
  }
}
