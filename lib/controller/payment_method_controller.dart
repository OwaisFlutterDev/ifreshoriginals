import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:http/http.dart' as http;


class PaymentMethodController extends GetxController {

  // String cardNumber = '';
  // String expiryDate = '';
  // String cardHolderName = '';
  // String cvvCode = '';
  // bool isCvvFocused = false;
  // final GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();
  //
  // //----- ===================   ====================== ------
  // void onCreditCardModelChange(CreditCardModel creditCardModel) {
  //   cardNumber = creditCardModel.cardNumber;
  //   expiryDate = creditCardModel.expiryDate;
  //   cardHolderName = creditCardModel.cardHolderName;
  //   cvvCode = creditCardModel.cvvCode;
  //   isCvvFocused = creditCardModel.isCvvFocused;
  //
  //   update();
  // }

  void startCardEntryFlowMethod(){

    InAppPayments.setSquareApplicationId("sandbox-sq0idb-DmyyChN1jRRS7sq8M3e_XQ");
    InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: onCardNonceRequestSuccess,
        onCardEntryCancel: onCardEntryCancel
    );
  }

  void onCardEntryCancel() {
    print("Card Entry Cancel.........");
  }

  void onCardNonceRequestSuccess(CardDetails result) {
    print(result);

    InAppPayments.completeCardEntry(

        onCardEntryComplete: () async {

          final response = await http.post(
              Uri.parse(
                  'https://us-central1-ifresh-originals.cloudfunctions.net/chargeForShirt'
              ),
              body: {
                'nonce': result.nonce,
                'amount': "50", //   support only int type of data
              });
          if (response.statusCode == 200) {
            print("response: 200");

          }

          print(":response:  ${response.statusCode}");

          await Get.defaultDialog(
            title: "Square Payments API Response",
            middleText: response.body.toString(),
            backgroundColor: Colors.white,
            titleStyle: TextStyle(color: Colors.black),
            middleTextStyle: TextStyle(color: Colors.black),
            actions:  <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Get.back();
                },
              ),
            ],

          );

          print("Success...........");
        }
    );
  }

}