import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/presentation/repair_screen.dart';
import 'package:graduation_project/presentation/taxi_home.dart';
import 'package:graduation_project/presentation/taxi_services.dart';
import 'package:provider/provider.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

List services=[
  "Taxi",
  "Fixation",
  "Support Center",
  "Maintenance",
];
List servicesIcons=[
  Icons.local_taxi_rounded,
  Icons.handyman_rounded,
  Icons.chat_rounded,
  Icons.cleaning_services_rounded,
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
    return MaterialApp(
      theme: cTheme,
      debugShowCheckedModeBanner: false,
      home: Consumer<LanguageChanger>(
          builder: (_, languageChanger, __) {
            lChanger= languageChanger.data;
            return Directionality(
              textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
              backgroundColor: cTheme.backgroundColor,
              appBar: customAppbar(cTheme.backgroundColor, lChanger[9]["title"], cTheme.primaryColorDark, context),
              body: SafeArea(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 70),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(lChanger[9]["subtitle"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 24),),
                            Text("John?", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 24, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      //GridView
                      GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: services.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: wid>500?2:1, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 2.3),
                          padding: EdgeInsets.symmetric(horizontal: wid>500?50:10),
                          // physics: NeverScrollableScrollPhysics(),
                          primary: true,
                          itemBuilder: (BuildContext context, int index){
                            return GestureDetector(
                              onTap: (){
                                if(index==0){
                                  Navigator.push(context, MaterialPageRoute(builder: (c){
                                    return TaxiServices();
                                  }));
                                }else if(index==1){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return RepairScreen();
                                  }));
                                }else{
                                  print("Not available for now");
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: cTheme.primaryColorLight,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(wid>500?25.sp:50.sp),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        // width: wid>500?170:140,
                                        // height: wid>500?170:140,
                                        decoration: BoxDecoration(
                                          color: cTheme.primaryColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(wid>500?20.sp:40.sp),
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(servicesIcons[index], color: Colors.white, size: wid>500?25.sp:50.sp,),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(lChanger[9]["taxiTitle"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: wid>500?8.sp:18.sp),),
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: wid>500?hei*0.29:wid*0.43,
                                              height: 0,
                                              // color: Colors.green,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      lChanger[9]["taxiSubtitle"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: wid>500?5.sp:11.sp,),
                                                      softWrap: false,
                                                      maxLines: 3,
                                                      overflow: TextOverflow.ellipsis, // new
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
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
