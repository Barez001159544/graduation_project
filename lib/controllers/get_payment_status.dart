import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/fib_check_payment_status_response.dart';

import '../services_fib/fib_services.dart';

class GetPaymentStatus extends ChangeNotifier{
  final service= FIBServices();
  bool isLoading=false;
  FIBCheckPaymentStatusResponse? _fibCheckPaymentStatusResponse;
  FIBCheckPaymentStatusResponse? get fibCheckPaymentStatusResponse=> _fibCheckPaymentStatusResponse;
  Future<void> getPaymentStatus(String paymentId, String token)async{
    isLoading=true;
    notifyListeners();

    var response=await service.fibCheckPaymentStatus(paymentId, token);
    _fibCheckPaymentStatusResponse= response;
    print("+++++++++++===${_fibCheckPaymentStatusResponse?.status}");

    isLoading=false;
    notifyListeners();
  }
}