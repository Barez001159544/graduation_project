class AllHousePayments{
  List<EachHousePayment>? eachHousePayment;

  AllHousePayments(
      this.eachHousePayment,
      );

  factory AllHousePayments.fromJson(List<dynamic> json){
    List<EachHousePayment> books=[];
    books= json.map((book) => EachHousePayment.fromJson(book)).toList();
    return AllHousePayments(books);
  }
}

class EachHousePayment{
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

  EachHousePayment(
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

  factory EachHousePayment.fromJson(Map<String, dynamic> json){
    return EachHousePayment(
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