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
// 11
List<FaqStructure> faqs=[
  FaqStructure("How to set up another account for one of my family members?", "If you're looking to establish an account or set up one for a family member, simply drop by your residential management office. Our dedicated staff will guide you through the process, ensuring everything is set up smoothly and efficiently. From creating new accounts to managing existing ones."),
  FaqStructure("How to recover the password of my current account?", "If you've forgotten your password, fear not! Simply navigate to the settings if you're logged into your account to recover it. Alternatively, swing by the residential management office, where our team can swiftly assist you in regaining access to your account within minutes."),
  FaqStructure("What are the services that are available through this app?", "Our residential management app boasts a plethora of features designed to streamline property management. From requesting repairs and protests to providing insights into your property portfolio and payment history, our app covers it all. Additionally, enjoy the convenience of digital payments seamlessly integrated with FIB, offering a comprehensive solution for all your property management needs."),
  FaqStructure("What if I had a complaint, how to inform the residential management?", "Our residential management app simplifies communication with our management staff by offering a dedicated 'Protest' section. Here, you can detail your concerns comprehensively, and our team will promptly address them."),
  FaqStructure("I need repairment, how to request one?", "Our residential management app streamlines the process of requesting assistance from our management staff. With our dedicated 'Repair and Maintenance' section, simply select the item requiring attention, and our staff will promptly address your needs."),
  FaqStructure("How to pay my monthly fee with this app?", "Accessing your monthly payment QR code is effortless with our app's integrated FIB QR code generator. Located conveniently at the top of the home screen, simply select your property from current month to generate the code instantly. Payment becomes a breeze as you can either scan the QR code directly or manually input the readable code."),
  FaqStructure("How to send money with my FIB account?", "To utilize this feature, ensure you have an active FIB account logged in. Once logged in, generate your unique payment QR code and readable code. From there, you have the option to scan the QR code directly from the FIB app or manually input the readable code. But don't forget to tap on DONE button once you pay."),
  FaqStructure("How to set up an FIB account?", "To create an FIB account, simply download it's mobile app and follow a few straightforward steps guided by the app's intuitive interface. Then you will have an account that just needs to be funded."),
  FaqStructure("Where can i find my payment history?", "From the home screen, you'll find a convenient button that directs you to the properties screen, where all the properties you own are displayed. Upon selecting a specific property, you'll gain access to its comprehensive payment history. Easily track and review all transactions associated with that property, ensuring transparency and peace of mind in your financial management."),
  FaqStructure("Who can see my repairment request?", "Your repairment requests are promptly dispatched to our dedicated engineering staff for immediate attention. Once received, they prioritize and address each request as swiftly as possible. Additionally, our management staff have visibility into these requests, enabling them to take appropriate actions if necessary."),
  FaqStructure("Who can see my protest request?", "Your compliance requests are securely accessible only to our management staff, ensuring confidentiality and swift action. They have the authority to review and take necessary actions promptly. "),
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
