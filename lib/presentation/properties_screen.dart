import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:graduation_project/constants/loading_indicator.dart';
import 'package:graduation_project/controllers/get_user_properties.dart';
import 'package:provider/provider.dart';
import 'package:typethis/typethis.dart';

import '../constants/custom_appbar.dart';
import '../constants/main_btn.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class PropertiesScreen extends StatefulWidget {
  const PropertiesScreen({super.key});

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return   Consumer2<LanguageChanger, GetUserProperties>(
        builder: (_, languageChanger, getUserProperties, __) {
          lChanger= languageChanger.data;
          bool isHouse=(getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses!.isNotEmpty as bool)?true:false;
          return Directionality(
            textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              backgroundColor: cTheme.scaffoldBackgroundColor,
              appBar: CustomAppBar(cTheme.scaffoldBackgroundColor, lChanger[18]["title"], cTheme.primaryColorDark, context),
              body: SafeArea(
                child: (getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses!.isEmpty as bool) && (getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.apartments!.isEmpty as bool)?Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.hourglass_empty_rounded, color: cTheme.primaryColorDark, size: 45,),
                      SizedBox(height: 10,),
                      Text("Empty", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 12),),
                    ],
                  ),
                ):ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TypeThis(
                            string: lChanger[18]["subtitle"],
                            style: TextStyle(color: cTheme.primaryColorDark, fontSize: 20),
                            // richTextMatchers: const [
                            //   TypeThisMatcher(
                            //     'Properties',
                            //     style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ],
                            showBlinkingCursor: false,
                            speed: 80,
                          ),
                          // Text(lChanger[9]["subtitle"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 20),),
                          // Text("John?", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 20, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: wid>600?wid*0.25:0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                if((getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses!.isNotEmpty as bool)){
                                  isHouse=true;
                                }
                                print(isHouse);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(lChanger[18]["ph1"], style: TextStyle(color: cTheme.primaryColorDark.withOpacity(0.6), fontSize: 12),),
                                Text("${(getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses!.length as int)+1}", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 12),),
                                SizedBox(width: 5,),
                                isHouse?Icon(Icons.check_rounded, color: cTheme.primaryColorDark, size: 10,):SizedBox(),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                if((getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.apartments!.isNotEmpty as bool)){
                                  isHouse=true;
                                }
                                print(isHouse);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(lChanger[18]["ph2"], style: TextStyle(color: cTheme.primaryColorDark.withOpacity(0.6), fontSize: 12),),
                                Text("${(getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.apartments?.length as int)+1}", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 12),),
                                SizedBox(width: 5,),
                                isHouse?SizedBox():Icon(Icons.check_rounded, color: cTheme.primaryColorDark, size: 10,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flex(
                      direction: wid>600?Axis.vertical:Axis.vertical,
                      children: List.generate(isHouse?(getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses!.length as int)+1:(getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.apartments!.length as int)+1, (index){
                        return Container(
                          width: wid>600?wid/2:wid,
                          margin: wid>600?EdgeInsets.only(top: 10, bottom: 50):EdgeInsets.all(10),
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                            color: cTheme.primaryColorLight,
                            borderRadius: BorderRadius.all(Radius.circular(35)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: wid,
                                height: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(isHouse?"images/house_img.jpg":"images/building_img.jpg"),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black38,
                                      BlendMode.darken,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                ),
                                child: Center(
                                    child: Text(isHouse?lChanger[18]["type2"]:lChanger[18]["type1"], style: TextStyle(color: Colors.white, fontSize: 24),),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Text(textAlign: TextAlign.center, "Reloaded 1 of 1971 libraries in 1,131ms (compile: 147 ms, reload: 424 ms, reassemble: 348 ms)."),
                              // ),
                              // Divider(
                              //   height: 10,
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                                    // textBaseline: TextBaseline.ideographic,
                                    children: [
                                      Icon(Icons.location_on_rounded, color: cTheme.primaryColor, size: 25,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      // Text("Location: ", style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark.withOpacity(0.6)),),
                                      Text(isHouse?"${getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse!.houses?[index].name}":"${getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse!.apartments?[index].name}", style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark),),
                                    ],
                                  ),
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                                    // textBaseline: TextBaseline.ideographic,
                                    children: [
                                      Icon(Icons.electric_bolt_rounded, color: cTheme.primaryColor, size: 25,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      // Text("Location: ", style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark.withOpacity(0.6)),),
                                      Text(isHouse?"${getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse!.houses?[index].electricityUnit}":"${getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse!.apartments?[index].electricityUnit}", style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark),),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ).animate().slideY(begin: 1, curve: Curves.easeInOutQuad, duration: 1.5.seconds);
                      }),
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
