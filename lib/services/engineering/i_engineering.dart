import 'package:graduation_project/models/accept_repairment_request.dart';

import '../../models/repair_history_response.dart';

abstract class IEngineering{
  Future<RepairHistoryResponse?> getAllRepair();
  Future<String?> acceptRepairment(int? id, AcceptRepairmentRequest acceptRepairmentRequest);
}