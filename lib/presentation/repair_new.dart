
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:graduation_project/controllers/get_repairment.dart";
import "package:graduation_project/models/repair_request.dart";
import "package:graduation_project/presentation/payment_screen.dart";
import "package:graduation_project/presentation/repair_history.dart";
import "package:provider/provider.dart";

import "../constants/confirmation_custom_alert_dialog.dart";
import "../constants/custom_appbar.dart";
import "../constants/custom_dropdown_menu.dart";
import "../constants/custom_switch_notification.dart";
import "../constants/custom_textfields.dart";
import "../constants/custom_toast_notification.dart";
import "../constants/loading_indicator.dart";
import "../constants/main_btn.dart";
import "../controllers/get_user_properties.dart";
import "../controllers/language_changer.dart";
import "../controllers/theme_changer.dart";
import "../custom theme data/themes.dart";
import "../models/fully_aparments_reponse.dart";
import "../models/fully_houses_response.dart";
import "home_screen.dart";
import "login_screen.dart";

class NewRepair extends StatefulWidget {
  const NewRepair({super.key});

  @override
  State<NewRepair> createState() => _NewRepairState();
}

List items=[
  //Plumbing
  // "pipes",
  // "faucets",
  // "toilets",
  // "sinks",
  // "showers",
  // "water heaters",
  // "clogs",
  //Electrical Systems
  // "outlets",
  // "switches",
  // "circuit breakers",
  // "light fixtures",
  //HVAC
  // "air conditioners",
  //Roofing
  // "Roof leaks",
  // "damaged shingles",
  // "gutter problems",
  //Windows and doors
  // "broken glass",
  // "malfunctioning locks",
  // "hinges",
  // "weatherstripping",
  //Flooring
  // "hardwood",
  // "carpeting",
  // "water damage",
  //Walls and ceiling
  // "cracks",
  // "holes",
  // "water damage",
  // "peeling paint",
  //Exterior
  // "paint",
  // "decks",

  //Appliances
  "TV",
  "laundry machines",
  "water heaters",
  "Refrigerator",
  "Dishwasher",
  "Air Conditioner",
  "Heater",
  //
  "Table",
  "Bed Frame",
  "Chairs",
  //House Malfunctions
  "Plumbing",
  "Electrical Systems",
  "Windows and doors",
  "House Structure",
  "Others",
  //Others
  //Write in description
];

List icons=[
  Icons.tv_rounded,
  Icons.local_laundry_service_rounded,
  Icons.water_rounded,
  Icons.kitchen_rounded,
  Icons.restaurant_menu_rounded,
  Icons.ac_unit_rounded,
  Icons.wb_sunny_rounded,
  //
  Icons.table_bar_rounded,
  Icons.bed_rounded,
  Icons.chair_rounded,
  //HouseMalfunctions
  Icons.plumbing_rounded,
  Icons.electrical_services_rounded,
  Icons.door_back_door_rounded,
  Icons.house_rounded,
  Icons.more_horiz_rounded,
];


class _NewRepairState extends State<NewRepair> {
  List indexes=[];
  TextEditingController textEditingController= TextEditingController();
  String? selected;

  String? selectedProperty;
  String? selectedType;
  int? selectedId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetUserProperties>(context, listen: false).getUserProperties();
      Provider.of<GetUserProperties>(context, listen: false).getAllHouses();
      Provider.of<GetUserProperties>(context, listen: false).getAllApartments();
    });
  }

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer4<ThemeChanger, LanguageChanger, GetRepairment, GetUserProperties>(
          builder: (_, tChanger, languageChanger, getRepairment, getUserProperties, child) {
            lChanger=languageChanger.data;
          return Directionality(
            textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              backgroundColor: cTheme.scaffoldBackgroundColor,
              appBar: CustomAppBar(cTheme.scaffoldBackgroundColor, lChanger[9]["title2"], cTheme.primaryColorDark, context),
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
                              child: Text(lChanger[9]["subtitle"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 20),),),),
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
                                      Icon(icons[index], color: cTheme.primaryColorDark, size: 42,),
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
                          CustomTextFields(textEditingController, lChanger[9]["description"], cTheme.primaryColorDark, cTheme.primaryColorLight, cTheme.primaryColorLight, 15, 1, false),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // CustomDropDownMenu("Property", wid>500?wid*0.35-80:wid/2-25, wid>500?62.0:72.0, wid, cTheme.primaryColorLight, cTheme.primaryColorDark, ["KRD", "ARB", "ENG"], selected, (val) {
                              //   print(val);
                              //   setState(() {
                              //     selected=val;
                              //   });
                              //   // lChanger.changeLanguage(val);
                              // }),
                              // -----------------------------
                              Theme(
                                data: cTheme.copyWith(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                ),
                                child: getUserProperties.isLoading?Center(
                                  child: LoadingIndicator(cTheme.primaryColorLight),
                                ):SpecialCustomDropDownMenu(lChanger[9]["property"], wid>500?wid*0.35-80:wid/2-25, wid>500?62.0:72.0, wid, cTheme.primaryColorLight, cTheme.primaryColorDark, getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses, getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.apartments, selectedProperty, (val) {
                                  setState(() {
                                    selectedProperty=val;
                                  });
                                  selectedType="${val}".split("-")[0].toLowerCase();
                                  if("$val".split("-")[0]=="Houses"){
                                    EachHouseResponse? obj = getUserProperties.fullyHousesResponse?.eachHouseResponse?.firstWhere((obj) => obj?.name == "${val}".split("-")[1],);
                                    selectedId=obj?.id;
                                    print(">>>>>>>>>${selectedId}");
                                  }else{
                                    EachApartmentsResponse? obj = getUserProperties.fullyApartmentsResponse?.eachApartmentsResponse?.firstWhere((obj) => obj?.name == "${val}".split("-")[1],);
                                    selectedId=obj?.id;
                                    print(">>>>>>>>>${selectedId}");
                                  }
                                }),
                              ),
                              // -----------------------------
                              SizedBox(width: 10,),
                              MainBtn(wid>500?wid*0.35-80:wid/2-25, wid>500?62.0:72.0, cTheme.primaryColor, lChanger[9]["btn"], () {
                                if(indexes.isNotEmpty && selectedProperty!=null && textEditingController.text!="") {
                                  print(indexes[0]);
                                  print(selected);

                                  ConfirmationCustomAlertDialog(
                                      cTheme.primaryColorLight,
                                      cTheme.primaryColorDark,
                                      lChanger[9]["popTitle"],
                                      lChanger[9]["popSubtitle"],
                                      lChanger[9]["agreeBtn"],
                                      lChanger[9]["declineBtn"],
                                      context, () async{
                                    showDialog(
                                        context: context,
                                        // barrierColor: cTheme.backgroundColor,
                                        builder: (BuildContext ctx){
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
                                        await getRepairment.newRepair(RepairRequest("television broken", "electronic components", "${textEditingController.text}", "$selectedType", selectedId));
                                        Navigator.of(context).pop();
                                        if(getRepairment.status=="OK"){
                                      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                                      //   return HomeScreen();
                                      // }), (route) => false);
                                          getRepairment.getAllRepair();
                                      CustomToastNotification(context, Icon(Icons.check_circle_outline_rounded, color: Colors.green,), lChanger[9]["notification1"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                      Navigator.of(context).pop();
                                    }else{
                                      CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[9]["notification2"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                    }
                                  }, () {},
                                      cTheme.primaryColor);
                                }else{
                                  CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[9]["notification3"], cTheme.primaryColorLight, cTheme.primaryColorDark);
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