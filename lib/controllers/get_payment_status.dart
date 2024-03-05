import 'package:flutter/cupertino.dart';
import 'package:graduation_project/fib_create_payment/payment.dart';
import 'package:graduation_project/models/fib_check_payment_status_response.dart';

class GetPaymentStatus extends ChangeNotifier{
  final service= Payment();
  bool isLoading=false;
  FIBCheckPaymentStatusResponse? _fibCheckPaymentStatusResponse;
  FIBCheckPaymentStatusResponse? get fibCheckPaymentStatusResponse=> _fibCheckPaymentStatusResponse;
  Future<void> getPaymentStatus(String paymentId)async{
    isLoading=true;
    notifyListeners();

    var response=await service.checkPaymentStatus(paymentId);
    _fibCheckPaymentStatusResponse= response;
    print("+++++++++++===${_fibCheckPaymentStatusResponse?.status}");

    isLoading=false;
    notifyListeners();
  }
}