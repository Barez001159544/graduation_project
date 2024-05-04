import 'dart:convert';

import 'package:graduation_project/models/accept_repairment_request.dart';
import 'package:graduation_project/models/repair_history_response.dart';
import 'package:graduation_project/services/engineering/i_engineering.dart';
import '../../constants/tokenManager.dart';
import 'package:http/http.dart' as http;

class Engineering extends IEngineering{
  String? _token;
  @override
  Future<RepairHistoryResponse?> getAllRepair() async{
    _token= await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.get(
        Uri.parse("http://127.0.0.1:8000/api/repairments/employee"),
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
  Future<String?> acceptRepairment(int? id, AcceptRepairmentRequest acceptRepairmentRequest) async{
    _token= await TokenManager().readToken("accessToken");
    print(id);
    print(acceptRepairmentRequest.status);
    try{
      http.Response response= await http.put(
        Uri.parse("http://127.0.0.1:8000/api/repairments/employee/$id"),
        body: jsonEncode(acceptRepairmentRequest.toJson()),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "authorization": "Bearer $_token",
        },
      );
      if(response.statusCode==200){
        return "OK";
      }else{
        print(response.reasonPhrase);
        print("not ok");
      }
    }catch(e){
      print(e);
    }
  }
}