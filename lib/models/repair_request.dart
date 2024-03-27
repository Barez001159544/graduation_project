class RepairRequest{
  String? title;
  String? repairmentComponents;
  String? description;
  String? type;
  int? propertyId;

  RepairRequest(
      this.title,
      this.repairmentComponents,
      this.description,
      this.type,
      this.propertyId,
      );

  Map<String, dynamic> toJson()=>{
    'title': title,
    'repairment_components': repairmentComponents,
    'description': description,
    "type": type,
    "property_id": propertyId,
  };

  RepairRequest.fromJson(Map<String, dynamic> json){
    //
  }
}