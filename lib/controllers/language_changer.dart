import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChanger extends ChangeNotifier{
  String selectedLanguage= "ENG";
  String krdPath= "i18n/kr/krd.json";
  String engPath= "i18n/en/eng.json";
  List data=[];
  void readJson() async {
    var prefs= await SharedPreferences.getInstance();
    selectedLanguage= prefs.getString("selectedLanguage")!=null?prefs.getString("selectedLanguage")!:"ENG";
    final String response = await rootBundle.loadString(selectedLanguage=="ENG"?engPath:krdPath);
    data = await json.decode(response)["screens"];
  }

  void changeLanguage(String lang) async {
    selectedLanguage=lang;
    var prefs= await SharedPreferences.getInstance();
    prefs.setString("selectedLanguage", lang);
    final String response = await rootBundle.loadString(selectedLanguage=="ENG"?engPath:krdPath);
    data = await json.decode(response)["screens"];
    notifyListeners();
  }
}