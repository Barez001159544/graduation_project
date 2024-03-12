class HousesResponse{
  late int? id;
  late String? name;
  late int? electricityUnit;
  late int? facilityId;
  late String? ownerId;
  late String? createdAt;
  late String? updatedAt;

  HousesResponse(
      this.id,
      this.name,
      this.electricityUnit,
      this.facilityId,
      this.ownerId,
      this.createdAt,
      this.updatedAt,
      );

  HousesResponse.fromJson(Map<String, dynamic> json){
    id= json['id'];
    name= json['name'];
    electricityUnit= json['electricity_unit'];
    facilityId= json['facility_id'];
    ownerId= json['owner_id'];
    createdAt= json['created_at'];
    updatedAt= json['updated_at'];
  }
}