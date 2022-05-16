import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/controller/order_controller.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:http/http.dart' as http;

class PaymentMethodController extends GetxController {
  double totalForPay = 0;
  double deliveryCharge = 0;
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

        // ------ =-=-  onCardEntryComplete -=-=-= ------
        onCardEntryComplete: () async {

          final OrderController orderController = Get.find<OrderController>();
          int totalForPayInt = totalForPay.toInt();
          int deliveryChargeInt = deliveryCharge.toInt();
          final response = await http.post(
              Uri.parse(
                  'https://us-central1-ifresh-originals.cloudfunctions.net/chargeForShirt'
              ),
              body: {
                'nonce': result.nonce,
                'amount': totalForPayInt.toString(), //   support only int type of data
              });
          if (response.statusCode == 200) {
            print("response: 200");
            await orderController.addOrderDetails(totalForPayInt,deliveryChargeInt );
          }

          print(":response:  ${response.statusCode}");

          await Get.defaultDialog(
            title: "Payments Conformation",
            middleText: response.body.toString(),
            backgroundColor: Colors.white,
            titleStyle: TextStyle(color: Colors.black,fontSize: 18),
            middleTextStyle: TextStyle(color: Colors.black,fontSize: 13),
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