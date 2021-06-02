import 'package:flutter/material.dart';

//Enums
import '../enums/payment_method_enum.dart';

// ignore: prefer_mixin
class PaymentsProvider with ChangeNotifier{
  PaymentMethod _activePaymentMethod = PaymentMethod.COD;

  PaymentMethod get activePaymentMethod => _activePaymentMethod;

  void setActivePaymentMethod(PaymentMethod? method) {
    _activePaymentMethod = method!;
    notifyListeners();
  }

  PaymentsProvider();
}
