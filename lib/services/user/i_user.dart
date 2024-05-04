import 'package:graduation_project/models/roles_response.dart';
import 'package:graduation_project/models/update_user_request.dart';

import '../../models/auth_response.dart';
import '../../models/fully_houses_response.dart';
import '../../models/get_self_response.dart';

abstract class IUser{
  Future<AuthResponse?> authenticate(AuthRequest);
  Future<GetSelfResponse?> getSelf();
  Future<String?> updateUser(UpdateUserRequest updateUserRequest);
  Future<RolesResponse?> getRoles(String? email);
  Future<String?> logOut();
}