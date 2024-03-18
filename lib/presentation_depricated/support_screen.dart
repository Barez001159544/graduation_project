import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:graduation_project/constants/custom_textfields.dart';
import 'package:provider/provider.dart';

import '../constants/custom_appbar.dart';
import '../constants/pick_media.dart';
import '../controllers/get_token.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class SupportCenter extends StatefulWidget {
  const SupportCenter({super.key});

  @override
  State<SupportCenter> createState() => _SupportCenterState();
}

// List me=["HI", "Thanks buddy", "Yes indeed", "Yeah, I noticed, what was that?"];
// List him=["HI, How are You?", "Did you go to school?", "I could not get to school today, you know?", "I was so sick, not of a decease, but because of the slavery we're in!"];

class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

List<ChatMessage> messages2 = [
  ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu? ", messageType: "sender"),
  ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
  ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
  ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
  ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
];

class _SupportCenterState extends State<SupportCenter>  with SingleTickerProviderStateMixin{

  // -----------------------------------------------------

  // -----------------------------------------------------
  bool isLow=true;
  ScrollController scrollController= ScrollController();
  TextEditingController _controller= TextEditingController();
  List<ChatMessage> messages=[];
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    for(int i=messages2.length-1; i>=0; i--){
      messages.add(messages2[i]);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   messages.reversed.toList();
  // //   WidgetsBinding.instance!.addPostFrameCallback((_) {
  // //     // Scroll to the bottom of the list view
  // //     scrollController.animateTo(
  // //       scrollController.position.maxScrollExtent,
  // //       duration: const Duration(seconds: 1),
  // //       curve: Curves.easeInOut,
  // //     );
  // //   });
  // }

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    bool or=MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Consumer2<LanguageChanger, GetToken>(
        builder: (_, languageChanger, getToken, __) {
          lChanger= languageChanger.data;
          return Directionality(
          textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
          child: Scaffold(
            backgroundColor: cTheme.scaffoldBackgroundColor,
            appBar: CustomAppBar(cTheme.scaffoldBackgroundColor, lChanger[17]["title"], cTheme.primaryColorDark, context),
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          height: hei,
                          padding: EdgeInsets.only(left: 10, right: 10,),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  child: messages.isNotEmpty?ListView.builder(
                                    reverse: true,
                                    itemCount: messages.length,
                                      controller: scrollController,
                                      itemBuilder: (context, index){
                                    return Align(
                                      alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                                      child: index==0?AnimatedContainer(
                                        // width: wid*0.8,
                                        margin: EdgeInsets.only(bottom: index==0?(isLow?61:151):10, left: (messages[index].messageType  == "receiver"?0:wid*0.1), right: (messages[index].messageType  == "receiver"?wid*0.1:0)),
                                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: (messages[index].messageType  == "receiver"?cTheme.primaryColorLight:cTheme.primaryColor.withOpacity(0.9)),
                                          borderRadius: BorderRadius.all(Radius.circular(20),),
                                        ),
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.decelerate,
                                        child: Text(messages[index].messageContent, style: TextStyle(color: (messages[index].messageType  == "receiver"?cTheme.primaryColorDark:Colors.white)),),
                                      ):Container(
                                        // width: wid*0.8,
                                        margin: EdgeInsets.only(bottom: index==0?61:10, left: (messages[index].messageType  == "receiver"?0:wid*0.1), right: (messages[index].messageType  == "receiver"?wid*0.1:0)),
                                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: (messages[index].messageType  == "receiver"?cTheme.primaryColorLight:cTheme.primaryColor.withOpacity(0.9)),
                                          borderRadius: BorderRadius.all(Radius.circular(20),),
                                        ),
                                        child: Text(messages[index].messageContent, style: TextStyle(color: (messages[index].messageType  == "receiver"?cTheme.primaryColorDark:Colors.white)),),
                                      ),
                                    );
                                  }):Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.hourglass_empty_rounded, size: 70, color: Colors.grey,),
                                      Text(textAlign: TextAlign.center, "Try to deliver your voice to the HQ\nof your company by sending any message."),
                                    ],
                                  ),
                                ),
                              ),
                              //
                            ],
                          ),
                        ),
                      ),
                      //
                    ],
                  ),
                  AnimatedPositioned(
                    bottom: isLow?-90:0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10,),
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: cTheme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                        )
                      ),
                      child: Container(
                        width: wid-20,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: cTheme.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(25),),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: (){
                                    pickImage();
                                  },
                                  icon: Icon(Icons.image_rounded, color: Colors.white,),
                                ),
                                IconButton(
                                  onPressed: (){
                                    pickFile();
                                  },
                                  icon: Icon(Icons.file_present_rounded, color: Colors.white,),
                                ),
                                Expanded(
                                  child: SizedBox(),
                                ),
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      isLow=!isLow;
                                    });
                                  },
                                  icon: Icon(isLow?Icons.keyboard_arrow_up_rounded:Icons.keyboard_arrow_down_rounded, color: Colors.white,),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: CustomTextFields(_controller, lChanger[17]["ph"], Colors.white, Colors.white, Colors.grey.withOpacity(0.2), 15, 1, false)),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _controller.text.isNotEmpty && _controller.text.trim()!=""?messages.insert(0,ChatMessage(messageContent: _controller.text.trim(), messageType: "sender")):print("Nothing to send!");
                                      _controller.clear();
                                    });
                                  },
                                  icon: Icon(Icons.send, color: Colors.white,),
                                )
                              ],
                            ),
                          ],
                        ),
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
