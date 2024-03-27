
class FullyHousesResponse{
  List<EachHouseResponse>? eachHouseResponse;

  FullyHousesResponse(
      this.eachHouseResponse,
      );

  factory FullyHousesResponse.fromJson(List<dynamic> json){
    List<EachHouseResponse> books=[];
    books= json.map((book) => EachHouseResponse.fromJson(book)).toList();
    return FullyHousesResponse(books);
  }
}

class EachHouseResponse{
  int? id;
  String? name;
  int? electricityUnit;
  int? facilityId;
  String? ownerId;
  String? createdAt;
  String? updatedAt;

  EachHouseResponse(
      this.id,
      this.name,
      this.electricityUnit,
      this.facilityId,
      this.ownerId,
      this.createdAt,
      this.updatedAt,
      );

  factory EachHouseResponse.fromJson(Map<String, dynamic> json){
    return EachHouseResponse(
        json['id'],
      json['name'],
        json['electricity_unit'],
    json['facility_id'],
    json['owner_id'],
    json['created_at'],
    json['updated_at'],
    );
  }

}