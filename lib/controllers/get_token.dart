import 'package:flutter/cupertino.dart';
import 'package:graduation_project/tokenManager.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../models/fib_login_parameters.dart';

class GetToken extends ChangeNotifier{

  TokenManager tokenManager= TokenManager();

  late String _dToken;
  String get dToken=> _dToken;
  bool isLoading=false;

  void readToken(String tokenKey) async{
    isLoading=true;
    notifyListeners();

    _dToken = (await tokenManager.readToken(tokenKey))!;
    isLoading=false;
    notifyListeners();
  }

  void writeToken(String tokenKey) async{
    isLoading=true;
    notifyListeners();

    await tokenManager.saveToken(tokenKey, "token value here");
    isLoading=false;
    notifyListeners();
  }

  void deleteToken(String tokenKey) async{
    isLoading=true;
    notifyListeners();

    await tokenManager.deleteToken(tokenKey);
    isLoading=false;
    notifyListeners();
  }
}