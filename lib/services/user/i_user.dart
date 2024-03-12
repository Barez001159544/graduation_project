import 'package:graduation_project/models/GetSelfResponse.dart';
import 'package:graduation_project/models/update_user_request.dart';

abstract class IUser{
  Future<GetSelfResponse?> getSelf();
  Future<String?> updateUser(UpdateUserRequest updateUserRequest);
}