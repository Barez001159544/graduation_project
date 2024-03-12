import 'dart:convert';

import 'package:graduation_project/constants/tokenManager.dart';
import 'package:graduation_project/models/user_houses_and_apartments_response.dart';
import 'package:graduation_project/services/properties/i_properties.dart';
import 'package:http/http.dart' as http;

class Properties extends IProperties{
  String? _token;
  @override
  Future<UserHousesAndApartmentsResponse?> userHousesAndApartments() async{
    _token = await TokenManager().readToken("accessToken");
    try{
      http.Response response= await http.get(
          Uri.parse("http://127.0.0.1:8000/api/residents/self/residential-property"),
        headers: {
            "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $_token',
        }
      );
      if(response.statusCode==200){
        // print(response.body);
        UserHousesAndApartmentsResponse userHousesAndApartmentsResponse= UserHousesAndApartmentsResponse.fromJson(jsonDecode(response.body));
        return userHousesAndApartmentsResponse;
      }else{
        print(response.reasonPhrase);
        return null;
      }
    }catch(e){
      print(e);
    }
  }
}