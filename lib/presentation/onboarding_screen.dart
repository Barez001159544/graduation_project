import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/presentation/login_screen.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

final images = [
  AssetImage("images/onboard1.png"),
  AssetImage("images/onboard2.png"),
  AssetImage("images/onboard3.png"),
];

List txt=[
  "Lorem ipsum is simply a\ndummy text for your design or\nyour mobile app.",
  "Lorem ipsum is simply a\ndummy text for your design or\nyour mobile app2.",
  "Lorem ipsum is simply a\ndummy text for your design or\nyour mobile app3.",
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
  _preloadImages() {
    images.map((img) => precacheImage(img, context));
  }
  @override
  void didChangeDependencies() {
    _preloadImages();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme : lightTheme;
    return MaterialApp(
      theme: cTheme,
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
                        image: images[ind],
                        fit: BoxFit.cover,
                      ),
                    ),
                    // child: Image.network(ind==0?'https://picsum.photos/250?image=9':(ind==1?"https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500":"https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")),
                  ),
                            Text(
                              "${txt[ind]}",
                              style: TextStyle(
                                  fontFamily: "NotoSans", fontSize: 18),
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
                      child: mainBtn(wid>600?wid*0.35-80:wid-40, wid>600?62.0:72.0, cTheme.primaryColor, "CONTINUE", () async {
                          if(ind!=2){
                            setState(() {
                              ind++;
                              animationController.reset();
                              animationController.forward();
                            });
                          }else{
                            final storage = new FlutterSecureStorage();
                            await storage.write(key: "firstTime", value: "Yes");
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
      ),
    );
  }
}
