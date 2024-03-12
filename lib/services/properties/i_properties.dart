import '../../models/user_houses_and_apartments_response.dart';

abstract class IProperties{
  Future<UserHousesAndApartmentsResponse?> userHousesAndApartments();
}