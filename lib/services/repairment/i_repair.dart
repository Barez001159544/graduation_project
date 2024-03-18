import 'package:graduation_project/models/repair_request.dart';

abstract class IRepair{
  Future<String?> newRepair(RepairRequest repairRequest);
}