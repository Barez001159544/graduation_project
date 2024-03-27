import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/apartments_response.dart';
import 'package:graduation_project/models/fully_aparments_reponse.dart';
import 'package:graduation_project/models/fully_houses_response.dart';
import 'package:graduation_project/models/user_houses_and_apartments_response.dart';
import 'package:graduation_project/services/properties/properties.dart';

import '../models/houses_response.dart';
import '../models/residential_properties_response.dart';

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

  FullyHousesResponse? _fullyHousesResponse;
  FullyHousesResponse? get fullyHousesResponse=>_fullyHousesResponse;
  Future<void> getAllHouses() async{
    isLoading=true;
    notifyListeners();

    var response= await services.getAllHouses();
    _fullyHousesResponse= response;

    isLoading=false;
    notifyListeners();
  }

  FullyApartmentsResponse? _fullyApartmentsResponse;
  FullyApartmentsResponse? get fullyApartmentsResponse=>_fullyApartmentsResponse;
  Future<void> getAllApartments() async{
    isLoading=true;
    notifyListeners();

    var response= await services.getAllApartments();
    _fullyApartmentsResponse= response;

    isLoading=false;
    notifyListeners();
  }

  EachHouseResponse? _oneHouseResponse;
  EachHouseResponse? get oneHouseResponse=>_oneHouseResponse;
  void getOneHouse(EachHouseResponse eachHouseResponse) {
    isLoading=true;
    notifyListeners();

    _oneHouseResponse= eachHouseResponse;

    isLoading=false;
    notifyListeners();
  }

  EachApartmentsResponse? _oneApartmentResponse;
  EachApartmentsResponse? get oneApartmentResponse=> _oneApartmentResponse;
  void getOneApartment(EachApartmentsResponse eachApartmentsResponse) {
    isLoading=true;
    notifyListeners();

    _oneApartmentResponse= eachApartmentsResponse;

    isLoading=false;
    notifyListeners();
  }

  void emptyOneHouse(){
    _oneHouseResponse=null;
  }

  void emptyOneApartment(){
    _oneApartmentResponse=null;
  }
}