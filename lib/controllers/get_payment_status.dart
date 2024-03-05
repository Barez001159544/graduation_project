import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/fib_check_payment_status_response.dart';

import '../services_fib/fib_payment/fib_payment.dart';

class GetPaymentStatus extends ChangeNotifier{
  final service= FIBPayment();
  bool isLoading=false;
  FIBCheckPaymentStatusResponse? _fibCheckPaymentStatusResponse;
  FIBCheckPaymentStatusResponse? get fibCheckPaymentStatusResponse=> _fibCheckPaymentStatusResponse;
  Future<void> getPaymentStatus(String paymentId)async{
    isLoading=true;
    notifyListeners();

    var response=await service.fibCheckPaymentStatus(paymentId);
    _fibCheckPaymentStatusResponse= response;
    print("+++++++++++===${_fibCheckPaymentStatusResponse?.status}");

    isLoading=false;
    notifyListeners();
  }
}