import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/update_user_request.dart';
import 'package:graduation_project/services/user/user.dart';

class GetUpdateUserController extends ChangeNotifier{
  bool isLoading=false;
  String? _updateStatus;
  String? get updateStatus=> _updateStatus;
  final services= User();

  Future<void> getUpdateUser(UpdateUserRequest updateUserRequest) async {
    isLoading=true;
    notifyListeners();

    var response= await services.updateUser(updateUserRequest);
    _updateStatus=response;
  }
}