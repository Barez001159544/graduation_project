import 'package:graduation_project/models/residential_properties_response.dart';

import 'apartments_response.dart';
import 'houses_response.dart';

class UserHousesAndApartmentsResponse{
  String? status;
  String? message;
  ResidentialPropertiesResponse? residentialPropertiesResponse;

  UserHousesAndApartmentsResponse(
      this.status,
      this.message,
      this.residentialPropertiesResponse,
      );

  UserHousesAndApartmentsResponse.fromJson(Map<String, dynamic> json){
    status= json['status'];
    message= json['message'];
    residentialPropertiesResponse= ResidentialPropertiesResponse.fromJson(json['residential_properties']);
  }
}