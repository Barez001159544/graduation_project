import 'package:graduation_project/models/fib_create_payment_monetary_value.dart';

class FIBCreatePaymentParameters{
  late MonetaryValue monetaryValue;
  late String stausCallbackUrl;
  late String description;
  late String expiresIn;

  FIBCreatePaymentParameters(
      this.monetaryValue,
      this.stausCallbackUrl,
      this.description,
      this.expiresIn,
      );

  Map<String, dynamic> toJson()=>{
    "monetaryValue": monetaryValue,
    "stausCallbackUrl": stausCallbackUrl,
    "description": description,
    "expiresIn": expiresIn,
  };
}