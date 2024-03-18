import 'dart:convert';

import 'package:graduation_project/constants/tokenManager.dart';
import 'package:graduation_project/models/repair_request.dart';
import 'package:graduation_project/services/repairment/i_repair.dart';
import 'package:http/http.dart' as http;

class Repair extends IRepair{
  String? _token;
  @override
  Future<String?> newRepair(RepairRequest repairRequest) async{
    _token= await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.post(
        Uri.parse("http://127.0.0.1:8000/api/repairments/user"),
        headers: {
          "accept": "application/json",
          "authorization": "Bearer $_token",
        },
        body: jsonEncode(repairRequest.toJson()),
      );
      if(response.statusCode==200){
        print("ok");
      }else{
        print("not ok");
      }
    }catch(e){
      print(e);
    }
  }
}