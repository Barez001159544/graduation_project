import 'package:graduation_project/models/protest_request.dart';

import '../../models/protest_all_response.dart';

abstract class IProtest{
  Future<ProtestAllResponse?> getAllProtests();
  Future<String?> newProtest(ProtestRequest protestRequest);
}