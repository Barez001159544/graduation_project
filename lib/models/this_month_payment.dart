class ThisMonthPayment{
  List<HouseFee>? eachHouseFee;

  ThisMonthPayment(
      this.eachHouseFee,
      );

  factory ThisMonthPayment.fromJson(List<dynamic> json){
    List<HouseFee> eachHouseFee=[];
    eachHouseFee= json.map((book) => HouseFee.fromJson(book)).toList();
    return ThisMonthPayment(eachHouseFee);
  }
}

class HouseFee {
  int? id;
  String? amount;
  String? feeType;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  String? propertyType;
  int? feeId;
  String? property;
  String? amountPaid;
  String? paymentDate;
  String? paymentMethod;
  int? isPaid;
  int? propertyFeeId;
  int? paidBy;

  HouseFee({
    required this.id,
    required this.amount,
    required this.feeType,
    required this.startDate,
    this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.propertyType,
    required this.feeId,
    required this.property,
    required this.amountPaid,
    required this.paymentDate,
    required this.paymentMethod,
    required this.isPaid,
    required this.propertyFeeId,
    required this.paidBy,
  });

  factory HouseFee.fromJson(Map<String, dynamic> json) {
    return HouseFee(
      id: json['id'],
      amount: json['amount'],
      feeType: json['fee_type'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      propertyType: json['property_type'],
      feeId: json['fee_id'],
      property: json['property'],
      amountPaid: json['amount_paid'],
      paymentDate: json['payment_date'],
      paymentMethod: json['payment_method'],
      isPaid: json['is_paid'],
      propertyFeeId: json['property_fee_id'],
      paidBy: json['paid_by'],
    );
  }
}
