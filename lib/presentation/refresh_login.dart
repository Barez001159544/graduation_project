import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/presentation/home_screen.dart';
import 'package:provider/provider.dart';

import '../controllers/get_get_self.dart';
import 'engineering_screen.dart';

class RefreshLogin extends StatefulWidget {
  const RefreshLogin({super.key});

  @override
  State<RefreshLogin> createState() => _RefreshLoginState();
}

class _RefreshLoginState extends State<RefreshLogin> {

  Future<String?> getRole() async {
    await Provider.of<GetGetSelf>(context, listen: false).getGetSelf();
    await Provider.of<GetGetSelf>(context, listen: false).getUserRoles(Provider.of<GetGetSelf>(context, listen: false).getSelfResponse?.userDetails?.email);
    print("************");
    // print(Provider.of<GetGetSelf>(context, listen: false).rolesResponse?.roles);
    print("************");
    // Simulate some asynchronous operation to retrieve a String value
    // String? rToken = await TokenManager().readToken("accessToken");
    // print("%%%%%%%%${Provider.of<GetGetSelf>(context, listen: false).getSelfResponse?.userDetails?.name}");
    // return Future.value(Provider.of<GetGetSelf>(context, listen: false).getSelfResponse?.userDetails?.name);
    //(Provider.of<GetGetSelf>(context, listen: false).rolesResponse!.roles!.contains("resident"))?"Resident":"Employee"

    return Future.value(Provider.of<GetGetSelf>(context, listen: false).rolesResponse==null?"None":((Provider.of<GetGetSelf>(context, listen: false).rolesResponse!.roles!.contains("resident"))?"Resident":"Employee"));
    // return "Resident";
  }

  void getToken() async {
    // Simulate some async operation to get the future boolean value
    String? role= await getRole();
    print(role);
    // Delay for 1 second before executing the navigation logic
    await Future.delayed(Duration(seconds: 1)); // 6 seconds

    // Navigate based on the boolean value
    role=="None"?null:Navigator.of(context, rootNavigator: false).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // Navigate to the SecondScreen
            return (role=="Employee"?const EngineeringScreen():const HomeScreen());
          },
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end)
                .chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              // Apply slide transition
              position: offsetAnimation,
              child: child,
            );
          },
        ),
    //     MaterialPageRoute(
      //   builder: (context) =>
      //   // const SettingsScreen(),
      //   (role=="Employee"?const EngineeringScreen():const HomeScreen()),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff155E7D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Container(
              width: 200,
              height: 200,
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  "images/rcms-logo-2.png",
                ),
              ),
              // SvgPicture.asset(
              //     height: 40,
              //     width: 40,
              //     "images/007-boy-2.svg",
              //     semanticsLabel: 'App logo'),
            ),



            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: IconButton(onPressed: (){
                getToken();
              }, icon: Icon(Icons.refresh_rounded)),
            ),
          ],
        ),
      ),
    );
  }
}