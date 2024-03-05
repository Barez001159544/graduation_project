import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    return   Consumer<LanguageChanger>(
        builder: (_, languageChanger, __) {
          lChanger= languageChanger.data;
          return Directionality(
            textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              backgroundColor: cTheme.backgroundColor,
              appBar: CustomAppBar(cTheme.backgroundColor, lChanger[9]["title"], cTheme.primaryColorDark, context),
              body: SafeArea(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TypeThis(
                            string: "Your overall Properties",
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
                    Flex(
                      direction: wid>600?Axis.vertical:Axis.vertical,
                      children: List.generate(6, (index){
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
                                    image: AssetImage(index%2==0?"images/building_img.jpg":"images/house_img.jpg"),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black38,
                                      BlendMode.darken,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                ),
                                child: Center(
                                    child: Text(index%2==0?"Apartment":"House", style: TextStyle(color: Colors.white, fontSize: 24),),
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
                              Row(
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
                                      Text("R123", style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark),),
                                    ],
                                  ),
                                  SizedBox(width: 20,),
                                  // Expanded(child: MainBtn(wid, wid>600?62.0:72.0, cTheme.primaryColor, "Proceed", () {
                                  //   // Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  //   //   return index==1?RepairScreen():ProtestScreen();
                                  //   // }));
                                  // })),
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
