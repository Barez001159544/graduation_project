import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/models/fib_login_parameters.dart';
import 'package:graduation_project/tokenManager.dart';
import 'package:http/http.dart' as http;
import '../models/fib_login_response.dart';

class ReturnInfo{
  Future<FIBLoginResponse?> returnInfo(FIBLoginParameters loginParameters) async {
    try {
      var request = http.Request('POST', Uri.parse('https://fib.stage.fib.iq/auth/realms/fib-online-shop/protocol/openid-connect/token'));
      request.bodyFields = {
        'grant_type': loginParameters.grantType,
        'client_id': loginParameters.id,
        'client_secret': loginParameters.secret,
      };

      http.StreamedResponse response = await request.send();
      String r= await response.stream.bytesToString();
      FIBLoginResponse fibLoginResponse= FIBLoginResponse.fromJson(jsonDecode(r));
      // print(r);
      if (response.statusCode == 200) {
        TokenManager tokenManager= TokenManager();
        tokenManager.saveToken("accessToken", fibLoginResponse.accessToken);
        // print(fibLoginResponse.accessToken);
        return fibLoginResponse;
      } else {
        print("-----------");
        print(response.reasonPhrase);
        print("-----------");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}

