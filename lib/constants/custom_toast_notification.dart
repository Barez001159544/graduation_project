import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// class CustomToastNotification extends StatelessWidget {
//   final BuildContext context;
//   final Icon icon;
//   final String message;
//   const CustomToastNotification(this.context, this.icon, this.message);
//   @override
//   Widget build(BuildContext context) {
//     return showToastWidget(
//       Align(
//         alignment: Alignment.topCenter,
//         child: Container(
//           margin: EdgeInsets.only(top: 10),
//           padding: EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: cTheme.primaryColorLight,
//             borderRadius: BorderRadius.all(Radius.circular(15),),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               //Icon(Icons.error_outline_rounded, color: Colors.red,),
//               icon,
//               SizedBox(width: 15,),
//               Text(message),
//             ],
//           ),
//         ),
//       ),
//       duration: Duration(seconds: 5),
//       animation: StyledToastAnimation.slideFromTopFade,
//       reverseAnimation: StyledToastAnimation.slideFromTopFade,
//       context: context,
//     );
//   }
// }

ToastFuture CustomToastNotification(BuildContext context, Icon icon, String message, Color color, Color txtColor){
  return showToastWidget(
    Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,//cTheme.primaryColorLight,
          borderRadius: BorderRadius.all(Radius.circular(15),),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Icon(Icons.error_outline_rounded, color: Colors.red,),
            icon,
            SizedBox(width: 15,),
            Flexible(child: Text(message, style: TextStyle(color: txtColor,), maxLines: 2, overflow: TextOverflow.ellipsis,)),
          ],
        ),
      ),
    ),
    duration: Duration(seconds: 5),
    animation: StyledToastAnimation.slideFromTopFade,
    reverseAnimation: StyledToastAnimation.slideFromTopFade,
    context: context,
  );
}