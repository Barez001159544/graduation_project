import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

List images = [
  "10780304_19197030",
  "11667132_20943447",
  "11668286_20945170",
];
int ind = 0;

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController= AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage("lib/images/${images[0]}.png"), context);
      precacheImage(AssetImage("lib/images/${images[1]}.png"), context);
      precacheImage(AssetImage("lib/images/${images[2]}.png"), context);
    });
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    // print(widgets.length);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            color: Color(0xffFFFFFF),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      //
                    },
                    child: Container(
                      height: 50,
                      width: 80,
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          "Skip",
                          style: TextStyle(color: Color(0xff5d5d5d), fontWeight: FontWeight.bold, fontFamily: "NotoSans"),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: wid>480?400:wid,
                  height: wid>480?480:wid + 100,
                  child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                  Container(
                  width: wid>480?400:wid,
                    height: wid>480?400:wid,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("lib/images/${images[ind]}.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ).animate(controller: animationController).fadeIn(duration: 0.5.seconds),
                            Text(
                              "Lorem ipsum is simply a\ndummy text for your design or\nyour mobile app.",
                              style: TextStyle(
                                  fontFamily: "NotoSans", fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (i) {
                        return Container(
                          width: i == ind ? 30 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Color(0xff31344A),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 4, right: 2),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        // pageController.page != 2
                        //     ? pageController.nextPage(
                        //         duration: Duration(milliseconds: 500),
                        //         curve: Curves.easeInOut,
                        //       )
                        //     : print("END");
                        setState(() {
                          ind!=2?ind++:ind;
                          animationController.reset();
                          animationController.forward();
                        });
                      },
                      child: Container(
                        width: 210,
                        height: 80,
                        margin: EdgeInsets.only(bottom: 60),
                        decoration: BoxDecoration(
                          color: Color(0xff31344A),
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "CONTINUE",
                            style: TextStyle(
                                fontFamily: "Comic", color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Stack(
          //   children: [
          //     PageView.builder(
          //         onPageChanged: (index){
          //           setState(() {
          //             ind=index;
          //           });
          //         },
          //         controller: pageController,
          //         itemCount: 3,
          //         itemBuilder: (context, index){
          //           return Container(
          //             decoration: BoxDecoration(
          //               image: DecorationImage(
          //                 image: AssetImage("images/${images[index]}.jpg",),
          //                 fit: BoxFit.contain,
          //               ),
          //             ),
          //             child: Stack(
          //               children: [
          //                 Positioned(
          //                   left: (index==0 || index==2)?0:null,
          //                   top: index==0?(hei+100)/2:(index==1?(hei-300)/2:hei/2),
          //                   right: index==1?0:null,
          //                   child: Container(
          //                     width: 250,
          //                     height: 143,
          //                     color: index==1?Colors.white:Colors.grey,
          //                     padding: EdgeInsets.only(left: 10),
          //                     child: Align(
          //                         alignment: Alignment.centerLeft,
          //                         child: Text(index==0?"More than 700\ncharacters from\nboth universe.":(index==1?"Including Villains\nand Superheroes.":"Work, powerstats, biography & more."), style: TextStyle(color: index==1?Colors.grey:Colors.white, fontFamily: "Comic", fontSize: 25),)),
          //                   ),
          //                 ),
          //                 index==2?Column(
          //                   mainAxisAlignment: MainAxisAlignment.end,
          //                   children: [
          //                     Center(
          //                       child: GestureDetector(
          //                         onTap: (){
          //                           print("END");
          //                         },
          //                         child: GestureDetector(
          //                           onTap: ()async{
          //                             // var prefs = await SharedPreferences.getInstance();
          //                             // prefs.setBool("notFirstTime", true);
          //                             // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
          //                             //   return HomeScreen();
          //                             // }));
          //                           },
          //                           child: Container(
          //                             height:82,
          //                             width:343,
          //                             margin: EdgeInsets.all(20),
          //                             decoration: BoxDecoration(
          //                               color:Colors.white,
          //                               borderRadius: BorderRadius.all(
          //                                 Radius.circular(7),
          //                               ),
          //                               boxShadow: [
          //                                 BoxShadow(
          //                                   color: Colors.black,
          //                                   spreadRadius: 1,
          //                                   blurRadius: 3,
          //                                   offset: Offset(5, 5),
          //                                 ),
          //                               ],
          //                               border: Border.all(
          //                                 width: 1, color: Colors.black, style: BorderStyle.solid,
          //                               ),
          //                             ),
          //                             child: Center(child: Text("Continue", style: TextStyle(color: Colors.black, fontFamily: "Comic", fontSize: 20),)),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ):Container(),
          //               ],
          //             ),
          //           );
          //           Image.asset('images/${images[index]}.jpg', fit: BoxFit.cover,);
          //         }),
          //     Positioned(
          //       top: 0,
          //       right: 0,
          //       child: GestureDetector(
          //         onTap: (){
          //           pageController.page!=2?pageController.nextPage(
          //             duration: Duration(milliseconds: 500),
          //             curve: Curves.easeInOut,
          //           ):print("END");
          //         },
          //         child: Container(
          //           width: 60,
          //           height: 40,
          //           child: Center(
          //             child: Text("Next", style: TextStyle(fontFamily: "Comic", color: Colors.purple),),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Align(
          //       alignment: Alignment.bottomCenter,
          //       child: GestureDetector(
          //         onTap: (){
          //           pageController.page!=2?pageController.nextPage(
          //             duration: Duration(milliseconds: 500),
          //             curve: Curves.easeInOut,
          //           ):print("END");
          //         },
          //         child: Container(
          //           width: 250,
          //           height: 80,
          //           margin: EdgeInsets.only(bottom: 60),
          //           decoration: BoxDecoration(
          //             color: Colors.purple,
          //             borderRadius: BorderRadius.all(
          //               Radius.circular(100),
          //             ),
          //           ),
          //           child: Center(
          //             child: Text("CONTINUE", style: TextStyle(fontFamily: "Comic", color: Colors.white),),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Positioned(
          //       top: 60,
          //       left: 10,
          //       child: Row(
          //         children: List.generate(3, (i) {
          //           return Container(
          //             width: i==ind?30:10,
          //             height: 10,
          //             decoration: BoxDecoration(
          //               color: Colors.purple,
          //               borderRadius: BorderRadius.all(
          //                 Radius.circular(5),
          //               ),
          //             ),
          //             margin: EdgeInsets.only(bottom: 4, right: 2),
          //           );
          //         }),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
