import 'dart:convert';

import 'package:graduation_project/models/fib_check_payment_paid_by.dart';
import 'package:graduation_project/models/fib_create_payment_monetary_value.dart';

class FIBCheckPaymentStatusResponse{
  late String? paymentId;
  late String? status;
  // late String? validUntil;
  late String? paidAt;
  MonetaryValue amount=MonetaryValue(0, "currency");// Map<String, dynamic>? amount;
  late String? decliningReason;
  late String? declinedAt;
  PaidBy paidBy=PaidBy("name", "iban");// Map<String, dynamic>? paidBy;

  FIBCheckPaymentStatusResponse(
      this.paymentId,
      this.status,
      // this.validUntil,
      this.paidAt,
      this.amount,
      this.decliningReason,
      this.declinedAt,
      this.paidBy,
      );

  FIBCheckPaymentStatusResponse.fromJson(Map<String, dynamic> json){
    paymentId= json['paymentId'];
    status= json['status'];
    // validUntil= json['validUntil'];
    paidAt= json['paidAt'];
    amount= MonetaryValue.fromJson(json['amount']);// json['amount'];
    decliningReason= json['decliningReason'];
    declinedAt= json['declinedAt'];
    paidBy= PaidBy.fromJson(json['paidBy']);// json['paidBy'];
  }
}