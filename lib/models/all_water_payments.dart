class AllWaterPayments{
  List<EachWaterPayment>? eachWaterPayment;

  AllWaterPayments(
      this.eachWaterPayment,
      );

  factory AllWaterPayments.fromJson(List<dynamic> json){
    List<EachWaterPayment> books=[];
    books= json.map((book) => EachWaterPayment.fromJson(book)).toList();
    return AllWaterPayments(books);
  }
}

class EachWaterPayment{
  int? id;
  int? feeId;
  String? property;
  String? createdAt;
  String? updatedAt;
  String? amount;
  String? feeType;
  String? startDate;
  String? endDate;
  String? propertyType;

  EachWaterPayment(
      this.id,
      this.feeId,
      this.property,
      this.createdAt,
      this.updatedAt,
      this.amount,
      this.feeType,
      this.startDate,
      this.endDate,
      this.propertyType,
      );

  factory EachWaterPayment.fromJson(Map<String, dynamic> json){
    return EachWaterPayment(
      json["id"],
      json["fee_id"],
      json["property"],
      json["created_at"],
      json["updated_at"],
      json["amount"],
      json["fee_type"],
      json["start_date"],
      json["end_date"],
      json["property_type"],
    );
  }
}