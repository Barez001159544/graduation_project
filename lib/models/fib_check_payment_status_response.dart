import 'package:graduation_project/models/fib_create_payment_monetary_value.dart';

class FIBCheckPaymentStatusResponse{
  late String? paymentId;
  late String? status;
  late String? validUntil;
  late String? paidAt;
  late Map<String, dynamic> amount;
  late String? decliningReason;
  late String? declinedAt;
  late String? paidBy;

  FIBCheckPaymentStatusResponse(
      this.paymentId,
      this.status,
      this.validUntil,
      this.paidAt,
      this.amount,
      this.decliningReason,
      this.declinedAt,
      this.paidBy,
      );

  FIBCheckPaymentStatusResponse.fromJson(Map<String, dynamic> json){
    paymentId= json['paymentId'];
    status= json['status'];
    validUntil= json['validUntil'];
    paidAt= json['paidAt'];
    amount= json['amount'];
    decliningReason= json['decliningReason'];
    declinedAt= json['declinedAt'];
    paidBy= json['paidBy'];
  }
}