import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graduation_project/controllers/get_protests.dart';
import 'package:graduation_project/presentation/new_protest.dart';
import 'package:provider/provider.dart';

import '../constants/confirmation_custom_alert_dialog.dart';
import '../constants/custom_textfields.dart';
import '../constants/custom_appbar.dart';
import '../constants/main_btn.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class ProtestScreen extends StatefulWidget {
  const ProtestScreen({super.key});

  @override
  State<ProtestScreen> createState() => _ProtestScreenState();
}

class _ProtestScreenState extends State<ProtestScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController coreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer3<ThemeChanger, LanguageChanger, GetProtests>(
          builder: (_, tChanger, languageChanger, getAllProtests, child) {
            lChanger=languageChanger.data;
          return Directionality(
            textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: cTheme.primaryColorLight,
              appBar: CustomAppBar(cTheme.primaryColorLight, lChanger[16]["title"], cTheme.primaryColorDark, context),
              floatingActionButton: FloatingActionButton(
                foregroundColor: cTheme.primaryColor,
                backgroundColor: cTheme.primaryColor,
                focusColor: cTheme.primaryColor,
                tooltip: lChanger[16]["fab"],
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return NewProtest();
                  }));
                },
                child: Icon(Icons.edit_rounded, color: Colors.white,),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              body: SafeArea(
                child: getAllProtests.protestAllResponse==null?Center(
                  child: Icon(Icons.hourglass_empty_rounded),
                ):SingleChildScrollView(
                  child: Column(
                    children: List.generate(getAllProtests.protestAllResponse!.eachProtestResponse!.length, (index){
                      return Slidable(
                        // Specify a key if the Slidable is dismissible.
                        // key: const ValueKey(0),
                  
                        // The start action pane is the one at the left or the top side.
                        // startActionPane: ActionPane(
                        //   // A motion is a widget used to control how the pane animates.
                        //   motion: const ScrollMotion(),
                        //
                        //   // A pane can dismiss the Slidable.
                        //   dismissible: DismissiblePane(onDismissed: () {}),
                        //
                        //   // All actions are defined in the children parameter.
                        //   // children: [
                        //   //   // A SlidableAction can have an icon and/or a label.
                        //   //   SlidableAction(
                        //   //     backgroundColor: Color(0xFFFE4A49),
                        //   //     foregroundColor: Colors.white,
                        //   //     icon: Icons.delete,
                        //   //     label: 'Delete', onPressed: (BuildContext context) {  },
                        //   //   ),
                        //   //   SlidableAction(
                        //   //     backgroundColor: Color(0xFF21B7CA),
                        //   //     foregroundColor: Colors.white,
                        //   //     icon: Icons.share,
                        //   //     label: 'Share', onPressed: (BuildContext context) {  },
                        //   //   ),
                        //   // ],
                        // ),
                  
                        // The end action pane is the one at the right or the bottom side.
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            // A SlidableAction can have an icon and/or a label.
                            SlidableAction(
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: lChanger[16]["action"], onPressed: (BuildContext context) {  },
                            ),
                            // SlidableAction(
                            //   backgroundColor: Color(0xFF21B7CA),
                            //   foregroundColor: Colors.white,
                            //   icon: Icons.share,
                            //   label: 'Share', onPressed: (BuildContext context) {  },
                            // ),
                          ],
                        ),
                  
                        // The child of the Slidable is what the user sees when the
                        // component is not dragged.
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: cTheme.primaryColorLight,
                            border: Border(
                              bottom: BorderSide(width: 10, color: cTheme.primaryColorLight),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                  child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${getAllProtests.protestAllResponse!.eachProtestResponse?[index].title??"DUNO"}", style: TextStyle(fontSize: 16, color: cTheme.primaryColorDark),),
                                          Text("${getAllProtests.protestAllResponse!.eachProtestResponse?[index].updatedAt?.split("T")[0]}", style: TextStyle(color: Colors.grey, fontSize: 12),),
                                        ],
                                      ))),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: getAllProtests.protestAllResponse!.eachProtestResponse?[index].status=="pending"?Colors.yellow.withOpacity(0.4):Colors.green.withOpacity(0.4),
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(getAllProtests.protestAllResponse!.eachProtestResponse?[index].status=="pending"?Icons.more_horiz_rounded:Icons.check, color: Colors.white,),
                                    Text(getAllProtests.protestAllResponse!.eachProtestResponse?[index].status=="pending"?lChanger[16]["status2"]:lChanger[16]["status2"], style: TextStyle(fontSize: 8),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          );
        }
      );
  }
}
