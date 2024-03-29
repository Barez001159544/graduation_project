import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:graduation_project/constants/loading_indicator.dart';
import 'package:graduation_project/controllers/get_user_payments.dart';
import 'package:graduation_project/controllers/get_user_properties.dart';
import 'package:graduation_project/models/fully_aparments_reponse.dart';
import 'package:graduation_project/models/fully_houses_response.dart';
import 'package:graduation_project/presentation/payment_history.dart';
import 'package:provider/provider.dart';
import 'package:typethis/typethis.dart';

import '../constants/custom_appbar.dart';
import '../constants/custom_dropdown_menu.dart';
import '../constants/main_btn.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class PropertiesScreen extends StatefulWidget {
  const PropertiesScreen({super.key});

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

// class MyObject {
//   final String? name;
//   final int? id;
//
//   MyObject({required this.name, required this.id});
// }
// List<MyObject?>? myObjects = [
//   MyObject(name: '11', id: 1),
//   MyObject(name: '22', id: 2),
//   MyObject(name: '33', id: 3),
// ];

class _PropertiesScreenState extends State<PropertiesScreen> {

  bool isHouse=true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if(Provider.of<GetUserProperties>(context, listen: false).userHousesAndApartmentsResponse==null) {
        await Provider.of<GetUserProperties>(context, listen: false).getUserProperties();
        isHouse=(Provider.of<GetUserProperties>(context, listen: false).userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses!=null)!?true:false;
        await Provider.of<GetUserProperties>(context, listen: false).getAllHouses();
        await Provider.of<GetUserProperties>(context, listen: false).getAllApartments();
      }
    });
  }
  String? selected;
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return   Consumer3<LanguageChanger, GetUserProperties, GetUserPayments>(
        builder: (_, languageChanger, getUserProperties, getUserPayments, __) {
          lChanger= languageChanger.data;
          // isHouse=(getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses!.isNotEmpty as bool)?true:false;
          return Directionality(
            textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              backgroundColor: cTheme.scaffoldBackgroundColor,
              appBar: CustomAppBar(cTheme.scaffoldBackgroundColor, lChanger[18]["title"], cTheme.primaryColorDark, context),
              body: SafeArea(
                child: getUserProperties.isLoading?LoadingIndicator(cTheme.primaryColorLight):
                RefreshIndicator(
                  onRefresh: () async{
                    getUserProperties.getAllHouses();
                    getUserProperties.getAllApartments();
                    getUserProperties.getUserProperties();
                  },
                  child: (getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse==null)?
                  ListView(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.satellite_alt_rounded, color: cTheme.primaryColorDark, size: 70,),
                            SizedBox(height: 10,),
                            Text(lChanger[18]["empty"], style: TextStyle(color: Colors.grey, fontSize: 12),),
                          ],
                        ),
                      ),
                    ],
                  ):ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 70),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TypeThis(
                              string: lChanger[18]["subtitle"],
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: wid>600?wid*0.25:0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(onPressed: (){
                                  setState(() {
                                    if((getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses!.isNotEmpty as bool)){
                                      isHouse=true;
                                    }
                                    print(isHouse);
                                  });
                                }, child: Text(lChanger[18]["ph1"], style: TextStyle(color: cTheme.primaryColorDark.withOpacity(0.6), fontSize: 12),),),
                                Text("${getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses!.length as int}", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 12),),
                                SizedBox(width: 5,),
                                isHouse?Icon(Icons.keyboard_arrow_up_rounded, color: cTheme.primaryColorDark, size: 12,):Icon(Icons.keyboard_arrow_down_rounded, color: cTheme.primaryColorDark, size: 12,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(onPressed: (){
                                  setState(() {
                                    if((getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.apartments!.isNotEmpty as bool)){
                                      isHouse=false;
                                    }
                                    print(isHouse);
                                  });
                                }, child: Text(lChanger[18]["ph2"], style: TextStyle(color: cTheme.primaryColorDark.withOpacity(0.6), fontSize: 12),),),
                                Text("${getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.apartments?.length as int}", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 12),),
                                SizedBox(width: 5,),
                                isHouse?Icon(Icons.keyboard_arrow_down_rounded, color: cTheme.primaryColorDark, size: 12,):Icon(Icons.keyboard_arrow_up_rounded, color: cTheme.primaryColorDark, size: 12,),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flex(
                        direction: wid>600?Axis.vertical:Axis.vertical,
                        children: List.generate(isHouse?(getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses!.length as int):(getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.apartments!.length as int), (index){
                          return GestureDetector(
                            onTap: () async{
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
                              if(isHouse){
                                EachHouseResponse? obj = getUserProperties.fullyHousesResponse?.eachHouseResponse?.firstWhere((obj) => obj?.name == getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse!.houses?[index].name,);
                                print(">>>>>>>>>${obj?.id}");
                                print(obj?.facilityId);
                                getUserProperties.getOneHouse(obj!);
                                getUserProperties.emptyOneApartment();
                                await getUserPayments.getThisMonthPaymentHistory("houses", "${obj?.id}");
                                // await getUserPayments.getAllHousePayments("houses", "${obj?.id}");
                              }else{
                                EachApartmentsResponse? obj = getUserProperties.fullyApartmentsResponse?.eachApartmentsResponse?.firstWhere((obj) => obj?.name == getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse!.apartments?[index].name,);
                                print(">>>>>>>>>${obj?.id}");
                                getUserProperties.getOneApartment(obj!);
                                getUserProperties.emptyOneHouse();
                                // await getUserPayments.getAllHousePayments("apartments", "${obj?.id}");
                                await getUserPayments.getThisMonthPaymentHistory("apartments", "${obj?.id}");
                              }
                              Navigator.of(context).pop();
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return PaymentHistory();
                              }));
                            },
                            child: Container(
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
                                        image: isHouse?AssetImage("images/house_img.jpg"):AssetImage("images/building_img.jpg"),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                          Colors.black38,
                                          BlendMode.darken,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(25)),
                                    ),
                                    // child: Center(
                                    //     child: Text('${isHouse?lChanger[18]["type2"]:lChanger[18]["type1"]}'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 24),),
                                    // ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Text(textAlign: TextAlign.center, "Reloaded 1 of 1971 libraries in 1,131ms (compile: 147 ms, reload: 424 ms, reassemble: 348 ms)."),
                                  // ),
                                  // Divider(
                                  //   height: 10,
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        // crossAxisAlignment: CrossAxisAlignment.baseline,
                                        // textBaseline: TextBaseline.ideographic,
                                        children: [
                                          Icon(Icons.home_work_outlined, color: cTheme.primaryColor, size: 25,),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          // Text("Location: ", style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark.withOpacity(0.6)),),
                                          Text(/*isHouse?"${getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse!.houses?[index].name}":"B:${getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse!.apartments?[index].buildingName}F:${getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse!.apartments?[index].floor}A:${getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse!.apartments?[index].name}"*/"${isHouse?"House":"Apartment"}", style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark),),
                                        ],
                                      ),
                                      Row(
                                        // crossAxisAlignment: CrossAxisAlignment.baseline,
                                        // textBaseline: TextBaseline.ideographic,
                                        children: [
                                          Icon(Icons.electric_bolt_rounded, color: cTheme.primaryColor, size: 25,),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          // Text("Location: ", style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark.withOpacity(0.6)),),
                                          Text(isHouse?"${getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse!.houses?[index].electricityUnit}":"${getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse!.apartments?[index].electricityUnit}", style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark),),
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ).animate().slideY(begin: 1, curve: Curves.easeInOutQuad, duration: 1.5.seconds),
                          );
                        }),
                      ),
                    ],
                  ),
                ),

              ),
            ),
          );
        }
    );
  }
}

