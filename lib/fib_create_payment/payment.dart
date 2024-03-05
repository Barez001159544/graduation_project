import 'dart:convert';
import 'package:graduation_project/fib_create_payment/i_payment.dart';
import 'package:graduation_project/models/fib_check_payment_status_response.dart';
import 'package:graduation_project/models/fib_create_payment_parameters.dart';
import 'package:graduation_project/models/fib_create_payment_response.dart';
import 'package:graduation_project/tokenManager.dart';
import 'package:http/http.dart' as http;

class Payment implements IPayment{
  // late String? _token=null;
  @override
  Future<FIBCreatePaymentResponse?> paymentCreation(FIBCreatePaymentParameters fibCreatePaymentParameters, String token) async {
    // _token=await TokenManager().readToken();
    // print(_token);
    try{
      http.Response response= await http.post(
          Uri.parse("https://fib.stage.fib.iq/protected/v1/payments"),
        body: jsonEncode(fibCreatePaymentParameters),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode==201){
        // print(response.body);
        FIBCreatePaymentResponse fibCreatePaymentResponse= FIBCreatePaymentResponse.fromJson(jsonDecode(response.body));
        return fibCreatePaymentResponse;
      }else{
        print("FAILED: ${response.reasonPhrase}, ${response.statusCode}");
        return null;
      }
    }catch(e){
      print(e);
    }
  }

  String? _token;
  @override
  Future<FIBCheckPaymentStatusResponse?> checkPaymentStatus(String paymentId) async {
    _token=await TokenManager().readToken("FIBToken");
    print(_token==null?"UNFORTUNETLY":"GREAT WORK");
    try{
      http.Response response= await http.get(
          Uri.parse('https://fib.stage.fib.iq/protected/v1/payments/$paymentId/status'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );
      if(response.statusCode==200){
        print("${response.body} OKKK");
        FIBCheckPaymentStatusResponse fibCheckPaymentStatusResponse= FIBCheckPaymentStatusResponse.fromJson(jsonDecode(response.body));
        return fibCheckPaymentStatusResponse;
      }else{
        print("${response.body} NOT OK");
        return null;
      }
    }catch(e){
      print(e);
    }
  }

}