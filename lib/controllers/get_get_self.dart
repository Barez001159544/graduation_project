import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/roles_response.dart';
import 'package:graduation_project/services/user/user.dart';

import '../models/auth_request.dart';
import '../models/auth_response.dart';
import '../models/get_self_response.dart';
import '../models/update_user_request.dart';

class GetGetSelf extends ChangeNotifier{
  bool isLoading=false;
  GetSelfResponse? _getSelfResponse;
  GetSelfResponse? get getSelfResponse=> _getSelfResponse;

  AuthResponse? _data;
  AuthResponse? get data=>_data;

  final services= User();

  Future<void> authwemailpass(AuthRequest authRequest) async {
    isLoading=true;
    notifyListeners();

    var response= await services.authenticate(authRequest);
    _data= response;

    isLoading=false;
    notifyListeners();
  }


  Future<void> getGetSelf() async {
    isLoading=true;
    notifyListeners();

    var response= await services.getSelf();
    _getSelfResponse= response;


    isLoading=false;
    notifyListeners();
  }

  String? _updateStatus;
  String? get updateStatus=> _updateStatus;

  Future<void> getUpdateUser(UpdateUserRequest updateUserRequest) async {
    isLoading=true;
    notifyListeners();

    var response= await services.updateUser(updateUserRequest);
    _updateStatus=response;
  }

  RolesResponse? _rolesResponse;
  RolesResponse? get rolesResponse=> _rolesResponse;

  Future<void> getUserRoles(String? email) async {
    isLoading=true;
    notifyListeners();

    var response= await services.getRoles(email);
    _rolesResponse=response;

    isLoading=false;
    notifyListeners();
  }

  String? _logOutStatus;
  String? get logOutStatus=> _logOutStatus;
  bool logOutLoading= false;

  Future<void> getLogoff() async {
    logOutLoading=true;
    notifyListeners();

    var response= await services.logOut();
    _logOutStatus=response;

    logOutLoading=false;
    notifyListeners();
  }
}