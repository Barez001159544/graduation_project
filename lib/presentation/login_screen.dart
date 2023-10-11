import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isShown=true;
TextEditingController username= TextEditingController();
TextEditingController password= TextEditingController();
String errorMessage="";

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff155E7D),
        body: SafeArea(
          child: Center(
            child: Container(
                width: wid>600?wid*0.35:wid,
                height: wid>600?wid*0.4:hei,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(wid>600?45:0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(wid>600?"Welcome Back!":"Welcome\nBack!", style: TextStyle(fontFamily: "NotoSans", fontSize: 36), textAlign: TextAlign.center,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          child: TextField(
                            controller: username,
                            cursorColor: Colors.black,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              hintText: "Username",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1, color: Colors.grey, style: BorderStyle.solid,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1, color: Color(0xff155E7D), style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: password,
                                  cursorColor: Colors.black,
                                  obscureText: isShown,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1, color: Colors.grey, style: BorderStyle.solid,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1, color: Color(0xff155E7D), style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isShown=!isShown;
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  width: 40,
                                  height: 40,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Icon(isShown?Icons.lock_outline_rounded:Icons.lock_open_rounded, size: 20,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40,),
                          child: Text("$errorMessage", style: TextStyle(fontSize: 10, color: Colors.red),),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          if(username.text.isEmpty || password.text.isEmpty){
                            errorMessage="leave no field empty";
                          }else{
                            print("\$USERNAME: ${username.text}, \$PASSWORD: ${password.text}");
                          }
                        });
                      },
                      child: Container(
                        width: wid>600?wid*0.35-80:wid*0.5,
                        height: wid>600?62:72,
                        decoration: BoxDecoration(
                          color: Color(0xff155E7D),
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontFamily: "NotoSans", color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.grey,),
                        ),
                      ),
                      child: Text("Forgot Password?",
                        style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                      ),
                    ),
                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }
}
