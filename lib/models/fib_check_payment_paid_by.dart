class PaidBy {
  late String? name;
  late String? iban;

  PaidBy(
      this.name,
      this.iban,
      );

  Map<String, dynamic> toJson() => {
    'name': name,
    'iban': iban,
  };

  PaidBy.fromJson(Map<String, dynamic>? json){
    name= json?['name'];
    iban= json?['iban'];
  }
}
