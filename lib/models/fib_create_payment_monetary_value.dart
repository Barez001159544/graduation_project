class MonetaryValue {
  late int? amount;
  late String? currency;

  MonetaryValue(
    this.amount,
    this.currency,
  );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'currency': currency,
      };

  MonetaryValue.fromJson(Map<String, dynamic>? json){
    amount= json?['amount'];
    currency= json?['currency'];
  }
}
