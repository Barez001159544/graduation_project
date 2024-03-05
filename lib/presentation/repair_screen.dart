
import "package:flutter/material.dart";
import "package:graduation_project/presentation/payment_screen.dart";
import "package:provider/provider.dart";

import "../constants/confirmation_custom_alert_dialog.dart";
import "../constants/custom_appbar.dart";
import "../constants/custom_switch_notification.dart";
import "../constants/main_btn.dart";
import "../controllers/language_changer.dart";
import "../controllers/theme_changer.dart";
import "../custom theme data/themes.dart";
import "login_screen.dart";

class RepairScreen extends StatefulWidget {
  const RepairScreen({super.key});

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}


class _RepairScreenState extends State<RepairScreen> {
  List indexes=[];
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer2<ThemeChanger, LanguageChanger>(
          builder: (_, tChanger, languageChanger, child) {
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
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: or?5:(wid>500?4:2), mainAxisSpacing: 10, crossAxisSpacing: 10,), itemCount: 18, itemBuilder: (BuildContext contex, index){
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
                                      Icon(Icons.tv_rounded, color: cTheme.primaryColorDark, size: 70,),
                                      CustomSwitchBtn(indexes.contains(index), cTheme.scaffoldBackgroundColor, (val) {
                                        setState(() {
                                          val?indexes.add(index):indexes.remove(index);
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
                                  Text("TV", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: MainBtn(wid>500?wid*0.35-80:wid-40, wid>500?62.0:72.0, cTheme.primaryColor, lChanger[15]["btn"], () {
                          ConfirmationCustomAlertDialog(cTheme.primaryColorLight, cTheme.primaryColorDark, lChanger[15]["popTitle"], lChanger[15]["popSubtitle"], lChanger[15]["agreeBtn"], lChanger[15]["declineBtn"], context, (){}, (){}, cTheme.primaryColor);
                        }),
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