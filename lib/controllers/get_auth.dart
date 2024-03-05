import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/auth_request.dart';
import 'package:graduation_project/models/auth_response.dart';
import 'package:graduation_project/services/login/auth.dart';

class GetAuth extends ChangeNotifier{
  bool isLoading=false;
  AuthResponse? _data;
  AuthResponse? get data=>_data;

  final services= GetAuthentication();

  Future<void> authwemailpass(AuthRequest authRequest) async {
    isLoading=true;
    notifyListeners();

    var response= await services.authenticate(authRequest);
    _data= response;

    isLoading=false;
    notifyListeners();
  }
}