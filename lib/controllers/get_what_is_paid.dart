import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/what_is_paid_model.dart';

class GetWhatIsPaid extends ChangeNotifier{
  bool isLoading=false;
  WhatIsPaidModel? _whatIsPaidModel;
  WhatIsPaidModel? get whatIsPaidModel=>_whatIsPaidModel;

  void getWhatIsPaid(String? type, String? amount, String? selectedType, int? selectedId, String? selectedProperty, int? selectedPaymentId){
    isLoading=true;
    notifyListeners();

    _whatIsPaidModel= WhatIsPaidModel(type, amount, selectedType, selectedId, selectedProperty, selectedPaymentId);

    isLoading=false;
    notifyListeners();
  }
}