import '../../models/fib_auth_parameters.dart';
import '../../models/fib_auth_response.dart';

abstract class IFIBAuth{
  Future<FIBLoginResponse?> fibAuthenticate(FIBLoginParameters loginParameters);
}