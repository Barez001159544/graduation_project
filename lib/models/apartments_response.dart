class ApartmentsResponse{
  late int? id;
  late int? floor;
  late String? name;
  late int? electricityUnit;
  late int? buildingId;
  late String? ownerId;
  late String? createdAt;
  late String? updatedAt;

  ApartmentsResponse(
      this.id,
      this.floor,
      this.name,
      this.electricityUnit,
      this.buildingId,
      this.ownerId,
      this.createdAt,
      this.updatedAt,
      );

  ApartmentsResponse.fromJson(Map<String, dynamic> json){
    id= json['id'];
    floor= json['floor'];
    name= json['name'];
    electricityUnit= json['electricity_unit'];
    buildingId= json['building_id'];
    ownerId= json['owner_id'];
    createdAt= json['created_at'];
    updatedAt= json['updated_at'];
  }
}