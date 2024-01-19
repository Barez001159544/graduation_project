class MonetaryValue {
  late String amount;
  late String currency;

  MonetaryValue(
    this.amount,
    this.currency,
  );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'currency': currency,
      };
}
