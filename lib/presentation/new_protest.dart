import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project/constants/custom_textfields.dart';
import 'package:provider/provider.dart';

import '../constants/custom_alert_dialog.dart';
import '../constants/custom_dropdown_menu.dart';
import '../constants/custom_toast_notification.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class NewProtest extends StatefulWidget {
  const NewProtest({super.key});

  @override
  State<NewProtest> createState() => _NewProtestState();
}

class _NewProtestState extends State<NewProtest> {
  PageController pageController= PageController();
  TextEditingController titleController= TextEditingController();
  TextEditingController descriptionController= TextEditingController();
  String error="";
  int ind=0;
  double currentSliderValue=1;
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer2<ThemeChanger, LanguageChanger>(
        builder: (_, tChanger, languageChanger, child) {
          lChanger=languageChanger.data;
        return Scaffold(
          backgroundColor: cTheme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Flex(
              direction: wid>600?Axis.horizontal:Axis.vertical,
              children: [
                Container(
                  width: wid>600?wid*0.3:wid,
                  height: wid>600?hei:150,
                  decoration: BoxDecoration(
                    color: cTheme.primaryColorLight,
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(lChanger[16]["steps"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16), textAlign: TextAlign.center,),
                      SizedBox(
                        height: wid>600?50:20,
                      ),
                      Flex(
                        direction: wid>600?Axis.vertical:Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: cTheme.primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                            ),
                            child: Icon(Icons.notes_rounded, color: Colors.white,),
                          ),
                          Container(
                            width: wid>600?1:50,
                            height: wid>600?50:1,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: ind>0?cTheme.primaryColor:cTheme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                            ),
                            child: Icon(Icons.format_list_numbered_rounded, color: Colors.white,),
                          ),
                          Container(
                            width: wid>600?1:50,
                            height: wid>600?50:1,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: ind>1?cTheme.primaryColor:cTheme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                            ),
                            child: Icon(Icons.check_rounded, color: Colors.white,),
                          ),
                        ]
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: wid,
                    color: cTheme.primaryColorLight,
                    child: PageView.builder(
                      itemCount: 3,
                        controller: pageController,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                      return Container(
                        // color: Colors.amber,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: index==0?Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(lChanger[16]["p1Title"], style: TextStyle(color: cTheme.primaryColorDark, fontSize: 20),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(lChanger[16]["p1Message"], style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark),),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                          child: Text("+964 0700 123 45 67", style: TextStyle(fontSize: 16, color: Colors.white),),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                          child: Text("example@gmail.com", style: TextStyle(fontSize: 16, color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                ],
                              ):(index==1?Column(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(lChanger[16]["p2Title1"], style: TextStyle(fontSize: 16, color: Colors.grey),),
                                          Text(error, style: TextStyle(fontSize: 16, color: Colors.red),),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // CustomDropDownMenu("What exactly do you require?", wid, 50, 15, cTheme.backgroundColor, cTheme.primaryColorDark, ["KRD", "ARB", "ENG"], "KRD", (val){
                                      //   setState(() {
                                      //     // maintainType=val;
                                      //     print(val);
                                      //   });
                                      // }),
                                      CustomTextFields(titleController, lChanger[16]["p2Ph1"], cTheme.primaryColorDark, cTheme.primaryColorDark, cTheme.scaffoldBackgroundColor, 15, 1),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${lChanger[16]["p2Title2"]} ${currentSliderValue.round()} Normal", style: TextStyle(fontSize: 16, color: Colors.grey),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Slider(
                                        min: 1,
                                        max: 5,
                                        value: currentSliderValue,
                                        divisions: 4,
                                        // label: currentSliderValue.round().toString(),
                                        thumbColor: cTheme.primaryColor,
                                        activeColor: cTheme.scaffoldBackgroundColor,
                                        inactiveColor: cTheme.scaffoldBackgroundColor,
                                        onChanged: (val){
                                          setState(() {
                                            currentSliderValue=val;
                                          });
                                        },),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text("Name", style: TextStyle(fontSize: 16, color: Colors.grey),),
                                  //     SizedBox(
                                  //       height: 10,
                                  //     ),
                                  //     CustomTextFields(TextEditingController(), "hint", cTheme.primaryColorDark, cTheme.primaryColorDark, cTheme.backgroundColor, 15, 1),
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(lChanger[16]["p2Title3"], style: TextStyle(fontSize: 16, color: Colors.grey),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: wid,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: cTheme.primaryColor.withOpacity(0.5),
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.image_rounded, color: cTheme.primaryColorDark, size: 30,),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(lChanger[16]["p2Ph2"], style: TextStyle(fontSize: 12, color: cTheme.primaryColorDark),),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(lChanger[16]["p2Title4"], style: TextStyle(fontSize: 16, color: Colors.grey),),
                                            Text(error, style: TextStyle(fontSize: 16, color: Colors.red),),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(child: CustomTextFields(descriptionController, lChanger[16]["p2Ph3"], cTheme.primaryColorDark, cTheme.primaryColorDark, cTheme.scaffoldBackgroundColor, 15, null)),
                                      ],
                                    ),
                                  ),
                                ],
                              ):Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(lChanger[16]["p3Title1"], style: TextStyle(color: Colors.white70, fontSize: 16),),
                                            Text(titleController.text==""?lChanger[16]["if1"]:titleController.text, style: TextStyle(color: Colors.white, fontSize: 16),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(lChanger[16]["p3Title2"], style: TextStyle(color: Colors.white70, fontSize: 16),),
                                            Text("${currentSliderValue.round()}", style: TextStyle(color: Colors.white, fontSize: 16),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(lChanger[16]["p3Title3"], style: TextStyle(color: Colors.white70, fontSize: 16),),
                                            Flexible(
                                              child:  Container(
                                                child:  Text(
                                                  descriptionController.text==""?lChanger[16]["if2"]:descriptionController.text,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            // Container(child: Text(descriptionController.text, style: TextStyle(color: Colors.white, fontSize: 16), overflow: TextOverflow.ellipsis,)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  Text(lChanger[16]["confirmMessage"], style: TextStyle(fontSize: 12, color: cTheme.primaryColorDark), textAlign: TextAlign.center, ),
                                ],
                              )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: wid>600?MainAxisAlignment.end:MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: wid>600?200:wid/2-20,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: (){
                                      setState(() {
                                        ind==0?ind:ind--;
                                      });
                                      if(index==0){
                                        Navigator.of(context).pop();
                                      }else{
                                        pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                                      }

                                    },
                                    child: Text(lChanger[16]["backBtn"], style: TextStyle(color: Colors.white),),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                      foregroundColor: Colors.grey,
                                      elevation: 0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: wid>600?200:wid/2-20,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: (){

                                      if(index==1 && (titleController.text=="" || descriptionController.text=="")){
                                        setState(() {
                                          error=lChanger[16]["mandatory"];
                                        });
                                      }else if(index==2){
                                        Navigator.of(context).pop();
                                        CustomToastNotification(context, Icon(Icons.error_outline_rounded, color: Colors.red,), lChanger[16]["errorAlertMessage"], cTheme.primaryColorLight, cTheme.primaryColorDark);
                                        /// CustomAlertDialog(cTheme.primaryColorLight, cTheme.primaryColorDark, "Title", "Some text will be shown here", "Thumbs Up", true, context, (){
                                        ///   // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                                        ///   //   return Test();
                                        ///   // }), (route) => false);
                                        ///   // Navigator.of(context).pop();
                                        /// }, cTheme.primaryColor);
                                      }else{
                                        pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                                        setState(() {
                                          ind==2?ind:ind++;
                                        });
                                      }
                                    },
                                    child: Text(index==2?lChanger[16]["confirmBtn"]:lChanger[16]["nextBtn"], style: TextStyle(color: Colors.white),),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                      foregroundColor: Colors.grey,
                                      elevation: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    })
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

