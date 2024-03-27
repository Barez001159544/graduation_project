import 'dart:convert';

import 'package:graduation_project/constants/tokenManager.dart';
import 'package:graduation_project/models/protest_all_response.dart';
import 'package:graduation_project/models/protest_request.dart';
import 'package:graduation_project/services/protest/i_protest.dart';
import 'package:http/http.dart' as http;

class Protest extends IProtest{
  String? _token;
  @override
  Future<ProtestAllResponse?> getAllProtests() async {
    _token = await TokenManager().readToken("accessToken");
    try{
      http.Response response = await http.get(
          Uri.parse("http://127.0.0.1:8000/api/protests/user"),
        headers: {
            "accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer $_token",
        }
      );
      if(response.statusCode==200){
        print(response.body);
        ProtestAllResponse protestAllResponse= ProtestAllResponse.fromJson(jsonDecode(response.body));
        return protestAllResponse;
      }else{
        print(response.reasonPhrase);
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Future<String?> newProtest(ProtestRequest protestRequest) async {
    _token = await TokenManager().readToken("accessToken");
    try{
      http.Response response = await http.post(
          Uri.parse("http://127.0.0.1:8000/api/protests/user"),
          headers: {
            "accept": "application/json",
            "content-type": "application/json",
            "Authorization": "Bearer $_token",
          },
          body: jsonEncode(protestRequest.toJson()),
      );
      if(response.statusCode==200){
        print(response.body);
        return "OK";
      }else{
        print(response.reasonPhrase);
        print(response.body);
      }
    }catch(e){
      print(e);
      print("JJJJ");
    }
  }
}