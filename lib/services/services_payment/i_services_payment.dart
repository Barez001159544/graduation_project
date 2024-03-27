import 'package:graduation_project/models/all_house_payments.dart';
import 'package:graduation_project/models/apartment_service_payments_parameters.dart';

import '../../models/all_water_payments.dart';
import '../../models/entire_house_fee.dart';
import '../../models/house_payment_request.dart';
import '../../models/this_month_payment.dart';

abstract class IServicesPayment{
  Future<AllHousePayments?> allHousePayments(String property, String id);
  Future<AllWaterPayments?> allWaterPayments();
  Future<String?> payHouse(HousePaymentRequest housePaymentRequest);
  //
  Future<EntireHouseFee?> getEntireHouseFee();
  Future<ThisMonthPayment?> getThisMonthPayment(String property, String id);
}