import 'dart:convert';
import 'package:graduation_project/fib_create_payment/i_payment.dart';
import 'package:graduation_project/models/fib_create_payment_parameters.dart';
import 'package:graduation_project/models/fib_create_payment_response.dart';
import 'package:graduation_project/tokenManager.dart';
import 'package:http/http.dart' as http;

class Payment implements IPayment{
  late String? _token=null;
  @override
  Future<FIBCreatePaymentResponse?> paymentCreation(FIBCreatePaymentParameters fibCreatePaymentParameters) async {
    _token=await TokenManager().readToken();
    print(_token);
    try{
      http.Response response= await http.post(
          Uri.parse("https://fib.stage.fib.iq/protected/v1/payments"),
        body: jsonEncode(fibCreatePaymentParameters),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJPdjBsNEJGOVRmVDlWNTEtVjZBeTRmYlVoQ0dMbTZXUVpxcXQ4S3lLOGhnIn0.eyJleHAiOjE3MDU2Njg1MDMsImlhdCI6MTcwNTY2ODQ0MywianRpIjoiMDc0YjE4Y2MtOTc2YS00N2U5LWIyYzUtZjI4Zjg5MGU0NjY4IiwiaXNzIjoiaHR0cHM6Ly9maWIuc3RhZ2UuZmliLmlxL2F1dGgvcmVhbG1zL2ZpYi1vbmxpbmUtc2hvcCIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiIxYjkwMzRmZS1jODFmLTRmMTYtOTQ2Ny1kOTY3ZmIzNDE5Y2MiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJrb3lhLXVuaSIsInNlc3Npb25fc3RhdGUiOiI0ODFmNmRiYS1hYWZkLTRhMmUtOGZlMS0zYWE1ZWU0ZWQyNWEiLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbIioiXSwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iLCJGSUJfUEFZIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJlbWFpbCBwcm9maWxlIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJjbGllbnRJZCI6ImtveWEtdW5pIiwiY2xpZW50SG9zdCI6IjIxMi4yMzcuMTIzLjUwIiwiYWNjb3VudF9pZCI6ImIwM2ZkM2NkLTM4MmYtNDM0MC1hZDM4LTkyNDk4MDViYjU2YyIsInByZWZlcnJlZF91c2VybmFtZSI6InNlcnZpY2UtYWNjb3VudC1rb3lhLXVuaSIsImNsaWVudEFkZHJlc3MiOiIyMTIuMjM3LjEyMy41MCJ9.myD5B2THHNCvSsXc4bqGcIu2GwkPTmU8Rf-2NrIfx3oX3r1pApLmIGWrn3_9gLHiz1ShmhYqTEI8p6x6PXCFhhevRrY-tIZEoCP-0Gq90HI7dpeAPj8tnEzJdPEfYFlwX0gO0pZSv-0_9IDMULlTSewkZ8n9ugJ0b5HoSmjBLN27U3Bqm9hJiAcPxQj-LsOUvf7H2Bca4TT-wBWZKgT1OTPkiJkD7YdpY0zeptkB4dQ47sulG_444RsTkuNp1Mj7HF3yW2FYM3-7oGNmxNvomDXLFlLm1Urd26rvyqxrAanx_IbKtTk1iBzpEJZ0SS5rmc6paHKcK4sz035L-Zv2Nw',
        },
      );
      if(response.statusCode==201){
        print(response.body);
        return null;
      }else{
        print("FAILED: ${response.reasonPhrase}, ${response.statusCode}");
        return null;
      }
    }catch(e){
      print(e);
    }
  }

}