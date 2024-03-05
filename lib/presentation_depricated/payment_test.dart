import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:graduation_project/presentation/forgot_password_screen.dart";
import "package:provider/provider.dart";

import "../constants/custom_appbar.dart";
import "../controllers/theme_changer.dart";
import "../custom theme data/themes.dart";

class PaymentTest extends StatefulWidget {
  const PaymentTest({super.key});

  @override
  State<PaymentTest> createState() => _PaymentTestState();
}

class _PaymentTestState extends State<PaymentTest> {
  late PageController scrollController;
  int page=0;
  @override
  void initState() {
    // TODO: implement initState
    scrollController=PageController(initialPage: 0);
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    // double wid1= wid>600?wid*0.9/2-20:wid;
    // double hei1= wid>600?wid*0.5:hei/2;
    // double wid2= wid>600?wid*0.9/2-20:wid;
    // double hei2= wid>600?wid*0.5:hei/2;
    double wid1= wid>600?wid/2.2:wid;
    double hei1= wid>600?wid/2.2:hei/2;
    double wid2= wid>600?wid/2.2:wid;
    double hei2= wid>600?wid/2.2:hei/2;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    List lChanger;
    return Scaffold(
      backgroundColor: cTheme.scaffoldBackgroundColor,
      appBar: CustomAppBar(cTheme.scaffoldBackgroundColor, "Refill", cTheme.primaryColorDark, context),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: wid>500?300:wid*0.7,
                  height: 50,
                  child: Text("Pay with FIB to refill:", style: TextStyle(fontSize: 20),),
              ),
              IconButton(
                iconSize: 35,
                onPressed: (){
                  setState(() {
                    scrollController.page!=0?scrollController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ):print("END");
                    page--;
                  });
                },
                  icon: Icon(Icons.keyboard_arrow_up_rounded),
              ),
              Container(
                width: wid>500?300:wid*0.7,
                height: wid>500?300:wid*0.7,
                child: PageView.builder(
                  itemCount: 3,
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (index, context){
                  return Container(
                    width: wid>500?300:wid*0.7,
                    height: wid>500?300:wid*0.7,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: cTheme.primaryColorLight,
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xff65CA9B),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(45),
                                bottomLeft: Radius.circular(15),
                              ),
                              image: DecorationImage(
                                image: AssetImage("images/fib-transparent.png"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.electric_bolt_rounded, size: 70,),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Electricity"),
                                      Text("0/1"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Stack(
                                    alignment: Alignment.centerLeft,
                                    fit: StackFit.passthrough,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: wid>500?260:wid*0.7-40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(100),
                                          ),
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: wid>500?260*(8/10):((wid*0.7)-40)*(8/10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(100),
                                            topRight: Radius.circular(25),
                                            bottomLeft: Radius.circular(100),
                                            bottomRight: Radius.circular(25),
                                          ),
                                          color: cTheme.primaryColor
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              IconButton(
                iconSize: 35,
                onPressed: (){
                  setState(() {
                    scrollController.page!=2?scrollController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ):print("END");
                    page++;
                  });
                },
                icon: Icon(Icons.keyboard_arrow_down_rounded),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index){
                  return Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(right: index!=2?10:0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      border: Border.all(color: page==index?cTheme.primaryColor:Colors.grey, width: 1, style: BorderStyle.solid),
                    ),
                    child: Icon(Icons.electric_bolt_rounded, color: page==index?cTheme.primaryColor:Colors.grey,),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
