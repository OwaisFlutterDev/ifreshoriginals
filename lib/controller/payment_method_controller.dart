import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_credit_card/credit_card_model.dart';

class PaymentMethodController extends GetxController {

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();

  //----- ===================   ====================== ------
  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    cardNumber = creditCardModel.cardNumber;
    expiryDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;

    update();
  }

}