import 'package:flutter/cupertino.dart';
import 'package:graduation_project/tokenManager.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../models/fib_login_parameters.dart';

class GetToken extends ChangeNotifier{

  late String _dToken;
  String get dToken=> _dToken;
  bool isLoading=false;

  void readToken() async{
    isLoading=true;
    notifyListeners();

    TokenManager tokenManager= TokenManager();
    _dToken = (await tokenManager.readToken())!;
    print(_dToken);
    isLoading=false;
    notifyListeners();
  }
}