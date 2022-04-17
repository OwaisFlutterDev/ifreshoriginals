import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/controller/shipping_controller.dart';
import '../../../constant/constants.dart';
import '../../../controller/cart_controller.dart';
import '../../widgets/card_widget.dart';
import '../../widgets/common_widgets.dart';
import '../shipping_screens/shapping_address_screen.dart';
import 'drawer_screens/privacy_policy.dart';
import 'drawer_screens/terms_and_conditions.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final CartController cartController = Get.put(CartController());
  final ShippingController shippingController = Get.put(ShippingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //-------------------------------------------------
      //     ------ ========== appbar ======== ------
      //-------------------------------------------------
      appBar: appBar(
        title: "Cart",
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
      backgroundColor: bgColor,
      //-------------------------------------------------
      //     ------ ========== body ======== ------
      //-------------------------------------------------
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.h,
              ),
              headerThree(
                  title: "Item Details",
                  color: blackColor,
                  fontWeight: FontWeight.w600),
              SizedBox(
                height: 60.h,
              ),

              //-------------------------------------------------
              //     ------ ========== cart item  ======== ------
              //-------------------------------------------------
              Obx(
                    () => ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: cartController.cartList.value.cart!.length,
                        itemBuilder: (context, index) {
                          return  Column(
                            children: [
                              cartItemWidget(
                                  image: cartController.cartList.value.cart![index].frontImage,
                                  editItem: () {
                                    cartController.selectedSizedIndexCart = cartController.cartList.value.cart![index].selectedSizedIndex;
                                    cartController.selectedSizeCart = cartController.cartList.value.cart![index].selectedSize;
                                    cartController.selectedQuantityIndexCart = (cartController.cartList.value.cart![index].selectedQuantity! - 1) as int? ;
                                    cartController.selectedQuantityCart = cartController.cartList.value.cart![index].selectedQuantity ;
                                    cartController.discountCart = cartController.cartList.value.cart![index].discountNo;

                                    cartController.frontImage = cartController.cartList.value.cart![index].frontImage;
                                    cartController.backImage= cartController.cartList.value.cart![index].backImage;
                                    cartController.id = cartController.cartList.value.cart![index].id;
                                    cartController.designType = cartController.cartList.value.cart![index].designType;
                                    cartController.perShirtPrice = cartController.cartList.value.cart![index].perShirtPrice;

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return  AlertDialog(
                                              scrollable: true,
                                              alignment: Alignment.bottomCenter,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(15))),
                                              backgroundColor: bgColor,
                                              insetPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                                              content: Builder(
                                                  builder: (context) {
                                                    return GetBuilder<CartController>(
                                                        init: CartController(),
                                                        builder: (controller) {
                                                          return Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                // --- === title cross button === ---
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children:  [
                                                                    SizedBox(width: 20.w,),
                                                                    largeText(title: "Edit Cart Item",color: blackColor,fontWeight: FontWeight.bold),
                                                                    InkWell(
                                                                        onTap: (){ Get.back();},
                                                                        child: Container(
                                                                            height: 70.h,
                                                                            width: 70.w,
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.transparent,
                                                                                shape: BoxShape.circle,
                                                                                border: Border.all(width: 4.r,color: blackColor)
                                                                            ),
                                                                            child: Center(child: Icon(CupertinoIcons.clear, color: redColor,size: 40.r,)))
                                                                    )
                                                                  ],),

                                                                // -----------------------------------------------------
                                                                // -----=--======= Sized Selected Button ========--=-----
                                                                // -----------------------------------------------------
                                                                SizedBox(height: 40.h,),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    largeText(
                                                                        title: "  Selected Size",
                                                                        fontWeight: FontWeight.w600
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(height: 30.h,),
                                                                Container(
                                                                  width: 0.9.sw,
                                                                  height: 68,
                                                                  color: Colors.transparent,
                                                                  // color: Colors.blue[100]
                                                                  child: GridView.builder(
                                                                      scrollDirection: Axis.vertical,
                                                                      physics: ScrollPhysics(),
                                                                      shrinkWrap: true,
                                                                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                                                        // maxCrossAxisExtent: 400.h,
                                                                        crossAxisCount: 5,
                                                                        mainAxisExtent: 55,
                                                                      ),
                                                                      itemCount: shippingController.selectSizeList.length,
                                                                      itemBuilder: (BuildContext ctx, index) {
                                                                        return  InkWell(
                                                                            onTap: () {
                                                                              controller.selectedSizedIndexCart = index;
                                                                              controller.selectedSizeCart = shippingController.selectSizeList[index].size;
                                                                              controller.update();
                                                                            },
                                                                            child: Container(
                                                                                height: 48,
                                                                                width: 48,
                                                                                decoration: BoxDecoration(
                                                                                  color: controller.selectedSizedIndexCart == index ? redColor : whiteColor,
                                                                                  shape: BoxShape.circle,
                                                                                  boxShadow: const <BoxShadow>[
                                                                                    BoxShadow(
                                                                                      color: Colors.black12,
                                                                                      blurRadius: 2.0,
                                                                                      offset: Offset(0, 4,),
                                                                                    )
                                                                                  ],

                                                                                ),
                                                                                child:  Center(child: largeText(
                                                                                    color: controller.selectedSizedIndexCart == index ? whiteColor : blackColor,
                                                                                    title: shippingController.selectSizeList[index].size
                                                                                ),)
                                                                            )

                                                                        );
                                                                      }),
                                                                ),
                                                                SizedBox(height: 20.h,),
                                                                Divider(height: 1,color: Colors.black12),

                                                                // -----------------------------------------------------
                                                                // -----=--======= Sized Quantity Button ========--=-----
                                                                // -----------------------------------------------------
                                                                SizedBox(height: 50.h,),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    largeText(
                                                                        title: "  Select Quantity",
                                                                        fontWeight: FontWeight.w600
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(height: 30.h,),
                                                                Container(
                                                                  width: 0.9.sw,
                                                                  height: 73,
                                                                  color: Colors.transparent,
                                                                  // color: Colors.blue[100]
                                                                  child: GridView.builder(
                                                                      scrollDirection: Axis.horizontal,
                                                                      physics: ScrollPhysics(),
                                                                      shrinkWrap: true,
                                                                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                                                        // maxCrossAxisExtent: 400.h,
                                                                        crossAxisCount: 1,
                                                                        mainAxisExtent: 66,
                                                                      ),
                                                                      itemCount: shippingController.selectQuantityList.length,
                                                                      itemBuilder: (BuildContext ctx, index) {
                                                                        return  Row(
                                                                          children: [
                                                                            InkWell(
                                                                                onTap: () {
                                                                                  controller.selectedQuantityIndexCart = index;
                                                                                  controller.selectedQuantityCart = shippingController.selectQuantityList[index].quantity!;
                                                                                  controller.discountCart =  shippingController.selectQuantityList[index].discount!;
                                                                                  // controller.calculationFun();

                                                                                  controller.update();
                                                                                },
                                                                                child: Container(
                                                                                    height: 55,
                                                                                    width: 55,
                                                                                    decoration: BoxDecoration(
                                                                                      color: controller.selectedQuantityIndexCart == index ? redColor : whiteColor,
                                                                                      shape: BoxShape.circle,
                                                                                      boxShadow: const <BoxShadow>[
                                                                                        BoxShadow(
                                                                                          color: Colors.black12,
                                                                                          blurRadius: 2.0,
                                                                                          offset: Offset(0, 4,),
                                                                                        )
                                                                                      ],

                                                                                    ),
                                                                                    child:  Center(child: largeText(
                                                                                        color: controller.selectedQuantityIndexCart == index ? whiteColor : blackColor,
                                                                                        title: "${shippingController.selectQuantityList[index].quantity}"
                                                                                    ),)
                                                                                )

                                                                            ),
                                                                            SizedBox(width: 10.w,)
                                                                          ],
                                                                        );
                                                                      }),
                                                                ),
                                                                SizedBox(height: 30.h,),
                                                                Divider(height: 1,color: Colors.black12),
                                                                SizedBox(height: 50.h,),
                                                                // --------===------========  update Button =======------===--------
                                                                commonButton(
                                                                    buttonName: "Update",
                                                                    onTap: (){
                                                                      controller.updateItemFromCart(cartController.cartList.value.cart![index]);
                                                                    },
                                                                    buttonColor: redColor,
                                                                    textColor: whiteColor,
                                                                    buttonWidth: 1.sw
                                                                ),
                                                                SizedBox(height: 10.h,),

                                                              ]);
                                                        }
                                                    ); })
                                          );
                                        });
                                  },
                                  deleteItem: () {
                                    cartController.deleteItemFromCart(cartController.cartList.value.cart![index]);
                                  },
                                  size: cartController.cartList.value.cart![index].selectedSize,
                                  price: "${cartController.cartList.value.cart![index].totalPrice}",
                                  quantity: "${cartController.cartList.value.cart![index].selectedQuantity}",
                                  category: cartController.cartList.value.cart![index].designType),
                              SizedBox(height: 20,)
                            ],
                          );

                        }),
              ),


              //-------------------------------------------------
              //     ------ ========== cart item  ======== ------
              //-------------------------------------------------
              GetBuilder<CartController>(
                builder: (controller) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 170.h,
                      ),
                      headerThree(
                          title: "Price Details",
                          color: blackColor,
                          fontWeight: FontWeight.w600),
                      // =-=------- sub Total --------=-=
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          smallText(
                            title: "Sub Total",
                          ),
                          smallText(
                            title: "\$ ${cartController.sumOfSubTotal}",
                          ),
                        ],
                      ),

                      // =-=------- Discount --------=-=
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          smallText(
                            title: "Discount",
                          ),
                          smallText(
                            title: "\$ ${cartController.sumOfDiscount}",
                          ),
                        ],
                      ),
                      // =-=------- Total --------=-=
                      SizedBox(
                        height: 50.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          largeText(title: "Total", fontWeight: FontWeight.w700),
                          largeText(title: "\$ ${cartController.sumOfTotal}", fontWeight: FontWeight.w700),
                        ],
                      ),
                    ],
                  );
                }
              ),

              // =-=------- Checkout Button --------=-=
              SizedBox(
                height: 60.h,
              ),
              Row(
                children: [
                  GetBuilder<CartController>(
                      init: CartController(),
                      builder: (controller) {
                        return Checkbox(
                            value: controller.isChecked,
                            onChanged: (check) {
                              controller.isChecked = check!;
                              controller.update();
                            });
                      }),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          commonText(
                              title: "I have read and agree to the ",
                              textStyle: TextStyle(fontSize: 32.sp)),
                          InkWell(
                              onTap: () {
                                Get.to(() => TermsAndConditionScreen());
                              },
                              child: commonText(
                                  title: "Terms & Condition,",
                                  textStyle: TextStyle(
                                      fontSize: 32.sp, color: Colors.blue))),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Get.to(() => PrivacyPolicyScreen());
                              },
                              child: commonText(
                                  title: "Privacy Policy",
                                  textStyle: TextStyle(
                                      fontSize: 32.sp, color: Colors.blue))),
                          commonText(
                              title: " of “iFresh Originals”",
                              textStyle: TextStyle(
                                fontSize: 32.sp,
                              ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // =-=------- Checkout Button --------=-=
              SizedBox(
                height: 60.h,
              ),
              GetBuilder<CartController>(
                init: CartController(),
                builder: (controller) {
                  return controller.isChecked ? commonButton(
                      buttonName: "Checkout",
                      onTap: () {
                        FirebaseAuth.instance.currentUser!.isAnonymous ?
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alertDialogWidget();
                            }) :  Get.to(() => ShippingAddressScreen());
                        
                      },
                      buttonColor: redColor,
                      buttonWidth: 1.sw,
                      textColor: Colors.white,
                  )
                      :
                  commonButton(
                      buttonName: "Checkout",
                      buttonColor: whiteColor,
                      buttonWidth: 1.sw,
                      textColor: Colors.black, );


                }
              ),

              SizedBox(height: 16,)
            ],
          ),
        ),
      )),
    );
  }
}
