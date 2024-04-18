import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project/controllers/get_engineering.dart';
import 'package:graduation_project/controllers/get_user_properties.dart';
import 'package:provider/provider.dart';

import '../constants/custom_appbar.dart';
import '../constants/custom_toast_notification.dart';
import '../constants/loading_indicator.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';
import '../models/accept_repairment_request.dart';

class EngineeringScreen extends StatefulWidget {
  const EngineeringScreen({super.key});

  @override
  State<EngineeringScreen> createState() => _EngineeringScreenState();
}

class _EngineeringScreenState extends State<EngineeringScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetEngineering>(context, listen: false).getAllRepair();
      Provider.of<GetUserProperties>(context, listen: false).getAllHouses();
      Provider.of<GetUserProperties>(context, listen: false).getAllApartments();
    });
  }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme:lightTheme;
    List lChanger;
    return Consumer3<LanguageChanger, GetEngineering, GetUserProperties>(
        builder: (_, languageChanger, getEngineering, getUserProperties, __) {
          lChanger= languageChanger.data;
          return Directionality(
            textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              backgroundColor: cTheme.scaffoldBackgroundColor,
              appBar: CustomAppBar(cTheme.scaffoldBackgroundColor, "Engineering", cTheme.primaryColorDark, context),
              body: SafeArea(
                child: getEngineering.isLoading?LoadingIndicator(cTheme.primaryColorLight):Center(
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
                              Text("Dr. Melany Wood"),
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
                          child: SingleChildScrollView(
                            child: Column(
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
                                      dividerColor: cTheme.primaryColorLight,
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
                                            Text(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="pending"?lChanger[16]["status1"]:(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="approved"?lChanger[16]["status2"]:(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="rejected"?lChanger[16]["status3"]:lChanger[16]["status4"])), style: TextStyle(fontSize: 8),),
                                          ],
                                        ),
                                      ),
                                      backgroundColor: Colors.transparent,
                                      collapsedBackgroundColor: Colors.transparent,
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${getEngineering.repairHistoryResponse?.historyOfRepairs![index].location?.split("-")[0]}-${getUserProperties.fullyApartmentsResponse?.eachApartmentsResponse?.firstWhere((obj)=>obj.id==getEngineering.repairHistoryResponse!.historyOfRepairs?[index].id).name}", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                          Text(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].title??"N/A", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                          SizedBox(),
                                          // Text(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status??"N/A", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                        ],
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].requestDate?.split(" ")[0]??"N/A", style: TextStyle(color: Colors.grey, fontSize: 10),),
                                          Text(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].repairmentComponents??"N/A", style: TextStyle(color: Colors.grey, fontSize: 10),),
                                          SizedBox(),
                                        ],
                                      ),
                                      children: [
                                        Row(
                                          children: [
                                            Text("Accepted by: ", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 12, fontWeight: FontWeight.bold),),
                                            Text(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].acceptedBy??"not-specified", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 12),),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection.", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 12),),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
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
                                                  await getEngineering.acceptRepairment(AcceptRepairmentRequest(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].id, "rejected"));
                                                  if(getEngineering.status=="OK"){
                                                    CustomToastNotification(context, Icon(Icons.check_circle_outline_rounded, color: Colors.green,), "Successfully updated", cTheme.primaryColorLight, cTheme.primaryColorDark);
                                                  }else{
                                                    CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), "An error occured", cTheme.scaffoldBackgroundColor, cTheme.primaryColorDark);
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.horizontal(
                                                      left: Radius.circular(10),
                                                    ),
                                                    color: Colors.red,
                                                  ),
                                                  child: Center(child: Text("Reject")),
                                                ),
                                              ),
                                            ),
                                            getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="approved"?SizedBox():Expanded(
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
                                                  await getEngineering.acceptRepairment(AcceptRepairmentRequest(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].id, "approved"));
                                                  if(getEngineering.status=="OK"){
                                                    CustomToastNotification(context, Icon(Icons.check_circle_outline_rounded, color: Colors.green,), "Successfully updated", cTheme.primaryColorLight, cTheme.primaryColorDark);
                                                  }else{
                                                    CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), "An error occured", cTheme.scaffoldBackgroundColor, cTheme.primaryColorDark);
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.horizontal(
                                                      right: Radius.circular(10),
                                                    ),
                                                    color: Colors.blue,
                                                  ),
                                                  child: Center(child: Text("Approve")),
                                                ),
                                              ),
                                            ),
                                            getEngineering.repairHistoryResponse?.historyOfRepairs?[index].status=="pending"?SizedBox():Expanded(
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
                                                  await getEngineering.acceptRepairment(AcceptRepairmentRequest(getEngineering.repairHistoryResponse?.historyOfRepairs?[index].id, "completed"));
                                                  if(getEngineering.status=="OK"){
                                                    CustomToastNotification(context, Icon(Icons.check_circle_outline_rounded, color: Colors.green,), "Successfully updated", cTheme.primaryColorLight, cTheme.primaryColorDark);
                                                  }else{
                                                    CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), "An error occured", cTheme.scaffoldBackgroundColor, cTheme.primaryColorDark);
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.horizontal(
                                                      right: Radius.circular(10),
                                                    ),
                                                    color: Colors.green,
                                                  ),
                                                  child: Center(child: Text("Complete")),
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
