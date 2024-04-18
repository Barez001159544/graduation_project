import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/protest_all_response.dart';
import 'package:graduation_project/models/protest_request.dart';
import 'package:graduation_project/services/protest/protest.dart';

class GetProtests extends ChangeNotifier{
  bool isLoading=false;
  ProtestAllResponse?  _protestAllResponse;
  ProtestAllResponse? get protestAllResponse=>_protestAllResponse;
  final services= Protest();

  Future<void> getAllProtests() async{
    isLoading=true;
    notifyListeners();

    var response= await services.getAllProtests();
    _protestAllResponse=response;

    isLoading=false;
    notifyListeners();
  }

  String? _status;
  String? get status=>_status;
  Future<void> newProtest(ProtestRequest protestRequest) async{
    isLoading=true;
    notifyListeners();

    var response= await services.newProtest(protestRequest);
    _status =response;

    isLoading=false;
    notifyListeners();
  }

  String? _delStatus;
  String? get delStatus =>_delStatus;
  Future<void> deleteProtest(int? protestId) async{
    isLoading=true;
    notifyListeners();

    var response= await services.deleteProtest(protestId);
    _delStatus= response;

    isLoading=false;
    notifyListeners();
  }
}