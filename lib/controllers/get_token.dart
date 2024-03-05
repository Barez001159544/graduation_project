import 'package:flutter/cupertino.dart';
import 'package:graduation_project/constants/tokenManager.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../models/fib_auth_parameters.dart';

class GetToken extends ChangeNotifier{

  TokenManager tokenManager= TokenManager();

  late String? _dToken;
  String? get dToken=> _dToken;
  bool isLoading=false;

  Future<void> readToken(String tokenKey) async{
    isLoading=true;
    notifyListeners();

    _dToken = await tokenManager.readToken(tokenKey);
    isLoading=false;
    notifyListeners();
  }

  Future<void> writeToken(String tokenKey, String token) async{
    isLoading=true;
    notifyListeners();

    await tokenManager.saveToken(tokenKey, token);
    isLoading=false;
    notifyListeners();
  }

  Future<void> deleteToken(String tokenKey) async{
    isLoading=true;
    notifyListeners();

    await tokenManager.deleteToken(tokenKey);
    isLoading=false;
    notifyListeners();
  }
}