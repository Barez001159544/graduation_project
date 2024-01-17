import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../constants.dart";
import "../controllers/language_changer.dart";
import "../controllers/theme_changer.dart";
import "../custom theme data/themes.dart";

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger= Provider.of<LanguageChanger>(context, listen: false).data;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: cTheme,
      home: Scaffold(
        backgroundColor: cTheme.backgroundColor,
        appBar: customAppbar(cTheme.backgroundColor, "Community", cTheme.primaryColorDark, context),
        body: SafeArea(
          child: ListView.builder(
            itemCount: 5,
              itemBuilder: (context, index){
            return Container(
              height: wid>500?250:wid-40,
              width: wid,
              margin: wid>500?EdgeInsets.symmetric(horizontal: 80, vertical: 20):EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cTheme.primaryColorLight,
                borderRadius: BorderRadius.all(Radius.circular(wid>500?70:50),),
              ),
              child: Flex(
                direction: wid>500?Axis.horizontal:Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: wid>500?350:wid,
                    height: wid>500?wid-300:wid-180,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      image: DecorationImage(
                        image: AssetImage("images/city2.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(wid>500?50:35),),
                    ),
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  Container(
                    width: wid>500?wid-610:wid-80,
                    height: wid>500?wid-200:50,
                    // color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Lorem ipsum is simply a dummy text for your web design and mobile app development", style: TextStyle(color: cTheme.primaryColorDark, fontSize: wid>500?18:12,),
                            softWrap: false,
                            maxLines: wid>500?5:2,
                            overflow: TextOverflow.ellipsis, // new
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Text("Lorem ipsum is simply a dummy text for yourweb design and mobile app development ", style: TextStyle(fontSize: 12),),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: wid>500?CrossAxisAlignment.end:CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("12/28", style: TextStyle(fontSize: 8, color: Colors.grey),),
                          Text("03:29", style: TextStyle(fontSize: 8, color: Colors.grey),),
                        ],
                      ),
                      Icon(Icons.access_time_rounded, color: Colors.grey,),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
