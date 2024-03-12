import 'apartments_response.dart';
import 'houses_response.dart';

class ResidentialPropertiesResponse{
  List<HousesResponse>? houses;
  List<ApartmentsResponse>? apartments;

  ResidentialPropertiesResponse(
      this.houses,
      this.apartments,
      );

  ResidentialPropertiesResponse.fromJson(Map<String, dynamic> json){
    houses= List<HousesResponse>.from(json['houses'].map((model)=>HousesResponse.fromJson(model)));
    apartments= List<ApartmentsResponse>.from(json['apartments'].map((model)=>ApartmentsResponse.fromJson(model)));
  }
}