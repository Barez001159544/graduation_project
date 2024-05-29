import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/presentation/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/main_btn.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

final images = [
  AssetImage("images/onboard2.png"),
  AssetImage("images/onboard1.png"),
  AssetImage("images/onboard3.png"),
];

List txt=[
  "Welcome to the RCMS app,\nhere you can manage\nyour properties at ease",
  "Discover powerful features\nsuch as Payment, making Protest,\nrequesting Maintenance & more",
  "Ready to dive in?\nsubscribe with a residential\nmanagement and enjoy",
];

int ind = 0;

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController= AnimationController(vsync: this);
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  // _preloadImages() {
  //   images.map((img) => precacheImage(img, context));
  // }
  // @override
  // void didChangeDependencies() {
  //   _preloadImages();
  //   super.didChangeDependencies();
  // }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    return Scaffold(
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
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:
                            (context) => LoginScreen(),
                        ),
                      );
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
                  width: wid>480?hei/2:wid,
                  height: wid>480?hei/2:wid + 100,
                  child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                  Container(
                  width: wid>480?hei/2.7:wid,
                    height: wid>480?hei/2.7:wid,
                    decoration: BoxDecoration(
                      // color: Colors.green,
                      image: DecorationImage(
                        image: images[ind],
                        fit: BoxFit.cover,
                      ),
                    ),
                    // child: Image.network(ind==0?'https://picsum.photos/250?image=9':(ind==1?"https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500":"https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")),
                  ),
                            Text(
                              "${txt[ind]}",
                              style: TextStyle(
                                  fontFamily: "NotoSans", fontSize: 18, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                ).animate(controller: animationController).fadeIn(duration: 0.5.seconds, curve: Curves.easeInOut),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (i) {
                        return Container(
                          width: i == ind ? 30 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Color(0xff155E7D),
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
                    Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: MainBtn(wid>600?wid*0.35-80:wid-40, wid>600?62.0:72.0, cTheme.primaryColor, "CONTINUE", () async {
                          if(ind!=2){
                            setState(() {
                              ind++;
                              animationController.reset();
                              animationController.forward();
                            });
                          }else{
                            // final storage = new FlutterSecureStorage();
                            // await storage.write(key: "firstTime", value: "Yes");
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('firstTime', false);
                            Navigator.pushReplacement(context,
                              MaterialPageRoute(builder:
                                  (context) => LoginScreen(),
                              ),
                            );
                          }
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
