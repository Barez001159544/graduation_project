class FIBCreatePaymentResponse{
  late String paymentId;
  late String readableCode;
  late String qrCode;
  late String validUntil;
  late String personalAppLink;
  late String businessAppLink;
  late String corporateAppLink;

  FIBCreatePaymentResponse(
      this.paymentId,
      this.readableCode,
      this.qrCode,
      this.validUntil,
      this.personalAppLink,
      this.businessAppLink,
      this.corporateAppLink,
      );
  FIBCreatePaymentResponse.fromJson(Map<String, dynamic> json){
    paymentId= json["paymentId"];
    readableCode= json["readableCode"];
    qrCode= json["qrCode"];
    validUntil= json["validUntil"];
    personalAppLink= json["personalAppLink"];
    businessAppLink= json["businessAppLink"];
    corporateAppLink= json["corporateAppLink"];
  }
}