import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger extends ChangeNotifier{
  bool isDark=false;

  void getDefaultTheme() async {
    var prefs= await SharedPreferences.getInstance();
    isDark= prefs.getBool("isDark")!=null?prefs.getBool("isDark")!:false;
    notifyListeners();
    print(isDark);
  }

  void changeTheme() async {
    isDark=!isDark;
    var prefs= await SharedPreferences.getInstance();
    prefs.setBool("isDark", isDark);
    notifyListeners();
  }
}