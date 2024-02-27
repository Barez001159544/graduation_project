import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";

import "../constants.dart";
import "../constants/custom_appbar.dart";
import "../controllers/language_changer.dart";
import "../controllers/theme_changer.dart";
import "../custom theme data/themes.dart";

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool showAll=false;
  List txts= List.generate(5, (index) => "Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development Lorem ipsum is simply a dummy text for your web design and mobile app development");
  List boolies= List.generate(5, (index) => false);
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer<LanguageChanger>(
          builder: (_, languageChanger, __) {
            lChanger= languageChanger.data;
          return Directionality(
            textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              backgroundColor: cTheme.backgroundColor,
              appBar: CustomAppBar(cTheme.backgroundColor, lChanger[13]["title"], cTheme.primaryColorDark, context),
              body: SafeArea(
                child: ListView.builder(
                  itemCount: 5,
                    itemBuilder: (context, index){
                  return ListTile(
                    title: Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: wid>600?CrossAxisAlignment.end:CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time_rounded, color: Colors.grey,),
                        SizedBox(
                          width: 2,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("12/28", style: TextStyle(fontSize: 8, color: Colors.grey),),
                            Text("03:29", style: TextStyle(fontSize: 8, color: Colors.grey),),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Flex(
                      direction: wid>600?Axis.horizontal:Axis.horizontal,
                      children: [
                        Flexible(
                          child: Container(
                            // height: wid>500?250:wid-40,
                            width: wid,
                            margin: wid>600?EdgeInsets.symmetric(horizontal: 80, vertical: 20):EdgeInsets.all(10),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: cTheme.primaryColorLight,
                              borderRadius: BorderRadius.all(Radius.circular(wid>600?70:50),),
                            ),
                            child: Flex(
                              direction: wid>600?Axis.horizontal:Axis.vertical,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                index!=1?Container(
                                  width: wid>600?300:wid,
                                  height: wid>600?300:wid-150,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    image: DecorationImage(
                                      image: AssetImage("images/city2.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(wid>600?50:35),),
                                  ),
                                ):SizedBox(),
                                index!=1?SizedBox(
                                  width: 10,
                                  height: 10,
                                ):SizedBox(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: wid>600?(index==1?wid-240:wid-610):wid-80,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "Title of the post", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16, fontWeight: FontWeight.bold),
                                              softWrap: false,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade, // new
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Text("Title of the post", overflow: TextOverflow.fade, style: TextStyle(color: cTheme.primaryColorDark, fontSize: wid>600?24:18, fontWeight: FontWeight.bold),),
                                    SizedBox(
                                      height: 5,
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          boolies[index]=!boolies[index];
                                        });
                                      },
                                      child: Container(
                                        width: wid>600?(index==1?wid-240:wid-610):wid-80,
                                        // height: wid>500?wid-200:50,
                                        // color: Colors.green,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                txts[index], style: TextStyle(color: cTheme.primaryColorDark, fontSize: wid>600?14:12,),
                                                softWrap: true,
                                                maxLines: wid>600?(boolies[index]?100:13):(boolies[index]?100:2),
                                                overflow: TextOverflow.ellipsis, // new
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Text("Lorem ipsum is simply a dummy text for yourweb design and mobile app development ", style: TextStyle(fontSize: 12),),
                                // SizedBox(
                                //   height: 15,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          );
        }
      );
  }
}
