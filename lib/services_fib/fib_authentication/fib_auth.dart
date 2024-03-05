import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/models/fib_auth_parameters.dart';
import 'package:graduation_project/services_fib/fib_authentication/i_fib_auth.dart';
import 'package:graduation_project/constants/tokenManager.dart';
import 'package:http/http.dart' as http;
import '../../models/fib_auth_response.dart';

class FIBAuthentication extends IFIBAuth{
  @override
  Future<FIBLoginResponse?> fibAuthenticate(FIBLoginParameters fibLoginParameters) async {
    try {
      var request = http.Request('POST', Uri.parse('https://fib.stage.fib.iq/auth/realms/fib-online-shop/protocol/openid-connect/token'));
      request.bodyFields = {
        'grant_type': fibLoginParameters.grantType,
        'client_id': fibLoginParameters.id,
        'client_secret': fibLoginParameters.secret,
      };

      http.StreamedResponse response = await request.send();
      String r= await response.stream.bytesToString();
      FIBLoginResponse fibLoginResponse= FIBLoginResponse.fromJson(jsonDecode(r));
      print(r);
      if (response.statusCode == 200) {
        // print("+++++++++++++");
        // print(loginParameters.secret);
        // TokenManager tokenManager = TokenManager();
        // await tokenManager.saveToken("${loginParameters.toMap()}");
        // print("+++++++++++++");
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

