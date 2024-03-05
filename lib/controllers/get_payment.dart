import 'package:flutter/cupertino.dart';
import 'package:graduation_project/fib_create_payment/payment.dart';
import 'package:graduation_project/models/fib_create_payment_monetary_value.dart';
import 'package:graduation_project/models/fib_create_payment_parameters.dart';
import 'package:graduation_project/models/fib_create_payment_response.dart';

class GetPayment extends ChangeNotifier{
  final service= Payment();
  bool isLoading=false;
  FIBCreatePaymentResponse? _createPaymentResponse=null;
  FIBCreatePaymentResponse? get createPaymentResponse=> _createPaymentResponse;
  
  Future<void> getPaymentInformation(String token, String amount) async {
    isLoading=true;
    notifyListeners();
    
    final response= await service.paymentCreation(FIBCreatePaymentParameters(
        MonetaryValue(amount, "IQD"),
        "https://URL_TO_UPDATE_YOUR_PAYMENT_STATUS",
        "Lorem ipsum dolor sit amet.",
        "PT8H6M12.345S"), token);
    _createPaymentResponse= response;
    print("------------");
    print(_createPaymentResponse?.qrCode);
    print("------------");
    isLoading=false;
    notifyListeners();
  }
}