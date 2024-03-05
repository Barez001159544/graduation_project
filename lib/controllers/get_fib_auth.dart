import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/fib_auth_parameters.dart';
import 'package:graduation_project/models/fib_auth_response.dart';
import 'package:graduation_project/services_fib/fib_authentication/fib_auth.dart';

class GetFIBAuth extends ChangeNotifier{
  bool isLoading=false;
  FIBLoginResponse? _fibLoginResponse;
  FIBLoginResponse? get fibLoginResponse=>_fibLoginResponse;
  final services= FIBAuthentication();

  Future<void> getAuth(FIBLoginParameters fibLoginParameters) async{
    isLoading=true;
    notifyListeners();

    var response= await services.fibAuthenticate(fibLoginParameters);
    _fibLoginResponse=response;

    isLoading=false;
    notifyListeners();
  }
}