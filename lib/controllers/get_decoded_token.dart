// import 'package:flutter/cupertino.dart';
// import 'package:graduation_project/models/user_details.dart';
//
// import '../constants/tokenManager.dart';
//
// class GetDecodedToken extends ChangeNotifier{
//   bool isLoading=false;
//   UserDetails? _decodedToken;
//   UserDetails? get decodedToken=>_decodedToken;
//
//   late String? _token=null;
//   Future<void> getDecodedToken() async {
//     isLoading=true;
//     notifyListeners();
//
//     _token=await TokenManager().readToken("accessToken");
//
//     isLoading=false;
//     notifyListeners();
//   }
// }