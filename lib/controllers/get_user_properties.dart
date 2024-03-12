import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/user_houses_and_apartments_response.dart';
import 'package:graduation_project/services/properties/properties.dart';

class GetUserProperties extends ChangeNotifier{
  bool isLoading=false;
  UserHousesAndApartmentsResponse? _userHousesAndApartmentsResponse;
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