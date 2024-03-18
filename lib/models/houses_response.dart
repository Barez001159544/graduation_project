class HousesResponse{
  // late int? id;
  late int? electricityUnit;
  late String? name;
  // late int? facilityId;
  late String? ownerId;
  // late String? createdAt;
  // late String? updatedAt;

  HousesResponse(
      // this.id,
      this.electricityUnit,
      this.name,
      // this.facilityId,
      this.ownerId,
      // this.createdAt,
      // this.updatedAt,
      );

  HousesResponse.fromJson(Map<String, dynamic> json){
    // id= json['id'];
    electricityUnit= json['electricity_unit'];
    name= json['house_name'];
    // facilityId= json['facility_id'];
    ownerId= json['owner'];
    // createdAt= json['created_at'];
    // updatedAt= json['updated_at'];
  }
}