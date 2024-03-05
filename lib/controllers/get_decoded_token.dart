import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/decoded_token.dart';

import '../constants/tokenManager.dart';

class GetDecodedToken extends ChangeNotifier{
  bool isLoading=false;
  DecodedToken? _decodedToken;
  DecodedToken? get decodedToken=>_decodedToken;

  late String? _token=null;
  Future<void> getDecodedToken() async {
    isLoading=true;
    notifyListeners();

    _token=await TokenManager().readToken("accessToken");

    isLoading=false;
    notifyListeners();
  }
}