import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class FaqStructure{
  String faqq;
  String faqa;

  FaqStructure(this.faqq, this.faqa);
}

List<FaqStructure> faqs=[
  FaqStructure("How to set up another account for one of my family members?", "Answer 0 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("What if I had a complaint, how to inform the residential management?", "Answer 1 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("Question 2", "Answer 2 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("Question 3", "Answer 3 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("Question 4", "Answer 4 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("Question 5", "Answer 5 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("Question 6", "Answer 6 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("Question 7", "Answer 7 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("Question 8", "Answer 8 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("Question 9", "Answer 9 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("Question 10", "Answer 10 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("Question 11", "Answer 11 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("Question 12", "Answer 12 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("Question 13", "Answer 13 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("Question 14", "Answer 14 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
  FaqStructure("Question 15", "Answer 15 Performing hot restart...Syncing files to device Windows...Restarted application in 1,533ms.flutter: trueflutter: ClientException with SocketException: The remote computer refused the network connection."),
];

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
                                Text(lChanger[4]["subtitle"], style: TextStyle(color: cTheme.primaryColorDark),),
                                RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: lChanger[4]["message1"],
                                          style: TextStyle(color: cTheme.primaryColorDark, fontFamily: "NotoSans"),
                                        ),
                                        TextSpan(
                                          text: lChanger[4]["message2"],
                                          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontFamily: "NotoSans"),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => launchUrlString('https://www.example.com'),
                                        ),
                                        TextSpan(
                                          text: lChanger[4]["message3"],
                                          style: TextStyle(color: cTheme.primaryColorDark, fontFamily: "NotoSans"),
                                        ),
                                      ],
                                    ),
                                ),
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
                                      Text(lChanger[4]["subtitle"], style: TextStyle(color: cTheme.primaryColorDark),),
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: lChanger[4]["message1"],
                                              style: TextStyle(color: cTheme.primaryColorDark, fontFamily: "NotoSans"),
                                            ),
                                            TextSpan(
                                              text: lChanger[4]["message2"],
                                              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontFamily: "NotoSans"),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () => launchUrlString('https://www.example.com'),
                                            ),
                                            TextSpan(
                                              text: lChanger[4]["message3"],
                                              style: TextStyle(color: cTheme.primaryColorDark, fontFamily: "NotoSans"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Container(
                                // width: wid>600?wid*0.7:wid,
                                // color: Colors.red,
                                child: Column(
                                  children: List.generate(faqs.length, (index){
                                    return Container(
                                      margin: EdgeInsets.only(top: 10, bottom: index==faqs.length-1?10:0),
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
                                          iconColor: cTheme.primaryColorDark,
                                          // backgroundColor: Colors.blue,
                                          title: Text(faqs[index].faqq, style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                          children: [
                                            Text(faqs[index].faqa, style: TextStyle(color: cTheme.primaryColorDark, fontSize: 12),),
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
