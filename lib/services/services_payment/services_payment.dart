import 'dart:convert';
import 'package:graduation_project/constants/tokenManager.dart';
import 'package:graduation_project/models/all_house_payments.dart';
import 'package:graduation_project/models/all_water_payments.dart';
import 'package:graduation_project/models/models_depricated/apartment_service_payments_parameters.dart';
import 'package:graduation_project/models/entire_house_fee.dart';
import 'package:graduation_project/models/house_payment_request.dart';
import 'package:graduation_project/models/this_month_payment.dart';
import 'package:graduation_project/services/services_payment/i_services_payment.dart';
import 'package:http/http.dart' as http;

class ServicesPayment extends IServicesPayment{
  String? _token;
  @override
  Future<AllHousePayments?> allHousePayments(String property, String id) async {
    _token= await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.get(
          Uri.parse("http://127.0.0.1:8000/api/payments/house-payments?property=$property&house_id=$id"),
        headers: {
            "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer $_token",
        }
      );
      if(response.statusCode==200){
        print(response.body);
        AllHousePayments allPayments = AllHousePayments.fromJson(jsonDecode(response.body));
        return allPayments;
      }else{
        print(response.reasonPhrase);
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Future<AllWaterPayments?> allWaterPayments() async{
    _token= await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.put(
          Uri.parse("http://127.0.0.1:8000/api/payments/house-fees?property=houses&house_id=1"), ///CHANGE URI
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            "Authorization": "Bearer $_token",
          }
      );
      if(response.statusCode==200){
        print(response.body);
        AllWaterPayments allPayments = AllWaterPayments.fromJson(jsonDecode(response.body));
        return allPayments;
      }else{
        print(response.reasonPhrase);
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Future<String?> payHouse(HousePaymentRequest housePaymentRequest) async{
    _token= await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.post(
          Uri.parse("http://127.0.0.1:8000/api/monthly-payments/current-month"),
          body: jsonEncode(housePaymentRequest.toJson()),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            "Authorization": "Bearer $_token",
          }
      );
      if(response.statusCode==200){
        print(">>>>>>>${response.body}");
        return "OK";
      }else{
        print("<<<<<<<<<<<${response.reasonPhrase}");
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Future<EntireHouseFee?> getEntireHouseFee() async{
    _token= await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.get(
          Uri.parse("http://127.0.0.1:8000/api/fees"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            "Authorization": "Bearer $_token",
          }
      );
      if(response.statusCode==200){
        print(response.body);
        EntireHouseFee entireHouseFee= EntireHouseFee.fromJson(jsonDecode(response.body));
        return entireHouseFee;
      }else{
        print(response.reasonPhrase);
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Future<ThisMonthPayment?> getThisMonthPayment(String property, String id) async{
    _token= await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.get(
          Uri.parse("http://127.0.0.1:8000/api/monthly-payments/current-month?property_type=$property&property_id=$id"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            "Authorization": "Bearer $_token",
          }
      );
      if(response.statusCode==200){
        print(response.body);
        ThisMonthPayment thisMonthPayment= ThisMonthPayment.fromJson(jsonDecode(response.body));
        return thisMonthPayment;
      }else{
        print(response.reasonPhrase);
      }
    }catch(e){
      print(e);
    }
  }
}