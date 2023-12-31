import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
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
    return MaterialApp(
      theme: cTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: cTheme.primaryColorLight,
        appBar: customAppbar(cTheme.primaryColorLight, "Scan QR Code", cTheme.primaryColorDark, context),
        body: SafeArea(
          child: Flex(
            direction: or?Axis.horizontal:Axis.vertical,
            children: [
              Expanded(
                child: Container(
                  width: or?wid/2:wid,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.all(Radius.circular(50),),
                  ),
                  child: Center(
                    child: Icon(Icons.qr_code_2_rounded, size: 100, color: Colors.white,),
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
                    Text("Lorem ipsum is simply a dummy text for your\nweb design and mobile app development.", style: TextStyle(color: Colors.grey.shade600, fontSize: 14), textAlign: TextAlign.center,),
                    SizedBox(
                      height: 30,
                    ),
                    mainBtn(wid>600?wid*0.35-80:wid-40, wid>600?62.0:72.0, cTheme.primaryColor, "SAVE", () {
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
                        child: Text("Enter Manully", style: TextStyle(fontSize: 20, color: cTheme.primaryColor),),
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
}
