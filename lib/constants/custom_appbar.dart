import 'package:flutter/material.dart';
//
// class CustomAppBar extends StatelessWidget {
//   final Color bgColor;
//   final String title;
//   final Color titleColor;
//   final BuildContext context;
//   const CustomAppBar(this.bgColor, this.title, this.titleColor, this.context);
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: bgColor,
//       scrolledUnderElevation: 0,
//       title: Text(title, style: TextStyle(color: titleColor),),
//       centerTitle: true,
//       leading: Builder(
//         builder: (BuildContext){
//           return IconButton(onPressed: (){
//             Navigator.of(context).pop();
//           },
//             icon: Icon(Icons.arrow_back_rounded, color: titleColor,),
//           );
//         },
//       ),
//     );
//   }
// }

AppBar CustomAppBar(Color bgColor, String title, Color titleColor, BuildContext context){
  return AppBar(
    backgroundColor: bgColor,
    scrolledUnderElevation: 0,
    title: Text(title, style: TextStyle(color: titleColor),),
    centerTitle: true,
    leading: Builder(
      builder: (BuildContext){
        return IconButton(onPressed: (){
          Navigator.of(context).pop();
        },
          icon: Icon(Icons.arrow_back_rounded, color: titleColor,),
        );
      },
    ),
  );
}