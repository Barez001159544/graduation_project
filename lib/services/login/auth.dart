import 'dart:convert';

import 'package:graduation_project/models/auth_response.dart';
import 'package:graduation_project/services/login/i_auth.dart';
import 'package:http/http.dart' as http;

class GetAuthentication implements IAuth{
  @override
  Future<AuthResponse?> authenticate(AuthRequest) async {
    print(AuthRequest.toJson());
    try{
      http.Response response= await http.post(
          Uri.parse("http://127.0.0.1:8000/api/login"),
        body: jsonEncode(AuthRequest.toJson()),
        headers: {
            "Accept": "application/json",
            "content-type": "application/json",
        },
      );

      if(response.statusCode==200){
        print(response.statusCode);
        print(response.body);
        AuthResponse authResponse= AuthResponse.fromJson(jsonDecode(response.body));
        return authResponse;
      }else{
        print(response.reasonPhrase);
      }
    }catch(e){
      print(e);
    }
  }
  //
}