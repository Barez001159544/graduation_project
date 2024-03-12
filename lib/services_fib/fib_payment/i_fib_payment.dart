import 'package:graduation_project/models/fib_create_payment_parameters.dart';
import '../../models/fib_check_payment_status_response.dart';
import '../../models/fib_create_payment_response.dart';

abstract class IFIBPayment{
  Future<FIBCreatePaymentResponse?> fibPaymentCreation(FIBCreatePaymentParameters fibCreatePaymentParameters, String token);
  Future<FIBCheckPaymentStatusResponse?> fibCheckPaymentStatus(String paymentId, String token);
}