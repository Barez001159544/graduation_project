class ApartmentsResponse{
  // late int? id;
  // late int? floor;
  late int? electricityUnit;
  late String? name;
  // late int? buildingId;
  late String? ownerId;
  late String? buildingName;
  late int? floor;

  ApartmentsResponse(
      // this.id,
      // this.floor,
      this.electricityUnit,
      this.name,
      // this.buildingId,
      this.ownerId,
      this.buildingName,
      this.floor,
      );

  ApartmentsResponse.fromJson(Map<String, dynamic> json){
    // id= json['id'];
    // floor= json['floor'];
    electricityUnit= json['electricity_unit'];
    name= json['house_name'];
    // buildingId= json['building_id'];
    ownerId= json['owner'];
    buildingName= json['building_name'];
    floor= json['floor'];
  }
}