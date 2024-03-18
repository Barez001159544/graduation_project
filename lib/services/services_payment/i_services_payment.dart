import 'package:graduation_project/models/apartment_service_payments_parameters.dart';

abstract class IServicesPayment{
  Future<String?> getServicesPayment(ApartmentServicePaymentsParameters apartmentServicePaymentsParameters);
}