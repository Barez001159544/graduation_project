import 'dart:convert';
import 'package:graduation_project/constants/tokenManager.dart';
import 'package:graduation_project/models/apartment_service_payments_parameters.dart';
import 'package:graduation_project/services/services_payment/i_services_payment.dart';
import 'package:http/http.dart' as http;

class ServicesPayment extends IServicesPayment{
  String? _token;
  @override
  Future<String?> getServicesPayment(ApartmentServicePaymentsParameters apartmentServicePaymentsParameters) async {
    _token= await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.put(
          Uri.parse("URI_HERE"),
        body: jsonEncode(apartmentServicePaymentsParameters.toJson()),
        headers: {
            "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer $_token",
        }
      );
      if(response.statusCode==200){
        print(response.body);
        return "A+";
      }else{
        print(response.reasonPhrase);
        return "F-";
      }
    }catch(e){
      print(e);
    }
  }
}