import 'dart:convert';
import 'package:graduation_project/models/roles_response.dart';
import 'package:graduation_project/models/update_user_request.dart';
import 'package:graduation_project/models/user_details.dart';
import 'package:http/http.dart' as http;

import '../../constants/tokenManager.dart';
import '../../models/auth_response.dart';
import '../../models/get_self_response.dart';
import 'i_user.dart';

class User extends IUser{
  String? _token;

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

  @override
  Future<GetSelfResponse?> getSelf() async {
    _token=await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.get(
        Uri.parse("http://127.0.0.1:8000/api/resident/self"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $_token',
        },
      );

      if(response.statusCode==200){
        print(response.statusCode);
        print(response.body);
        GetSelfResponse getSelfResponse= GetSelfResponse.fromJson(jsonDecode(response.body));
        return getSelfResponse;
      }else{
        print(response.reasonPhrase);
        return null;
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Future<String?> updateUser(UpdateUserRequest updateUserRequest) async {
    _token= await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.put(
          Uri.parse('http://127.0.0.1:8000/api/resident/self/update'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode(updateUserRequest),
      );
      if(response.statusCode==200){
        print(response.body);
        return "Success";
      }else{
        print(response.reasonPhrase);
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Future<RolesResponse?> getRoles(String? id) async{
    _token= await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.get(
        Uri.parse("http://127.0.0.1:8000/api/roles/$id"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "authorization": "Bearer $_token"
        },
      );

      if(response.statusCode==200){
        print("8888888888888");
        print(response.statusCode);
        print(response.body);
        RolesResponse rolesResponse= RolesResponse.fromJson(jsonDecode(response.body));
        return rolesResponse;
      }else{
        print(response.reasonPhrase);
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Future<String?> logOut() async{
    _token= await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.get(
        Uri.parse('http://127.0.0.1:8000/api/logoff'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $_token',
        },
      );
      if(response.statusCode==200){
        print(response.body);
        return "Success";
      }else{
        print(response.reasonPhrase);
      }
    }catch(e){
      print(e);
    }
  }
  //
}