import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/apartments_response.dart';
import 'package:graduation_project/models/user_houses_and_apartments_response.dart';
import 'package:graduation_project/services/properties/properties.dart';

import '../models/houses_response.dart';
import '../models/residential_properties_response.dart';

class GetUserProperties extends ChangeNotifier{
  bool isLoading=false;
  UserHousesAndApartmentsResponse? _userHousesAndApartmentsResponse= UserHousesAndApartmentsResponse("OK", "message", ResidentialPropertiesResponse([HousesResponse(100, "name", "9"), HousesResponse(200, "name2", "2")], [ApartmentsResponse(300, "4", "ii")]));
  UserHousesAndApartmentsResponse? get userHousesAndApartmentsResponse=> _userHousesAndApartmentsResponse;
  final services= Properties();

  Future<void> getUserProperties() async{
    isLoading=true;
    notifyListeners();

    var response= await services.userHousesAndApartments();
    _userHousesAndApartmentsResponse= response;
    print(_userHousesAndApartmentsResponse?.residentialPropertiesResponse!.houses?[0].name);
    isLoading=false;
    notifyListeners();
  }
}