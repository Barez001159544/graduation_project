import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project/controllers/get_engineering.dart';
import 'package:graduation_project/controllers/get_get_self.dart';
import 'package:graduation_project/controllers/get_token.dart';
import 'package:graduation_project/controllers/get_user_properties.dart';
import 'package:graduation_project/presentation/repair_history.dart';
import 'package:provider/provider.dart';

import '../constants/confirmation_custom_alert_dialog.dart';
import '../constants/custom_appbar.dart';
import '../constants/custom_dropdown_menu.dart';
import '../constants/custom_toast_notification.dart';
import '../constants/loading_indicator.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';
import '../models/accept_repairment_request.dart';
import 'login_screen.dart';

class EngineeringScreen extends StatefulWidget {
  const EngineeringScreen({super.key});

  @override
  State<EngineeringScreen> createState() => _EngineeringScreenState();
}

List items=[
  //Appliances
  "TV",
  "laundry machines",
  "water heaters",
  "Refrigerator",
  "Dishwasher",
  "Air Conditioner",
  "Heater",
  //Furniture Pieces
  "Table",
  "Bed Frame",
  "Chairs",
  //Structural Issues
  "Plumbing",
  "Electrical Systems",
  "Windows and doors",
  "House Structure",
  //Others
  "Others (Write in description)",
];

List itemsInArabic=[
  //Appliances
  "تلفاز",
  "آلات الغسيل",
  "سخانات المياه",
  "ثلاجة",
  "غسالة صحون",
  "مكيف هواء",
  "مدفأة",
  //Furniture Pieces
  "طاولة",
  "إطار السرير",
  "كراسي",
  //Stractural Issues
  "السباكة",
  "أنظمة الكهرباء",
  "النوافذ والأبواب",
  "هيكل المنزل",
  //Others
  "أخرى (اكتب في الوصف)",
];

List itemsInKurdish=[
  //Appliances
  "TV",
  "جلشۆر",
  "گەرمکەری ئاو",
  "بەفرگر",
  "قاپشۆر",
  "فێنککەرەوە",
  "گەرمکەرەوە",
  //Furniture Pieces
  "مێز",
  "جێگای نووستن",
  "قەنەفە",
  //Structural Issues
  "ئاو و ئاوەڕۆ",
  "سیستەمەی کارەبا",
  "دەرگا و پەنجەرە",
  "شێوەی خانوو",
  //Others
  "هیتر (لە دەربارە بینووسە)",
];

List components=[
  "Appliances",
  "Furniture Pieces",
  "Structural Issues",
  "Others",
];

List componentsInArabic=[
  "الأجهزة",
  "قطع الأثاث",
  "مشاكل هيكلية",
  "أخرى",
];
List componentsInKurdish=[
  "ئامێرەکان",
  "مۆبیلیات",
  "شێوازی خانو",
  "هیتر",
];

class _EngineeringScreenState extends State<EngineeringScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetEngineering>(context, listen: false).getAllRepair();
      Provider.of<GetUserProperties>(context, listen: false).getAllHouses();
      Provider.of<GetUserProperties>(context, listen: false).getAllApartments();

      Timer.periodic(Duration(seconds: 5), (Timer t) {
        if (mounted) {
          Provider.of<GetEngineering>(context, listen: false).customGetAllRepair();
          print("Llama");
        } else {
          // Cancel the timer if the widget is no longer mounted
          t.cancel();
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme:lightTheme;
    List lChanger;
    return Consumer6<LanguageChanger, GetEngineering, GetUserProperties, GetToken, GetGetSelf, ThemeChanger>(
        builder: (_, languageChanger, getEngineering, getUserProperties, getToken, getGetSelf, tChanger, __) {
          lChanger= languageChanger.data;
          return Directionality(
            textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              // backgroundColor: cTheme.scaffoldBackgroundColor,
              appBar: AppBar(
                // backgroundColor: cTheme.scaffoldBackgroundColor,
                scrolledUnderElevation: 0,
                title: Text(lChanger[3]["title"], style: TextStyle(color: cTheme.primaryColorDark),),
                leading: Builder(
                  builder: (BuildContext){
                    return IconButton(onPressed: (){
                      print("Log Out");
                      getGetSelf.rolesResponse!.roles!.contains("resident")?Navigator.of(context).pop():ConfirmationCustomAlertDialog(cTheme.primaryColorLight, cTheme.primaryColorDark, lChanger[0]["confirmationTitle"], lChanger[0]["confirmationSubtitle"], lChanger[0]["confirmationAccept"], lChanger[0]["confirmationDecline"], context, (){
                        showDialog(
                            context: context,
                            // barrierColor: cTheme.backgroundColor,
                            builder: (context){
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
                      icon: RotatedBox(
                          quarterTurns: languageChanger.selectedLanguage=="ENG"?2:0,
                          child: Icon(Icons.logout_rounded, color: cTheme.primaryColorDark,)),
                    );
                  },
                ),
                actions: [
                  getGetSelf.rolesResponse!.roles!.contains("resident")?SizedBox():CustomDropDownMenu("Lang", 80, 30, 5, cTheme.scaffoldBackgroundColor, cTheme.primaryColorDark, ["KRD", "ARB", "ENG"], languageChanger.selectedLanguage, (val) {
                    print(val);
                    languageChanger.changeLanguage(val);
                  }),
                  getGetSelf.rolesResponse!.roles!.contains("resident")?SizedBox():Builder(
                    builder: (BuildContext){
                      return IconButton(onPressed: (){
                        // setState(() {
                        //   if(tChanger.isDark){
                        //     cTheme=darkTheme;
                        //   }else{
                        //     cTheme=lightTheme;
                        //   }
                        // });
                        tChanger.changeTheme();
                      },
                        icon: Icon(tChanger.isDark?Icons.dark_mode_rounded:Icons.light_mode_rounded, color: cTheme.primaryColorDark,),
                      );
                    },
                  ),
                ],
              ),
              body: SafeArea(
                child: (getEngineering.isLoading)?LoadingIndicator(cTheme.primaryColorLight):
                Center(
                  child: Flex(
                    direction: wid>500?Axis.horizontal:Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: hei,
                          // color: Colors.blue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.engineering_rounded, color: cTheme.primaryColor, size: 112,),
                              Text(getGetSelf.getSelfResponse!.userDetails!.name),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: hei,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          // color: Colors.red,
                          child: RefreshIndicator(
                            onRefresh: () async{
                              getEngineering.getAllRepair();
                            }, child: ((getEngineering.repairHistoryResponse?.historyOfRepairs)==null || getEngineering.repairHistoryResponse!.historyOfRepairs!.isEmpty)?ListView(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.satellite_alt_rounded, size: 70,),
                                    SizedBox(height: 10,),
                                    Text(lChanger[9]["empty"], style: TextStyle(color: Colors.grey, fontSize: 12),),
                                  ],
                                ),
                              ),
                            ],
                          ):
                              ListView(
                                children: List.generate(getEngineering.repairHistoryResponse!.historyOfRepairs!.length, (index){
                                  return Container(
                                    margin: EdgeInsets.only(top: 10, bottom: index==getEngineering.repairHistoryResponse!.historyOfRepairs!.length-1?10:0),
                                    decoration: BoxDecoration(
                                      color: cTheme.primaryColorLight,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      // border: Border.all(
                                      //   width: 1,
                                      //   color: Colors.grey,
                                      // ),
                                    ),
                                    child: Theme(
                                      data: cTheme.copyWith(
                                        dividerColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                      ),
                                      child: ExpansionTile(
                                        tilePadding: EdgeInsets.symmetric(horizontal: 10),
                                        childrenPadding: EdgeInsets.all(10),
                                        iconColor: Colors.transparent,
                                        trailing: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: //getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?Colors.yellow.withOpacity(0.4):Colors.green.withOpacity(0.4),
                                            getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="pending"?Colors.yellow.withOpacity(0.4):(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="approved"?Colors.blue.withOpacity(0.4):(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="rejected"?Colors.red.withOpacity(0.4):Colors.green.withOpacity(0.4))),
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Icon(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?Icons.more_horiz_rounded:Icons.check, color: cTheme.primaryColorDark,),
                                              // Text(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?lChanger[15]["status2"]:lChanger[15]["status1"], style: TextStyle(fontSize: 8),),
                                              //---------------
                                              Icon(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="pending"?Icons.timelapse_rounded:(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="approved"?Icons.more_horiz_rounded:getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="rejected"?Icons.close_rounded:Icons.check_rounded), color: cTheme.primaryColorDark,),
                                              Text(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="pending"?lChanger[3]["status1"]:(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="approved"?lChanger[3]["status2"]:(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="rejected"?lChanger[3]["status3"]:lChanger[3]["status4"])), style: TextStyle(fontSize: 8),),
                                            ],
                                          ),
                                        ),
                                        backgroundColor: Colors.transparent,
                                        collapsedBackgroundColor: Colors.transparent,
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${getEngineering.repairHistoryResponse?.historyOfRepairs![index].location?.split("-")[0]}-${getUserProperties.fullyApartmentsResponse?.eachApartmentsResponse?.firstWhere((obj)=>obj.id==getEngineering.repairHistoryResponse!.historyOfRepairs?[index].id).name}", style: TextStyle(fontSize: 16),),
                                            SizedBox(),
                                            // Text(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status??"N/A", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                          ],
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].requestDate?.split(" ")[0]??"N/A", style: TextStyle(color: Colors.grey, fontSize: 10),),
                                            SizedBox(),
                                          ],
                                        ),
                                        children: [
                                          Row(
                                            children: [
                                              Text("${lChanger[3]["rTitle"]}: ", style: TextStyle(color: Colors.grey, fontSize: 12,),),
                                              Text(languageChanger.selectedLanguage=="ENG"?items[items.indexOf(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].title??"Others")]:(languageChanger.selectedLanguage=="ENG"?itemsInArabic[items.indexOf(getEngineering.repairHistoryResponse!.historyOfRepairs?[index].title??"Others")]:itemsInKurdish[items.indexOf(getEngineering.repairHistoryResponse!.historyOfRepairs?[index].title??"Others")]), style: TextStyle(fontSize: 14),),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text("${lChanger[3]["rComponent"]}: ", style: TextStyle(color: Colors.grey, fontSize: 12,),),
                                              Text(languageChanger.selectedLanguage=="ENG"?components[components.indexOf(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].repairmentComponents??"Others")]:(languageChanger.selectedLanguage=="ARB"?componentsInArabic[components.indexOf(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].repairmentComponents??"Others")]:componentsInKurdish[components.indexOf(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].repairmentComponents??"Others")])??"N/A", style: TextStyle(fontSize: 14),),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text("${lChanger[3]["acceptedBy"]}: ", style: TextStyle(color: Colors.grey, fontSize: 12,),),
                                              Text(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].acceptedBy??"${lChanger[3]["ns"]}", style: TextStyle(fontSize: 12),),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(child: Text(overflow: TextOverflow.ellipsis, maxLines: 10, getEngineering.repairHistoryResponse?.historyOfRepairs?[index].description??"${lChanger[3]["ns"]}", style: TextStyle(fontSize: 12),)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          (getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="completed" || getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="rejected")?SizedBox():Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () async{
                                                    showDialog(
                                                        context: context,
                                                        // barrierColor: cTheme.backgroundColor,
                                                        builder: (BuildContext context){
                                                          return AlertDialog(
                                                            actionsPadding: EdgeInsets.all(0),
                                                            contentPadding: EdgeInsets.all(5),
                                                            backgroundColor: Colors.transparent,
                                                            surfaceTintColor: Colors.transparent,
                                                            content: LoadingIndicator(cTheme.scaffoldBackgroundColor),
                                                          );
                                                        });
                                                    await getEngineering.acceptRepairment(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].id, AcceptRepairmentRequest("rejected"));
                                                    if(getEngineering.status=="OK"){
                                                      CustomToastNotification(context, Icon(Icons.check_circle_outline_rounded, color: Colors.green,), lChanger[3]["notification1"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                                      getEngineering.customGetAllRepair();
                                                    }else{
                                                      CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[3]["notification2"], cTheme.scaffoldBackgroundColor, cTheme.primaryColorDark);
                                                    }
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.horizontal(
                                                        left: languageChanger.selectedLanguage=="ENG"?Radius.circular(10):Radius.zero,
                                                        right: languageChanger.selectedLanguage=="ENG"?Radius.zero:Radius.circular(10),
                                                      ),
                                                      color: Colors.red,
                                                    ),
                                                    child: Center(child: Text(lChanger[3]["btn1"])),
                                                  ),
                                                ),
                                              ),
                                              (getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="approved" || getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="completed")?SizedBox():Expanded(
                                                child: GestureDetector(
                                                  onTap: () async{
                                                    showDialog(
                                                        context: context,
                                                        // barrierColor: cTheme.backgroundColor,
                                                        builder: (BuildContext context){
                                                          return AlertDialog(
                                                            actionsPadding: EdgeInsets.all(0),
                                                            contentPadding: EdgeInsets.all(5),
                                                            backgroundColor: Colors.transparent,
                                                            surfaceTintColor: Colors.transparent,
                                                            content: LoadingIndicator(cTheme.scaffoldBackgroundColor),
                                                          );
                                                        });
                                                    await getEngineering.acceptRepairment(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].id, AcceptRepairmentRequest("approved"));
                                                    if(getEngineering.status=="OK"){
                                                      CustomToastNotification(context, Icon(Icons.check_circle_outline_rounded, color: Colors.green,), lChanger[3]["notification1"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                                      getEngineering.customGetAllRepair();
                                                    }else{
                                                      CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[3]["notification2"], cTheme.scaffoldBackgroundColor, cTheme.primaryColorDark);
                                                    }
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.horizontal(
                                                        right: languageChanger.selectedLanguage=="ENG"?Radius.circular(10):Radius.zero,
                                                        left: languageChanger.selectedLanguage=="ENG"?Radius.zero:Radius.circular(10),
                                                      ),
                                                      color: Colors.blue,
                                                    ),
                                                    child: Center(child: Text(lChanger[3]["btn2"])),
                                                  ),
                                                ),
                                              ),
                                              (getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="pending" || getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="completed")?SizedBox():Expanded(
                                                child: GestureDetector(
                                                  onTap: () async{
                                                    showDialog(
                                                        context: context,
                                                        // barrierColor: cTheme.backgroundColor,
                                                        builder: (BuildContext context){
                                                          return AlertDialog(
                                                            actionsPadding: EdgeInsets.all(0),
                                                            contentPadding: EdgeInsets.all(5),
                                                            backgroundColor: Colors.transparent,
                                                            surfaceTintColor: Colors.transparent,
                                                            content: LoadingIndicator(cTheme.scaffoldBackgroundColor),
                                                          );
                                                        });
                                                    await getEngineering.acceptRepairment(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].id, AcceptRepairmentRequest("completed"));
                                                    if(getEngineering.status=="OK"){
                                                      CustomToastNotification(context, Icon(Icons.check_circle_outline_rounded, color: Colors.green,), lChanger[3]["notification1"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                                      getEngineering.customGetAllRepair();
                                                    }else{
                                                      CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[3]["notification2"], cTheme.scaffoldBackgroundColor, cTheme.primaryColorDark);
                                                    }
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.horizontal(
                                                        right: languageChanger.selectedLanguage=="ENG"?Radius.circular(10):Radius.zero,
                                                        left: languageChanger.selectedLanguage=="ENG"?Radius.zero:Radius.circular(10),
                                                      ),
                                                      color: Colors.green,
                                                    ),
                                                    child: Center(child: Text(lChanger[3]["btn3"])),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                          ),
                          
                        ),
                      ),
                    ],
                  ),
                ),
                //Text(getEngineering?.repairHistoryResponse?.historyOfRepairs?[0].repairmentComponents??"NNN"),
              ),
            ),
          );
        }
    );
  }
}
