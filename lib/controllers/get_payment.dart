import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/fib_create_payment_monetary_value.dart';
import 'package:graduation_project/models/fib_create_payment_parameters.dart';
import 'package:graduation_project/models/fib_create_payment_response.dart';

import '../models/fib_auth_parameters.dart';
import '../models/fib_auth_response.dart';
import '../models/fib_check_payment_status_response.dart';
import '../services_fib/fib_services.dart';

class GetPayment extends ChangeNotifier{
  final service= FIBServices();
  bool isLoading=false;
  FIBCreatePaymentResponse? _createPaymentResponse=null;
  FIBCreatePaymentResponse? get createPaymentResponse=> _createPaymentResponse;

  FIBLoginResponse? _fibLoginResponse;
  FIBLoginResponse? get fibLoginResponse=>_fibLoginResponse;

  Future<void> getAuth(FIBLoginParameters fibLoginParameters) async{
    isLoading=true;
    notifyListeners();

    var response= await service.fibAuthenticate(fibLoginParameters);
    _fibLoginResponse=response;

    isLoading=false;
    notifyListeners();
  }
  
  Future<void> getPaymentInformation(String token, int amount) async {
    isLoading=true;
    notifyListeners();
    
    final response= await service.fibPaymentCreation(FIBCreatePaymentParameters(
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