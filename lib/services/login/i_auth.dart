import 'package:graduation_project/models/auth_request.dart';

import '../../models/auth_response.dart';

abstract class IAuth{
  Future<AuthResponse?> authenticate(AuthRequest);
}