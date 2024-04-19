import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/accept_repairment_request.dart';
import 'package:graduation_project/services/engineering/engineering.dart';

import '../models/repair_history_response.dart';
import '../services/repairment/repair.dart';

class GetEngineering extends ChangeNotifier{
  bool isLoading=false;
  final services= Engineering();
  RepairHistoryResponse? _repairHistoryResponse;
  RepairHistoryResponse? get repairHistoryResponse=> _repairHistoryResponse;

  Future<void> getAllRepair() async{
    isLoading=true;
    notifyListeners();

    var response= await services.getAllRepair();
    _repairHistoryResponse= response;

    isLoading=false;
    notifyListeners();
  }

  Future<void> customGetAllRepair() async{
    var response= await services.getAllRepair();
    _repairHistoryResponse= response;

    notifyListeners();
  }

  String? _status;
  String? get status=>_status;
  bool acceptLoading=false;

  Future<void> acceptRepairment(AcceptRepairmentRequest) async{
    acceptLoading=true;
    notifyListeners();

    var response= await services.acceptRepairment(AcceptRepairmentRequest);
    _status= response;

    acceptLoading=false;
    notifyListeners();
  }
}