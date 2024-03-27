import 'package:graduation_project/models/repair_request.dart';

import '../../models/repair_history_response.dart';

abstract class IRepair{
  Future<String?> newRepair(RepairRequest repairRequest);
  Future<RepairHistoryResponse?> getAllRepair();
}