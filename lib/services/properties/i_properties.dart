import 'package:graduation_project/models/fully_aparments_reponse.dart';

import '../../models/fully_houses_response.dart';
import '../../models/user_houses_and_apartments_response.dart';

abstract class IProperties{
  Future<UserHousesAndApartmentsResponse?> userHousesAndApartments();
  // Future<String?> getAllProperties();
  Future<FullyHousesResponse?> getAllHouses();
  Future<FullyApartmentsResponse?> getAllApartments();
}