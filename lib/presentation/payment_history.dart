import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project/controllers/get_user_payments.dart';
import 'package:graduation_project/controllers/get_user_properties.dart';
import 'package:provider/provider.dart';
import 'package:typethis/typethis.dart';

import '../constants/custom_appbar.dart';
import '../controllers/get_token.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';
import '../models/all_house_payments.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    return Consumer4<ThemeChanger, LanguageChanger, GetUserProperties, GetUserPayments>(
        builder: (_, tChanger, lChanger, getUserProperties, getUserPayments, child) {
          return Directionality(
            textDirection: lChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              appBar: CustomAppBar(cTheme.scaffoldBackgroundColor, lChanger.data[0]["title"], cTheme.primaryColorDark, context),
              backgroundColor: cTheme.scaffoldBackgroundColor,
              body: SafeArea(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: wid>600?EdgeInsets.symmetric(horizontal: wid*0.25):EdgeInsets.all(20),
                      // color: Colors.red,
                      child: Column(
                        children: [
                          // Text("${getUserProperties.oneHouseResponse!=null?"HOUSE":"APARTMENT"}"),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Text("Name: ", style: TextStyle(color: Colors.grey, fontSize: 16),),
                                Text("${getUserProperties.oneHouseResponse!=null?"Houses":"Apartments"}-${getUserProperties.oneHouseResponse!=null?getUserProperties.oneHouseResponse?.name:getUserProperties.oneApartmentResponse?.name}", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                              ],
                            ),
                          ),
                          getUserProperties.oneApartmentResponse!=null?Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Text("Floor: ", style: TextStyle(color: Colors.grey, fontSize: 16),),
                                Text("${getUserProperties.oneApartmentResponse?.floor}", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                              ],
                            ),
                          ):SizedBox(),
                          // getUserProperties.oneApartmentResponse!=null?Padding(
                          //   padding: const EdgeInsets.only(bottom: 10),
                          //   child: Row(
                          //     children: [
                          //       Text("Building: ", style: TextStyle(color: Colors.grey, fontSize: 16),),
                          //       Text("${getUserProperties.oneApartmentResponse?.buildingId}", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                          //     ],
                          //   ),
                          // ):SizedBox(),
                          // getUserProperties.oneHouseResponse!=null?Padding(
                          //   padding: const EdgeInsets.only(bottom: 10),
                          //   child: Row(
                          //     children: [
                          //       Text("Facility Id: ", style: TextStyle(color: Colors.grey, fontSize: 16),),
                          //       Text("${getUserProperties.oneHouseResponse?.facilityId}", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                          //     ],
                          //   ),
                          // ):SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Text("Electricity Unit: ", style: TextStyle(color: Colors.grey, fontSize: 16),),
                                Text("${getUserProperties.oneHouseResponse!=null?getUserProperties.oneHouseResponse?.electricityUnit:getUserProperties.oneApartmentResponse?.electricityUnit}", style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 10),
                      child: Center(
                        child: Text("Payment History", style: TextStyle(color: Colors.grey, fontSize: 16),),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(onPressed: (){
                              setState(() {
                                // if((getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.houses!.isNotEmpty as bool)){
                                //   isHouse=true;
                                // }
                                // print(isHouse);
                              });
                            }, child: Text("Fee", style: TextStyle(color: cTheme.primaryColorDark.withOpacity(0.6), fontSize: 12),),),
                            true?Icon(Icons.keyboard_arrow_up_rounded, color: cTheme.primaryColorDark, size: 12,):Icon(Icons.keyboard_arrow_down_rounded, color: cTheme.primaryColorDark, size: 12,),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(onPressed: (){
                              setState(() {
                                // if((getUserProperties.userHousesAndApartmentsResponse?.residentialPropertiesResponse?.apartments!.isNotEmpty as bool)){
                                //   isHouse=false;
                                // }
                                // print(isHouse);
                              });
                            }, child: Text("Water", style: TextStyle(color: cTheme.primaryColorDark.withOpacity(0.6), fontSize: 12),),),
                            true?Icon(Icons.keyboard_arrow_down_rounded, color: cTheme.primaryColorDark, size: 12,):Icon(Icons.keyboard_arrow_up_rounded, color: cTheme.primaryColorDark, size: 12,),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (getUserPayments.thisMonthPaymentHistory?.eachHouseFee)!.isEmpty?Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                        child: Icon(Icons.satellite_alt_rounded),
                      ),
                    ):Flex(
                      direction: wid>600?Axis.vertical:Axis.vertical,
                      children: List.generate(getUserPayments.thisMonthPaymentHistory!.eachHouseFee!.length, (index){
                        return Tooltip(
                          message: "${getUserPayments.thisMonthPaymentHistory?.eachHouseFee?[index].isPaid==0?"Unpaid":"Paid"}",
                          child: Container(
                            width: wid>600?wid/2:wid,
                            margin: wid>600?EdgeInsets.only(top: 10, bottom: 50):EdgeInsets.all(10),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                              color: cTheme.primaryColorLight,
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.money_rounded, color: cTheme.primaryColor, size: 25,),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("${getUserPayments.thisMonthPaymentHistory!.eachHouseFee?[index].amountPaid} IQD", style: TextStyle(fontSize: 12, color: cTheme.primaryColorDark),),
                                      ],
                                    ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Icon(Icons.date_range_rounded, color: cTheme.primaryColor, size: 25,),
                                    //     SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Text("${getUserPayments.allHousePayments!.eachHousePayment?[index].createdAt}".split("T")[0], style: TextStyle(fontSize: 12, color: cTheme.primaryColorDark),),
                                    //   ],
                                    // ),
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        color: getUserPayments.thisMonthPaymentHistory?.eachHouseFee?[index].isPaid==0?Colors.red:Colors.green,
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.filter_list_rounded, color: cTheme.primaryColor, size: 25,),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("${getUserPayments.thisMonthPaymentHistory!.eachHouseFee?[index].feeType}".split("T")[0], style: TextStyle(fontSize: 12, color: cTheme.primaryColorDark),),
                                      ],
                                    ),
                                    Container(child: Text("${getUserPayments.thisMonthPaymentHistory!.eachHouseFee?[index].updatedAt}".split("T")[0].replaceAll("-", "."), style: TextStyle(color: cTheme.primaryColorDark.withOpacity(0.6), fontSize: 10),)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
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
