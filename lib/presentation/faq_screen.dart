import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme:lightTheme;
    List lChanger;
    return Consumer<LanguageChanger>(
        builder: (_, languageChanger, __) {
          lChanger= languageChanger.data;
          return Directionality(
          textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
          child: Scaffold(
            backgroundColor: cTheme.scaffoldBackgroundColor,
            body: SafeArea(
              child: Row(
                children: [
                  wid>600?Expanded(
                    flex: 1,
                    child: Container(
                        // color: Colors.blue,
                        padding: EdgeInsets.all(10),
                        // height: wid>600?hei:100,
                        // width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("FAQ", style: TextStyle(color: cTheme.primaryColor, fontSize: 90),),
                                Text("More than 100 most asked questions", style: TextStyle(color: cTheme.primaryColorDark),),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            ElevatedButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: cTheme.primaryColorLight,
                                foregroundColor: cTheme.primaryColorLight,
                                elevation: 0,
                              ),
                              child: Icon(Icons.arrow_back_rounded, color: cTheme.primaryColorDark,),
                            ),
                            // Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_rounded, color: cTheme.primaryColorDark,))),
                          ],
                        )
                    ),
                  ):SizedBox(),
                  Expanded(
                    flex: 2,
                    child: Container(
                      // color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      // height: hei,
                      // width: wid>600?wid-100:wid,
                      child: ListView(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              wid>600?SizedBox():Container(
                                // color: Colors.blue,
                                  height: 280,
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: cTheme.primaryColorLight,
                                          foregroundColor: cTheme.primaryColorLight,
                                          elevation: 0,
                                        ),
                                        child: Icon(Icons.arrow_back_rounded, color: cTheme.primaryColorDark,),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("FAQ", style: TextStyle(color: cTheme.primaryColor, fontSize: 90),),
                                      Text("More than 100 most asked questions", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 14),),
                                    ],
                                  )
                              ),
                              Container(
                                // width: wid>600?wid*0.7:wid,
                                // color: Colors.red,
                                child: Column(
                                  children: List.generate(100, (index){
                                    return Container(
                                      margin: EdgeInsets.only(top: 10, bottom: index==99?10:0),
                                      decoration: BoxDecoration(
                                        // color: cTheme.primaryColorLight,
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Theme(
                                        data: cTheme.copyWith(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                        ),
                                        child: ExpansionTile(
                                          shape: Border(),
                                          childrenPadding: EdgeInsets.all(10),
                                          iconColor: cTheme.primaryColor,
                                          // backgroundColor: Colors.blue,
                                          title: Text("title $index", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                          children: [
                                            Text("Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection.", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 12),),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
