import 'package:flutter/foundation.dart';
import 'package:graduation_project/models/all_house_payments.dart';
import 'package:graduation_project/models/all_water_payments.dart';
import 'package:graduation_project/models/entire_house_fee.dart';
import 'package:graduation_project/models/house_payment_request.dart';
import 'package:graduation_project/models/this_month_payment.dart';
import 'package:graduation_project/services/services_payment/services_payment.dart';

class GetUserPayments extends ChangeNotifier{
  bool isLoading=false;
  final services= ServicesPayment();

  AllHousePayments? _allHousePayments;
  AllHousePayments? get allHousePayments=> _allHousePayments;
  Future<void> getAllHousePayments(String property, String id) async{
    isLoading=true;
    notifyListeners();

    var response= await services.allHousePayments(property, id);
    _allHousePayments=response;

    isLoading=false;
    notifyListeners();
  }

  AllWaterPayments? _allWaterPayments;
  AllWaterPayments? get allWaterPayments=> _allWaterPayments;
  Future<void> getAllWaterPayments() async{
    isLoading=true;
    notifyListeners();

    var response= await services.allWaterPayments();
    _allWaterPayments=response;

    isLoading=false;
    notifyListeners();
  }

  String? _status;
  String? get status=> _status;
  Future<void> payHouse(HousePaymentRequest housePaymentRequest) async{
    isLoading=true;
    notifyListeners();

    var response= await services.payHouse(housePaymentRequest);
    _status= response;

    isLoading=false;
    notifyListeners();
  }

  EntireHouseFee? _entireHouseFee;
  EntireHouseFee? get entireHouseFee=> _entireHouseFee;
  Future<void> getEntireHouseFee() async{
    isLoading=true;
    notifyListeners();

    var response= await services.getEntireHouseFee();
    _entireHouseFee= response;

    isLoading=false;
    notifyListeners();
  }

  ThisMonthPayment? _thisMonthPayment;
  ThisMonthPayment? get thisMonthPayment=> _thisMonthPayment;
  Future<void> getThisMonthPayment(String property, String id) async{
    isLoading=true;
    notifyListeners();

    var response= await services.getThisMonthPayment(property, id);
    _thisMonthPayment= response;

    isLoading=false;
    notifyListeners();
  }

  ThisMonthPayment? _thisMonthPaymentHistory;
  ThisMonthPayment? get thisMonthPaymentHistory=> _thisMonthPaymentHistory;
  Future<void> getThisMonthPaymentHistory(String property, String id) async{
    isLoading=true;
    notifyListeners();

    var response= await services.getThisMonthPayment(property, id);
    _thisMonthPaymentHistory= response;

    isLoading=false;
    notifyListeners();
  }
}