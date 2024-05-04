import 'dart:convert';

import 'package:graduation_project/constants/tokenManager.dart';
import 'package:graduation_project/models/repair_history_response.dart';
import 'package:graduation_project/models/repair_request.dart';
import 'package:graduation_project/services/repairment/i_repair.dart';
import 'package:http/http.dart' as http;

class Repair extends IRepair{
  String? _token;
  @override
  Future<String?> newRepair(RepairRequest repairRequest) async{
    print(repairRequest.title);
    print(repairRequest.repairmentComponents);
    print(repairRequest.description);
    print(repairRequest.type);
    print(repairRequest.propertyId);
    _token= await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.post(
        Uri.parse("http://127.0.0.1:8000/api/repairments/user"),
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
          "authorization": "Bearer $_token",
        },
        body: jsonEncode(repairRequest.toJson()),
      );
      if(response.statusCode==200){
        print("ok");
        return "OK";
      }else{
        print(response.reasonPhrase);
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Future<RepairHistoryResponse?> getAllRepair() async{
    _token= await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.get(
        Uri.parse("http://127.0.0.1:8000/api/repairments/user"),
        headers: {
          "accept": "application/json",
          "authorization": "Bearer $_token",
        },
      );
      if(response.statusCode==200){
        RepairHistoryResponse repairHistoryResponse= RepairHistoryResponse.fromJson(jsonDecode(response.body));
        return repairHistoryResponse;
      }else{
        print("not ok");
        return null;
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Future<String?> deleteRepair(int? repairId) async{
    _token= await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.delete(
        Uri.parse("http://127.0.0.1:8000/api/repairments/user/$repairId"),
        headers: {
          "accept":"application/json",
          "content-type":"application/json",
          "authorization":"Bearer $_token",
        },
      );
      if(response.statusCode==200){
        print(response.body);
        return "OK";
      }
    }catch(e){
      //
    }
  }
}