import 'package:graduation_project/models/update_user_request.dart';

import '../../models/get_self_response.dart';

abstract class IUser{
  Future<GetSelfResponse?> getSelf();
  Future<String?> updateUser(UpdateUserRequest updateUserRequest);
}