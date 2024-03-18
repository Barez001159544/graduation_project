class ApartmentsResponse{
  // late int? id;
  // late int? floor;
  late int? electricityUnit;
  late String? name;
  // late int? buildingId;
  late String? ownerId;
  // late String? createdAt;
  // late String? updatedAt;

  ApartmentsResponse(
      // this.id,
      // this.floor,
      this.electricityUnit,
      this.name,
      // this.buildingId,
      this.ownerId,
      // this.createdAt,
      // this.updatedAt,
      );

  ApartmentsResponse.fromJson(Map<String, dynamic> json){
    // id= json['id'];
    // floor= json['floor'];
    electricityUnit= json['electricity_unit'];
    name= json['name'];
    // buildingId= json['building_id'];
    ownerId= json['owner_id'];
    // createdAt= json['created_at'];
    // updatedAt= json['updated_at'];
  }
}