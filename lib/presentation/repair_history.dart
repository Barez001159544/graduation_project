import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graduation_project/constants/loading_indicator.dart';
import 'package:graduation_project/controllers/get_protests.dart';
import 'package:graduation_project/controllers/get_repairment.dart';
import 'package:graduation_project/presentation/protest_new.dart';
import 'package:graduation_project/presentation/repair_new.dart';
import 'package:provider/provider.dart';

import '../constants/confirmation_custom_alert_dialog.dart';
import '../constants/custom_textfields.dart';
import '../constants/custom_appbar.dart';
import '../constants/custom_toast_notification.dart';
import '../constants/main_btn.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class RepairHistory extends StatefulWidget {
  const RepairHistory({super.key});

  @override
  State<RepairHistory> createState() => _RepairHistoryState();
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

class _RepairHistoryState extends State<RepairHistory> {
  TextEditingController titleController = TextEditingController();
  TextEditingController coreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if((Provider.of<GetRepairment>(context, listen: false).repairHistoryResponse==null)){
        Provider.of<GetRepairment>(context, listen: false).getAllRepair();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer3<ThemeChanger, LanguageChanger, GetRepairment>(
        builder: (_, tChanger, languageChanger, getRepairment, child) {
          lChanger=languageChanger.data;
          return Directionality(
            textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: cTheme.primaryColorLight,
              appBar: CustomAppBar(cTheme.primaryColorLight, lChanger[9]["title1"], cTheme.primaryColorDark, context),
              floatingActionButton: FloatingActionButton(
                foregroundColor: cTheme.primaryColor,
                backgroundColor: cTheme.primaryColor,
                focusColor: cTheme.primaryColor,
                tooltip: lChanger[9]["fab"],
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return NewRepair();
                  }));
                },
                child: Icon(Icons.add_rounded, color: Colors.white,),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              body: SafeArea(
                child: getRepairment.isLoading?Center(
                  child: LoadingIndicator(cTheme.primaryColorLight),
                ):RefreshIndicator(
                  onRefresh: () async{
                    getRepairment.getAllRepair();
                  },
                  child: ((getRepairment.repairHistoryResponse?.historyOfRepairs)==null || getRepairment.repairHistoryResponse!.historyOfRepairs!.isEmpty)?ListView(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.satellite_alt_rounded, color: cTheme.primaryColorDark, size: 70,),
                            SizedBox(height: 10,),
                            Text(lChanger[9]["empty"], style: TextStyle(color: Colors.grey, fontSize: 12),),
                          ],
                        ),
                      ),
                    ],
                  ):ListView(
                    children: List.generate(getRepairment.repairHistoryResponse!.historyOfRepairs!.length, (index){
                      return Slidable(
                        // Specify a key if the Slidable is dismissible.
                        // key: const ValueKey(0),

                        // The start action pane is the one at the left or the top side.
                        // startActionPane: ActionPane(
                        //   // A motion is a widget used to control how the pane animates.
                        //   motion: const ScrollMotion(),
                        //
                        //   // A pane can dismiss the Slidable.
                        //   dismissible: DismissiblePane(onDismissed: () {}),
                        //
                        //   // All actions are defined in the children parameter.
                        //   // children: [
                        //   //   // A SlidableAction can have an icon and/or a label.
                        //   //   SlidableAction(
                        //   //     backgroundColor: Color(0xFFFE4A49),
                        //   //     foregroundColor: Colors.white,
                        //   //     icon: Icons.delete,
                        //   //     label: 'Delete', onPressed: (BuildContext context) {  },
                        //   //   ),
                        //   //   SlidableAction(
                        //   //     backgroundColor: Color(0xFF21B7CA),
                        //   //     foregroundColor: Colors.white,
                        //   //     icon: Icons.share,
                        //   //     label: 'Share', onPressed: (BuildContext context) {  },
                        //   //   ),
                        //   // ],
                        // ),

                        // The end action pane is the one at the right or the bottom side.
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            // A SlidableAction can have an icon and/or a label.
                            SlidableAction(
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: lChanger[9]["action"],
                              onPressed: (BuildContext ctx) async {
                                await getRepairment.deleteProtest(getRepairment.repairHistoryResponse?.historyOfRepairs?[index].id);
                                if(getRepairment.delStatus=="OK"){
                                  getRepairment.getAllRepair();
                                  CustomToastNotification(context, Icon(Icons.check_circle_outline_rounded, color: Colors.green,), lChanger[9]["delNotify1"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                }else{
                                  CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[9]["delNotify2"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                }
                            },
                            ),
                            // SlidableAction(
                            //   backgroundColor: Color(0xFF21B7CA),
                            //   foregroundColor: Colors.white,
                            //   icon: Icons.share,
                            //   label: 'Share', onPressed: (BuildContext context) {  },
                            // ),
                          ],
                        ),

                        // The child of the Slidable is what the user sees when the
                        // component is not dragged.
                        child: Theme(
                          data: cTheme.copyWith(
                            dividerColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            childrenPadding: EdgeInsets.all(10),
                            iconColor: Colors.transparent,
                            trailing: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: //getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?Colors.yellow.withOpacity(0.4):Colors.green.withOpacity(0.4),
                                getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?Colors.yellow.withOpacity(0.4):(getRepairment!.repairHistoryResponse!.historyOfRepairs?[index].status=="approved"?Colors.blue.withOpacity(0.4):(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="rejected"?Colors.red.withOpacity(0.4):Colors.green.withOpacity(0.4))),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?Icons.more_horiz_rounded:Icons.check, color: cTheme.primaryColorDark,),
                                  // Text(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?lChanger[9]["status2"]:lChanger[9]["status1"], style: TextStyle(fontSize: 8),),
                                  //---------------
                                  Icon(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?Icons.timelapse_rounded:(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="approved"?Icons.more_horiz_rounded:getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="rejected"?Icons.close_rounded:Icons.check_rounded), color: cTheme.primaryColorDark,),
                                  Text(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?lChanger[9]["status1"]:(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="approved"?lChanger[9]["status2"]:(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="rejected"?lChanger[9]["status3"]:lChanger[9]["status4"])), style: TextStyle(fontSize: 8),),
                                ],
                              ),
                            ),
                            backgroundColor: Colors.transparent,
                            collapsedBackgroundColor: Colors.transparent,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FittedBox(
                                    child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${languageChanger.selectedLanguage=="ENG"?items[items.indexOf(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].title??"Others")]:(languageChanger.selectedLanguage=="ENG"?itemsInArabic[items.indexOf(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].title??"Others")]:itemsInKurdish[items.indexOf(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].title??"Others")])}", style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark),),
                                            Text("${getRepairment.repairHistoryResponse!.historyOfRepairs?[index].updatedAt?.split("T")[0]}", style: TextStyle(color: Colors.grey, fontSize: 12),),
                                          ],
                                        ))),
                                SizedBox(
                                  width: 10,
                                ),
                                // Container(
                                //   width: 60,
                                //   height: 60,
                                //   decoration: BoxDecoration(
                                //     color: //getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?Colors.yellow.withOpacity(0.4):Colors.green.withOpacity(0.4),
                                //     getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?Colors.yellow.withOpacity(0.4):(getRepairment!.repairHistoryResponse!.historyOfRepairs?[index].status=="approved"?Colors.blue.withOpacity(0.4):(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="rejected"?Colors.red.withOpacity(0.4):Colors.green.withOpacity(0.4))),
                                //     borderRadius: BorderRadius.all(Radius.circular(15)),
                                //   ),
                                //   child: Column(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       // Icon(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?Icons.more_horiz_rounded:Icons.check, color: cTheme.primaryColorDark,),
                                //       // Text(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?lChanger[9]["status2"]:lChanger[9]["status1"], style: TextStyle(fontSize: 8),),
                                //       //---------------
                                //       Icon(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?Icons.timelapse_rounded:(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="approved"?Icons.more_horiz_rounded:getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="rejected"?Icons.close_rounded:Icons.check_rounded), color: cTheme.primaryColorDark,),
                                //       Text(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?lChanger[16]["status1"]:(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="approved"?lChanger[16]["status2"]:(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="rejected"?lChanger[16]["status3"]:lChanger[16]["status4"])), style: TextStyle(fontSize: 8),),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                            // subtitle: Text(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].requestDate?.split(" ")[0]??"N/A", style: TextStyle(color: Colors.grey, fontSize: 10),),
                            children: [
                              Row(
                                children: [
                                  Text("${lChanger[3]["acceptedBy"]}: ", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 12, fontWeight: FontWeight.bold),),
                                  Text("${getRepairment.repairHistoryResponse!.historyOfRepairs?[index].acceptedBy??lChanger[3]["ns"]}", style: TextStyle(fontSize: 12, color: cTheme.primaryColorDark),),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(child: Text(overflow: TextOverflow.ellipsis, maxLines: 10, "${getRepairment.repairHistoryResponse!.historyOfRepairs?[index].description??lChanger[3]["ns"]}", style: TextStyle(fontSize: 12, color: cTheme.primaryColorDark),)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        )
                        // Container(
                        //   padding: EdgeInsets.all(10),
                        //   decoration: BoxDecoration(
                        //     color: cTheme.primaryColorLight,
                        //     border: Border(
                        //       bottom: BorderSide(width: 10, color: cTheme.primaryColorLight),
                        //     ),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       FittedBox(
                        //           child: Container(
                        //               child: Column(
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   Text("${getRepairment.repairHistoryResponse!.historyOfRepairs?[index].title??"N/A"}", style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark),),
                        //                   Text("${getRepairment.repairHistoryResponse!.historyOfRepairs?[index].updatedAt?.split("T")[0]}", style: TextStyle(color: Colors.grey, fontSize: 12),),
                        //                 ],
                        //               ))),
                        //       SizedBox(
                        //         width: 10,
                        //       ),
                        //       Container(
                        //         width: 60,
                        //         height: 60,
                        //         decoration: BoxDecoration(
                        //           color: //getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?Colors.yellow.withOpacity(0.4):Colors.green.withOpacity(0.4),
                        //           getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?Colors.yellow.withOpacity(0.4):(getRepairment!.repairHistoryResponse!.historyOfRepairs?[index].status=="approved"?Colors.blue.withOpacity(0.4):(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="rejected"?Colors.red.withOpacity(0.4):Colors.green.withOpacity(0.4))),
                        //           borderRadius: BorderRadius.all(Radius.circular(15)),
                        //         ),
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             // Icon(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?Icons.more_horiz_rounded:Icons.check, color: cTheme.primaryColorDark,),
                        //             // Text(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?lChanger[9]["status2"]:lChanger[9]["status1"], style: TextStyle(fontSize: 8),),
                        //             //---------------
                        //             Icon(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?Icons.timelapse_rounded:(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="approved"?Icons.more_horiz_rounded:getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="rejected"?Icons.close_rounded:Icons.check_rounded), color: cTheme.primaryColorDark,),
                        //             Text(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="pending"?lChanger[16]["status1"]:(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="approved"?lChanger[16]["status2"]:(getRepairment.repairHistoryResponse!.historyOfRepairs?[index].status=="rejected"?lChanger[16]["status3"]:lChanger[16]["status4"])), style: TextStyle(fontSize: 8),),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
