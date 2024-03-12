import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/GetSelfResponse.dart';
import 'package:graduation_project/services/user/user.dart';

class GetGetSelf extends ChangeNotifier{
  bool isLoading=false;
  GetSelfResponse? _getSelfResponse;
  GetSelfResponse? get getSelfResponse=> _getSelfResponse;

  final services= User();

  Future<void> getGetSelf() async {
    isLoading=true;
    notifyListeners();

    var response= await services.getSelf();
    _getSelfResponse= response;


    isLoading=false;
    notifyListeners();
  }
}