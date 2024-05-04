class HousePaymentRequest{
  String? propertyType;
  int? propertyId;
  int? selectedPaymentId;

  HousePaymentRequest(
      this.propertyType,
      this.propertyId,
      this.selectedPaymentId,
      );

  Map<String, dynamic> toJson()=>{
    "property_type": propertyType,
    "property_id": propertyId,
    "monthly_payment": selectedPaymentId,
  };
}