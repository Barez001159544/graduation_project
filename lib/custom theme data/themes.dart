import 'package:flutter/material.dart';

// Light theme data
final ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xff155E7D),
  primaryColorLight: Colors.white,
  primaryColorDark: Colors.black,
  backgroundColor: Color(0xffE7E7E7),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
  ),
  // colorScheme: lightThemeColors(),
  textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.blueGrey,
  ),
  fontFamily: "NotoSans",
);

ColorScheme lightThemeColors() {
  return ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF202020),
    onPrimary: Color(0xFF505050),
    secondary: Color(0xFFBBBBBB),
    onSecondary: Color(0xFFEAEAEA),
    error: Color(0xFFF32424),
    onError: Color(0xFFF32424),
    background: Color(0xFFF1F2F3),
    onBackground: Color(0xFFFFFFFF),
    surface: Color(0xFF54B435),
    onSurface: Color(0xFF54B435),
  );
}

// Dark theme data
final ThemeData darkTheme = ThemeData(
  primaryColor: Color(0xff155E7D),
  primaryColorLight: Color(0xff1F1F1F),
  primaryColorDark: Colors.white,
  backgroundColor: Color(0xff292929),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
  ),
  fontFamily: "NotoSans",
  scaffoldBackgroundColor: Color(0xff1F1F1F),
);

