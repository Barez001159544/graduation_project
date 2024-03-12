import 'dart:convert';

import 'package:graduation_project/models/user_details.dart';

class GetSelfResponse{
  UserDetails? userDetails;
  String? status;
  String? message;

  GetSelfResponse(this.userDetails, this.status, this.message);

  GetSelfResponse.fromJson(Map<String, dynamic> json){
    userDetails= UserDetails.fromJson(json["user"]);
    status= json['status'];
    message= json['message'];
  }
}