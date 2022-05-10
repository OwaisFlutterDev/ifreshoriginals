import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:http/http.dart' as http;


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

          // http.Response response = await http.get("http://fe80::88eb:299c:6542:7aa3%12:8080?nonce=" + result.nonce);
          var url = Uri.parse("http://fe80::88eb:299c:6542:7aa3%12:8080?nonce=" + result.nonce);
          http.Response response = await http.get(url);

          // var url = Uri.http("http://fe80::88eb:299c:6542:7aa3%12:8080?", "nonce=" + result.nonce);
          // http.Response response = await http.get(url);

          await Get.defaultDialog(
            title: "Square Payments API Response",
            middleText: response.body.toString(),
            backgroundColor: Colors.black12,
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

  // void onCardEntryComplete() async {
  //   Response response = await get("http://<your-local-server-ip-address>:8080?nonce=" + res.nonce);
  //
  //   await showDialog(
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return AlertDialog(
  //           title: Text("Square Payments API Response"),
  //           content: Text(response.body.toString()),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text("OK"),
  //               onPressed: () {
  //                 Navigator.pop(ctx);
  //               },
  //             ),
  //           ],
  //         );
  //       });
  //
  //   print("Success...........");
  // }



}