class EntireHouseFee{
  List<EachHouseFee>? historyOfHouseFee;

  EntireHouseFee(
  this.historyOfHouseFee,
  );

  factory EntireHouseFee.fromJson(List<dynamic> json){
    List<EachHouseFee> eachHouseFee=[];
    eachHouseFee= json.map((book) => EachHouseFee.fromJson(book)).toList().reversed.toList();
    return EntireHouseFee(eachHouseFee);
  }
}

class EachHouseFee{
  int? id;
  String? amount;
  String? feeType;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  String? propertyType;

  EachHouseFee(
      this.id,
      this.amount,
      this.feeType,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.propertyType,
      );

  factory EachHouseFee.fromJson(Map<String, dynamic> json){
    return EachHouseFee(
        json["id"],
        json["amount"],
        json["fee_type"],
    json["start_date"],
    json["end_date"],
    json["created_at"],
    json["updated_at"],
    json["property_type"],
    );
  }

}