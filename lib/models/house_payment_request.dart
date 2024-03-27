class HousePaymentRequest{
  String? propertyType;
  int? propertyId;

  HousePaymentRequest(
      this.propertyType,
      this.propertyId,
      );

  Map<String, dynamic> toJson()=>{
    "property_type": propertyType,
    "property_id": propertyId,
  };
}