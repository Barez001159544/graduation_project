
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:graduation_project/controllers/get_repairment.dart";
import "package:graduation_project/models/repair_request.dart";
import "package:graduation_project/presentation/payment_screen.dart";
import "package:provider/provider.dart";

import "../constants/confirmation_custom_alert_dialog.dart";
import "../constants/custom_appbar.dart";
import "../constants/custom_dropdown_menu.dart";
import "../constants/custom_switch_notification.dart";
import "../constants/custom_textfields.dart";
import "../constants/custom_toast_notification.dart";
import "../constants/loading_indicator.dart";
import "../constants/main_btn.dart";
import "../controllers/language_changer.dart";
import "../controllers/theme_changer.dart";
import "../custom theme data/themes.dart";
import "home_screen.dart";
import "login_screen.dart";

class RepairScreen extends StatefulWidget {
  const RepairScreen({super.key});

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

List items=[
  "TV",
  "Sofa",
  "Coffee Table",
  "Bed Frame",
  "Mattress",
  "Dining Table",
  "Chairs",
  "Desk",
  "Bookshelf",
  "Curtains",
  "Rugs",
  "Lamps",
  "Mirrors",
  "Throw Pillows",
  "Wall Art",
  "Plant Pots",
  "Kitchen Appliances"
];


class _RepairScreenState extends State<RepairScreen> {
  List indexes=[];
  TextEditingController textEditingController= TextEditingController();
  String? selected;
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
              backgroundColor: cTheme.scaffoldBackgroundColor,
              appBar: CustomAppBar(cTheme.scaffoldBackgroundColor, lChanger[15]["title"], cTheme.primaryColorDark, context),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: languageChanger.selectedLanguage=="ENG"?20:0, right: languageChanger.selectedLanguage=="ENG"?0:20),
                            child: Align(
                              alignment: languageChanger.selectedLanguage=="ENG"?Alignment.centerLeft:Alignment.centerRight,
                              child: Text(lChanger[15]["subtitle"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 20),),),),
                          SizedBox(
                            height: 20,
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                            padding: EdgeInsets.all(10),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: wid>800?4:(wid>500?3:2), mainAxisSpacing: 10, crossAxisSpacing: 10,), itemCount: items.length, itemBuilder: (BuildContext contex, index){
                            return Container(
                              width: wid/3,
                              height: 200,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: indexes.contains(index)?cTheme.primaryColor:cTheme.primaryColorLight,
                                borderRadius: BorderRadius.all(Radius.circular(35),),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.tv_rounded, color: cTheme.primaryColorDark, size: 60,),
                                      CustomSwitchBtn(indexes.contains(index), cTheme.scaffoldBackgroundColor, (val) {
                                        setState(() {
                                          indexes.clear();
                                          val?indexes.add(index):indexes.remove(index);
                                          print(index);
                                        });
                                      })
                                      // FToggleButton(
                                      //   isEnable: false,
                                      //   onChangeStatus: (bool val) {
                                      //     setState(() {
                                      //       print(val);
                                      //       val?indexes.add(index):indexes.remove(index);
                                      //     });
                                      //   },
                                      //   bgCircleEnable: Colors.white,
                                      //   bgCircleDisable: Color(0xff5CD254),
                                      //   bgDisable: tChanger.isDark?cTheme.backgroundColor:Color(0xffCBCBCB),
                                      //   borderColorEnable: Colors.transparent,
                                      //   borderColorDisEnable: Colors.transparent,
                                      // ),
                                    ],
                                  ),
                                  Text(items[index], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20, right: 20, left: 20),//:EdgeInsets.only(),
                      child: Column(
                        children: [
                          CustomTextFields(textEditingController, "description", cTheme.primaryColorDark, cTheme.primaryColorLight, cTheme.primaryColorLight, 15, 1, false),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomDropDownMenu("Property", wid>500?wid*0.35-80:wid/2-25, wid>500?62.0:72.0, wid, cTheme.primaryColorLight, cTheme.primaryColorDark, ["KRD", "ARB", "ENG"], selected, (val) {
                                print(val);
                                setState(() {
                                  selected=val;
                                });
                                // lChanger.changeLanguage(val);
                              }),
                              SizedBox(width: 10,),
                              MainBtn(wid>500?wid*0.35-80:wid/2-25, wid>500?62.0:72.0, cTheme.primaryColor, lChanger[15]["btn"], () {
                                if(indexes.isNotEmpty && selected!=null) {
                                  print(indexes[0]);
                                  print(selected);

                                  ConfirmationCustomAlertDialog(
                                      cTheme.primaryColorLight,
                                      cTheme.primaryColorDark,
                                      lChanger[15]["popTitle"],
                                      lChanger[15]["popSubtitle"],
                                      lChanger[15]["agreeBtn"],
                                      lChanger[15]["declineBtn"],
                                      context, () async{
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
                                        print(textEditingController.text);
                                        print(selected);
                                        print(items[indexes[0]]);
                                        // await getRepairment.newRepair(RepairRequest(items[indexes[0]], "Electronic Devices", "This is the descirpion for fixing electronic devices reparirment request.", "houses", 3));
                                    if(getRepairment.status=="A+"){
                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                                        return HomeScreen();
                                      }), (route) => false);
                                      CustomToastNotification(context, Icon(Icons.check_circle_outline_rounded, color: Colors.green,), "Successfully Sent", cTheme.primaryColorLight, cTheme.primaryColorDark);
                                    }else{
                                      CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), "An error occurred", cTheme.primaryColorLight, cTheme.primaryColorDark);
                                      Navigator.of(context).pop();
                                    }
                                  }, () {},
                                      cTheme.primaryColor);
                                }else{
                                  CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), "Choose a property and an item please", cTheme.primaryColorLight, cTheme.primaryColorDark);
                                }
                                }),
                            ],
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

Widget reMenu(double wid, double height, reMenuColor, Color tColor, List<String>? items, String? value, void onChange(val),){
  return Container(
    width: wid,
    height: height,
    padding: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      color: reMenuColor,
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton(
        padding: EdgeInsets.only(left: 10),
        dropdownColor: reMenuColor,
        isExpanded: true,
        disabledHint: Text("Code", style: TextStyle(fontFamily: "NotoSans"),),
        hint: Text("Code", style: TextStyle(fontFamily: "NotoSans"),),
        value: value != null ? value : null,
        style: TextStyle(color: Colors.black),
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          size: 30,
          color: tColor,
        ),
        items: List<String>.from(items as Iterable)
            .map((String itemss) {
          return DropdownMenuItem(
            value: itemss,
            child: Text(
              itemss,
              style: TextStyle(fontFamily: "NotoSans", color: tColor),
            ),
          );
        }).toList(),
        onChanged: (val) {
          onChange(val);
        },
      ),
    ),
  );
}