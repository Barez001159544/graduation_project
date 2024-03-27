
class FullyApartmentsResponse{
  List<EachApartmentsResponse>? eachApartmentsResponse;

  FullyApartmentsResponse(
      this.eachApartmentsResponse,
      );

  factory FullyApartmentsResponse.fromJson(List<dynamic> json){
    List<EachApartmentsResponse> books=[];
    books= json.map((book) => EachApartmentsResponse.fromJson(book)).toList();
    return FullyApartmentsResponse(books);
  }
}

class EachApartmentsResponse{
  int? id;
  int? floor;
  String? name;
  int? electricityUnit;
  int? buildingId;
  String? ownerId;
  String? createdAt;
  String? updatedAt;

  EachApartmentsResponse(
      this.id,
      this.floor,
      this.name,
      this.electricityUnit,
      this.buildingId,
      this.ownerId,
      this.createdAt,
      this.updatedAt,
      );

  factory EachApartmentsResponse.fromJson(Map<String, dynamic> json){
    return EachApartmentsResponse(
      json['id'],
      json['floor'],
      json['name'],
      json['electricity_unit'],
      json['building_id'],
      json['owner_id'],
      json['created_at'],
      json['updated_at'],
    );
  }

}