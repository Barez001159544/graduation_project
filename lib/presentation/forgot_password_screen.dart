import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/presentation/forgot_password_reset.dart';
import 'package:provider/provider.dart';

import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

// bool isDark=true;
// ThemeData cTheme = isDark?lightTheme:darkTheme;
PageController pageController= PageController();
String? chosenCode=null;
List<String> countryCodes = [
  ' +964',
  ' +90',
  ' +98',
  ' +20',
  ' +965',
];
List countryLangCodes=[
  "iq",
  "tr",
  "ir",
  "eg",
  "kw",
];

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  List<CoolDropdownItem<String>> countryCodesDropdownItems = [];
  final countryCodesDropdownController = DropdownController();
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < countryCodes.length; i++) {
      countryCodesDropdownItems.add(
        CoolDropdownItem<String>(
            label: '${countryCodes[i]}',
            icon: Container(
              height: 25,
              width: 25,
              child: CountryFlag.fromCountryCode(
                countryLangCodes[i],
                width: 20,
                height: 20,
              ),
            ),
            value: '${countryCodes[i]}'),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer<LanguageChanger>(
          builder: (_, languageChanger, __) {
            lChanger= languageChanger.data;
            List views=[
              Container(
                margin: EdgeInsets.symmetric(horizontal: wid<500?0:wid-(wid-300)),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: wid,
                          child: Text(lChanger[3]["title"], style: TextStyle(fontFamily: "NotoSans", fontSize: 28, color: cTheme.primaryColorDark),),
                        ),
                        Container(
                          width: wid,
                          child: Text(lChanger[3]["subtitle1"], style: TextStyle(fontFamily: "NotoSans", color: Colors.grey.shade700),),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // customDropDownMenu(120.0, 30.0, ["IRAQ +964", "USA +006"], chosenCode, (val) {
                            //   setState(() {
                            //     chosenCode=val;
                            //   });
                            // }),
                            // CoolDropdown(dropdownList: List<CoolDropdownItem>["IRAQ +964", "USA +006"], controller: DropdownController(), onChange: (dynamic val){}),
                            CoolDropdown<String>(
                              controller: countryCodesDropdownController,
                              dropdownList: countryCodesDropdownItems,
                              defaultItem: countryCodesDropdownItems[0],
                              onChange: (value) async {
                                if (countryCodesDropdownController.isError) {
                                  await countryCodesDropdownController.resetError();
                                }
                                // fruitDropdownController.close();
                              },
                              onOpen: (value) {},
                              resultOptions: ResultOptions(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 70,
                                icon: SizedBox(
                                  width: 10,
                                  height: 10,
                                  child: CustomPaint(
                                    painter: DropdownArrowPainter(),
                                  ),
                                ),
                                render: ResultRender.icon,
                                placeholder: 'Select Country Code',
                                isMarquee: true,
                              ),
                              dropdownOptions: DropdownOptions(
                                  top: 20,
                                  height: hei/2-50,
                                  width: 200,
                                  gap: DropdownGap.all(5),
                                  borderSide: BorderSide(width: 1, color: Colors.green),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  align: languageChanger.selectedLanguage=="ENG"?DropdownAlign.left:DropdownAlign.right,
                                  animationType: DropdownAnimationType.size),
                              dropdownTriangleOptions: DropdownTriangleOptions(
                                width: 20,
                                height: 10,
                                align: languageChanger.selectedLanguage=="ENG"?DropdownTriangleAlign.left:DropdownTriangleAlign.right,
                                borderRadius: 3,
                                left: languageChanger.selectedLanguage=="ENG"?20:0,
                              ),
                              dropdownItemOptions: DropdownItemOptions(
                                isMarquee: true,
                                mainAxisAlignment: languageChanger.selectedLanguage=="ENG"?MainAxisAlignment.start:MainAxisAlignment.end,
                                render: DropdownItemRender.reverse,
                                height: 50,
                                alignment: languageChanger.selectedLanguage=="ENG"?Alignment.centerLeft:Alignment.centerRight,
                                selectedBoxDecoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.3),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                selectedTextStyle: TextStyle(
                                    color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: loginFields(TextEditingController(), false, "### ####", cTheme.primaryColorDark, cTheme.primaryColorDark),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        mainBtn(wid>500?wid*0.35-80:wid-40, wid>500?62.0:72.0, cTheme.primaryColor, lChanger[3]["btn"], () {
                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                            return ForgotPasswordReset();
                          }));
                        }),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        pageController.page!=1?pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        ):print("END");
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(lChanger[3]["tryg"], style: TextStyle(color: cTheme.primaryColorDark),),
                            Icon(Icons.arrow_drop_down, color: cTheme.primaryColorDark,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      pageController.page!=0?pageController.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ):print("END");
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      color: Colors.transparent,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(lChanger[3]["tryp"], style: TextStyle(color: cTheme.primaryColorDark),),
                          Icon(Icons.arrow_drop_up, color: cTheme.primaryColorDark,),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: wid,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                        color: cTheme.primaryColorLight,
                      ),
                      margin: EdgeInsets.only(top: 100),
                      child: Container(
                        width: wid<500?wid:500,
                        padding: EdgeInsets.symmetric(horizontal: wid<500?20:wid-(wid-300)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: wid,
                              child: Text(lChanger[3]["title"], style: TextStyle(fontFamily: "NotoSans", fontSize: 28, color: cTheme.primaryColorDark),),
                            ),
                            Container(
                              width: wid,
                              child: Text(lChanger[3]["subtitle2"], style: TextStyle(fontFamily: "NotoSans", color: Colors.grey.shade700),),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Flexible(
                              child: loginFields(TextEditingController(), false, lChanger[3]["ph"], cTheme.primaryColorDark, cTheme.primaryColorDark),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            mainBtn(wid>500?wid*0.35-80:wid-40, wid>500?62.0:72.0, cTheme.primaryColor, lChanger[3]["btn"], () {
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                                return ForgotPasswordReset();
                              }));
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ];
            return Directionality(
              textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
                appBar: customAppbar(cTheme.backgroundColor, "", cTheme.primaryColorDark, context),
                backgroundColor: cTheme.backgroundColor,
                body: SafeArea(
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: pageController,
                      itemCount: 2,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index){
                        return views[index];
                      }),
                ),
              ),
            );
        }
      );
  }
}

