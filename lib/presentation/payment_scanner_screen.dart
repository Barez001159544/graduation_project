import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class PaymentScannerScreen extends StatefulWidget {
  const PaymentScannerScreen({super.key});

  @override
  State<PaymentScannerScreen> createState() => _PaymentScannerScreenState();
}

// bool isDark=true;
// ThemeData cTheme = isDark?lightTheme:darkTheme;

class _PaymentScannerScreenState extends State<PaymentScannerScreen> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return MaterialApp(
      theme: cTheme,
      debugShowCheckedModeBanner: false,
      home: Consumer<LanguageChanger>(
          builder: (_, languageChanger, __) {
            lChanger= languageChanger.data;
            return Directionality(
              textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
              backgroundColor: cTheme.primaryColorLight,
              appBar: customAppbar(cTheme.primaryColorLight, lChanger[8]["title"], cTheme.primaryColorDark, context),
              body: SafeArea(
                child: Flex(
                  direction: or?Axis.horizontal:Axis.vertical,
                  children: [
                    Expanded(
                      child: Container(
                        width: or?wid/2:wid,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50),),
                        ),
                        child: Center(
                          child: Image.memory(
                            Uint8List.fromList(base64.decode("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")),
                            fit: BoxFit.cover,
                          ),
                          //Icon(Icons.qr_code_2_rounded, size: 100, color: Colors.white,),
                        ),
                      ),
                    ),
                    Container(
                      width: or?wid/2-20:wid,
                      height: or?hei:300,
                      // color: Colors.white,
                      child: Column(
                        mainAxisAlignment: or?MainAxisAlignment.center:MainAxisAlignment.end,
                        children: [
                          Text(lChanger[8]["subtitle"], style: TextStyle(color: Colors.grey.shade600, fontSize: 14), textAlign: TextAlign.center,),
                          SizedBox(
                            height: 30,
                          ),
                          mainBtn(wid>600?wid*0.35-80:wid-40, wid>600?62.0:72.0, cTheme.primaryColor, lChanger[8]["btn"], () {
                            print("SAVE");
                          }),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: wid>600?wid*0.85-80:wid-40,
                            height: 70,
                            // color: Colors.blueGrey,
                            child: Center(
                              child: Text(lChanger[8]["sideBtn"], style: TextStyle(fontSize: 20, color: cTheme.primaryColor),),
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
      ),
    );
  }
}
