import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/controllers/get_protests.dart';
import 'package:graduation_project/presentation_depricated/maintenance_screen.dart';
import 'package:graduation_project/presentation/protest_screen.dart';
import 'package:graduation_project/presentation/repair_screen.dart';
import 'package:graduation_project/presentation/taxi_home.dart';
import 'package:graduation_project/presentation/taxi_services.dart';
import 'package:provider/provider.dart';
import 'package:typethis/typethis.dart';
import '../constants/custom_appbar.dart';
import '../constants/loading_indicator.dart';
import '../constants/main_btn.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

List services=[
  "Electricity",
  "Repair & Maintenance",
  // "Support Center",
  // "Maintenance",
  "Protest",
];
List servicesIcons=[
  Icons.electric_bolt_rounded,
  Icons.handyman_rounded,
  // Icons.chat_rounded,
  // Icons.cleaning_services_rounded,
  Icons.note_alt_outlined,
];
// bool isDark=true;
// ThemeData cTheme = isDark?lightTheme:darkTheme;

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return   Consumer2<LanguageChanger, GetProtests>(
            builder: (_, languageChanger, getAllProtests, __) {
              lChanger= languageChanger.data;
              return Directionality(
                textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
                child: Scaffold(
                  backgroundColor: cTheme.scaffoldBackgroundColor,
                  appBar: CustomAppBar(cTheme.scaffoldBackgroundColor, lChanger[9]["title"], cTheme.primaryColorDark, context),
                body: SafeArea(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 70),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            TypeThis(
                            string: lChanger[9]["subtitle"] + " John?",
                            style: TextStyle(color: cTheme.primaryColorDark, fontSize: 20),
                            richTextMatchers: const [
                              TypeThisMatcher(
                                'John',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                              showBlinkingCursor: false,
                              speed: 80,
                          ),
                              // Text(lChanger[9]["subtitle"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 20),),
                              // Text("John?", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 20, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        Flex(
                          direction: wid>600?Axis.vertical:Axis.vertical,
                          children: List.generate(services.length, (index){
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(servicesIcons[index], color: cTheme.primaryColor, size: 70,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(index==0?lChanger[9]["service1"]:(index==1?lChanger[9]["service2"]:lChanger[9]["service3"]), style: TextStyle(fontSize: 24, color: cTheme.primaryColorDark),),
                                          Text(index==0?lChanger[9]["type1"]:(index==1?lChanger[9]["type2"]:lChanger[9]["type3"]), style: TextStyle(fontSize: 12, color: Colors.grey),),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(textAlign: TextAlign.center, index==0?lChanger[9]["par1"]:(index==1?lChanger[9]["par2"]:lChanger[9]["par3"]), style: TextStyle(fontSize: 12, color: cTheme.primaryColorDark),),
                                  ),
                                  Divider(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        // crossAxisAlignment: CrossAxisAlignment.baseline,
                                        // textBaseline: TextBaseline.ideographic,
                                        children: [
                                          Icon(Icons.star_rate_rounded, color: Colors.amber, size: 50,),
                                          Text("x4", style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark),),
                                        ],
                                      ),
                                      SizedBox(width: 20,),
                                      Expanded(child: MainBtn(wid, wid>600?62.0:72.0, cTheme.primaryColor, "Proceed", () async {
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
                                        Navigator.of(context).pop();
                                        if(index==1){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                            return RepairScreen();
                                          }));
                                        }else{
                                          await getAllProtests.getAllProtests();
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                            return ProtestScreen();
                                          }));
                                        }

                                      })),
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
