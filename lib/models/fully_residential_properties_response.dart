import 'fully_aparments_reponse.dart';
import 'fully_houses_response.dart';

class FullyResidentialPropertiesResponse{
  List<FullyHousesResponse>? houses;
  List<FullyApartmentsResponse>? apartments;

  FullyResidentialPropertiesResponse(
      this.houses,
      this.apartments,
      );

  FullyResidentialPropertiesResponse.fromJson(Map<String, dynamic> json){
    houses= List<FullyHousesResponse>.from(json['houses'].map((model)=>FullyHousesResponse.fromJson(model)));
    apartments= List<FullyApartmentsResponse>.from(json['apartments'].map((model)=>FullyApartmentsResponse.fromJson(model)));
  }
}