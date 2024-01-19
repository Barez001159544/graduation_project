import 'package:flutter/cupertino.dart';
import 'package:graduation_project/tokenManager.dart';
import 'package:jwt_decode/jwt_decode.dart';

class GetToken extends ChangeNotifier{
  Map<String, dynamic> _dToken={};
  Map<String, dynamic> get dToken=> _dToken;
  void readToken() async{
    // _token= await Auth().ReadToken();
    TokenManager tokenManager= TokenManager();
    _dToken = Jwt.parseJwt("${await tokenManager.readToken()}");
    print("----------");
    print(_dToken);
    print("----------");
    notifyListeners();
  }
}