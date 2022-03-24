import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/payment_method_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/shipping_screens/order_placed_conformation_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentMethodsScreen extends StatelessWidget {
  PaymentMethodsScreen({Key? key}) : super(key: key);

  final PaymentMethodController _paymentMethodController =
      Get.put(PaymentMethodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: appBar(
          title: "Payment Method",
          leadingWidget: InkWell(
            onTap: () => Get.back(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Icon(CupertinoIcons.back, color: blackColor, size: 90.r),
              ],
            ),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    children: [
                      GetBuilder<PaymentMethodController>(
                        // init: ManageCardController(),
                          builder: (controller) {
                            return CreditCardWidget(
                              cardBgColor: redColor,
                              cardNumber: controller.cardNumber,
                              expiryDate: controller.expiryDate,
                              cardHolderName: controller.cardHolderName,
                              cvvCode: controller.cvvCode,
                              showBackView: controller.isCvvFocused,
                              obscureCardNumber: true,
                              isHolderNameVisible: true,
                              // isSwipeGestureEnabled: ,
                              obscureCardCvv: true,
                              // cardType: CardType.mastercard ,
                              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                            );
                          }
                      ),
                      SizedBox(height: 30.h,),
                      CreditCardForm(
                          formKey: _paymentMethodController.cardFormKey,
                          onCreditCardModelChange:
                              _paymentMethodController.onCreditCardModelChange,
                          obscureCvv: true,
                          obscureNumber: true,
                          isHolderNameVisible: true,
                          // ----------=================================-------------
                          // ------ ===--==-----=== cardHolderDecoration ===-----==--=== ------
                          //-----------=================================-------------
                          cardHolderDecoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(40.r),
                          ),

                          // --- when user interact with -----
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: redColor, width: 1.0),
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                          labelStyle: TextStyle(color: Colors.black54,),
                          hintText: "Card Holder Name",
                          labelText: 'Card Holder Name',
                        ),

                          // ----------=================================-------------
                          // ------ ===--==-----=== cardNumberDecoration ===-----==--=== ------
                          //-----------=================================-------------
                          cardNumberDecoration: InputDecoration(
                            // --- when user does not interact with -----
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(40.r),
                            ),

                            // --- when user interact with -----
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: redColor, width: 1.0),
                              borderRadius: BorderRadius.circular(40.r),
                            ),
                            labelText: 'Number',
                            labelStyle:
                                TextStyle(fontSize: 50.sp, color: Colors.black54),
                            hintText: 'XXXX XXXX XXXX XXXX',
                          ),

                          // ----------=================================-------------
                          // ------ ===--==-----=== expiryDateDecoration ===-----==--=== ------
                          //-----------=================================-------------
                          expiryDateDecoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(40.r),
                              ),

                              // --- when user interact with -----
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: redColor, width: 1.0),
                                borderRadius: BorderRadius.circular(40.r),
                              ),

                              labelText: 'Expired Date',
                              labelStyle:
                                  TextStyle(fontSize: 50.sp, color: Colors.black54),
                              hintText: 'XX/XX',
                            ),

                          // ----------=================================-------------
                          // ------ ===--==-----=== cvvCodeDecoration ===-----==--=== ------
                          //-----------=================================-------------
                          cvvCodeDecoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(40.r),
                              ),

                              // --- when user interact with -----
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: redColor, width: 1.0),
                                borderRadius: BorderRadius.circular(40.r),
                              ),
                              labelText: 'CVV',
                              labelStyle:
                                  TextStyle(fontSize: 50.sp, color: Colors.black54),
                              hintText: 'XXX',
                            ),

                          cardHolderName: _paymentMethodController.cardHolderName,
                          themeColor: Colors.black87,
                          cvvCode: _paymentMethodController.cvvCode,
                          expiryDate: _paymentMethodController.expiryDate,
                          cardNumber: _paymentMethodController.cardNumber,

                        ),
                        SizedBox(
                          height: 70,
                        ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 37.w),
                        child: commonButton(
                          buttonWidth: 1.sw,
                          buttonHeight: 150.h,
                          buttonName: "Proceed",
                          onTap: () {
                            Get.to(() => OrderPlacedConformationScreen());
                          },
                          buttonColor: redColor,
                          textStyle: TextStyle(color: whiteColor,fontWeight: FontWeight.w600)
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                ],
              ))));
  }
}
