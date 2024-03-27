import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/repair_history_response.dart';
import 'package:graduation_project/models/repair_request.dart';
import 'package:graduation_project/services/repairment/repair.dart';

class GetRepairment extends ChangeNotifier{
  bool isLoading=false;
  String? _status;
  String? get status=> _status;
  final services= Repair();

  Future<void> newRepair(RepairRequest repairRequest) async{
    isLoading=true;
    notifyListeners();

    var response= await services.newRepair(repairRequest);
    _status=response;

    isLoading=false;
    notifyListeners();
  }

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
}