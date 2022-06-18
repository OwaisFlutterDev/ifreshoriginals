import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/order_controller.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/home_screen_widget.dart';

class OrderHistoryScreen extends StatelessWidget{
  OrderHistoryScreen({Key? key}) : super(key: key);

  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      //-------------------------------------------------
      //     ------ ========== App Bar ======== ------
      //-------------------------------------------------

      appBar: appBar(
          title: "Order History",
          leadingWidget: InkWell(
            onTap: () => Get.back(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10.w,),
                Icon(CupertinoIcons.back,color: blackColor,size: 90.r),
              ],
            ),
          ),
          action: [
            FirebaseAuth.instance.currentUser!.isAnonymous ? Container() : cartButtonWidget(),
            SizedBox(width: 40.w,)
          ]
      ),

      //-------------------------------------------------
      //     ------ ========== App Bar ======== ------
      //-------------------------------------------------
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(children: [
                SizedBox(height: 40.h,),
                Obx( () =>orderController.allOrderHistoryList.isNotEmpty ?
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: orderController.allOrderHistoryList.length,
                    itemBuilder: (BuildContext context,int index){
                      return Column(
                        children: [
                          InkWell(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        scrollable: true,
                                        alignment: Alignment.bottomCenter,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        backgroundColor: bgColor,
                                        insetPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                                        content: Builder(
                                            builder: (context) {
                                              return Column(children: [
                                                commonText(
                                                    title: "Order Details"
                                                ),
                                                SizedBox(height: 20,),
                                                Container(
                                                  height: .7.sh ,width: 0.9.sw, color: Colors.transparent,
                                                  child: ListView.builder(
                                                      scrollDirection: Axis.vertical,
                                                      shrinkWrap: true,
                                                      physics: ScrollPhysics(),
                                                      itemCount: orderController.allOrderHistoryList[index].productList!.length,
                                                      itemBuilder: (BuildContext context,int inde){
                                                        return Column(
                                                          children: [
                                                            Container(
                                                              height: 350,
                                                              width: .8.sw,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(30.r),
                                                                boxShadow: const <BoxShadow>[
                                                                  BoxShadow(
                                                                    color: Colors.black12,
                                                                    blurRadius: 4.0,
                                                                    offset: Offset(0, 5,),
                                                                  )
                                                                ],
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      height: 150,
                                                                      width: .7.sw,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Image.network("${orderController.allOrderHistoryList[index].productList![inde].frontImage}",
                                                                            fit: BoxFit.cover, width: 100,height: 140,),
                                                                          Image.network("${orderController.allOrderHistoryList[index].productList![inde].backImage}",
                                                                            fit: BoxFit.cover, width: 100,height: 140,),
                                                                        ],),
                                                                    ),
                                                                    SizedBox(height: 21,),
                                                                    textOrderWidget(
                                                                      title: "Design Type",
                                                                      value: "${orderController.allOrderHistoryList[index].productList![inde].designType}",
                                                                    ),
                                                                    SizedBox(height: 15,),
                                                                    textOrderWidget(
                                                                      title: "Selected Size",
                                                                      value: "${orderController.allOrderHistoryList[index].productList![inde].selectedSize}",
                                                                    ),
                                                                    SizedBox(height: 15,),
                                                                    textOrderWidget(
                                                                      title: "Per Shirt Price",
                                                                      value: "${orderController.allOrderHistoryList[index].productList![inde].perShirtPrice}",
                                                                    ),
                                                                    SizedBox(height: 15,),
                                                                    textOrderWidget(
                                                                      title: "Selected Quantity",
                                                                      value: "${orderController.allOrderHistoryList[index].productList![inde].selectedQuantity}",
                                                                    ),
                                                                    SizedBox(height: 15,),
                                                                    textOrderWidget(
                                                                      title: "Total Price",
                                                                      value: "${orderController.allOrderHistoryList[index].productList![inde].totalPrice}",
                                                                    ),

                                                                  ],),
                                                              ),
                                                            ),
                                                            SizedBox(height: 30,)
                                                          ],
                                                        ); }),
                                                )

                                              ],); })
                                    );
                                  });
                            },
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 7),
                              child: Container(
                                height: 350,
                                width: 1.sw,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.r),
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4.0,
                                      offset: Offset(0, 5,),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Column(
                                    children: [
                                      smallText(
                                          title: "Click On The Card To See More Details",
                                          textAlign: TextAlign.center,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500
                                      ),
                                      SizedBox(height: 20,),

                                      Container(
                                        color: Colors.transparent,
                                        height: 110,
                                        width: 0.8.sw,
                                        child: CarouselSlider.builder(
                                            itemCount: orderController.allOrderHistoryList[index].productList!.length,
                                            options: CarouselOptions(
                                                autoPlay: true,
                                                aspectRatio: 2.0,
                                                viewportFraction: 1,
                                                scrollDirection: Axis.horizontal
                                              // enlargeCenterPage: true,
                                            ),
                                            itemBuilder: (context, inde, realIdx) {
                                              return Container(
                                                child: Center(
                                                    child: Image.network(orderController.allOrderHistoryList[index].productList![inde].frontImage!,
                                                      fit: BoxFit.cover, )),
                                              );

                                            }
                                        ),),
                                      SizedBox(height: 30,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          smallText(
                                            title: "Delivery Time",
                                            color: blackColor,
                                          ),
                                          smallText(
                                              title: orderController.allOrderHistoryList[index].deliveryTime,
                                              color: blackColor,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ],),
                                      SizedBox(height: 15,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          smallText(
                                            title: "Delivery Charges",
                                            color: blackColor,
                                          ),
                                          commonText(
                                              title: "\$${orderController.allOrderHistoryList[index].deliveryCharge}",
                                              textStyle: TextStyle(color: blackColor,
                                                  fontWeight: FontWeight.w600,fontSize: 15)
                                          ),
                                        ],),
                                      SizedBox(height: 15,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          smallText(
                                            title: "Payed Amount",
                                            color: blackColor,
                                          ),
                                          commonText(
                                              title: "\$${orderController.allOrderHistoryList[index].payedAmount}",
                                              textStyle: TextStyle(color: blackColor,
                                                  fontWeight: FontWeight.w600,fontSize: 15)
                                          ),
                                        ],),
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          commonButton(
                                              buttonColor: orderController.allOrderHistoryList[index].status == false ?  Colors.red.shade400 : Colors.blue.shade500 ,
                                              buttonName:  orderController.allOrderHistoryList[index].status == false ?  "Pending" : "Delivered",
                                              textColor:   whiteColor,
                                              buttonHeight: 31,
                                              buttonWidth: 95,
                                              textSize: 12
                                          )
                                        ],)
                                    ],),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24,)
                        ],
                      );
                    }
                ) : Container() )
              ],),
            ),)),
    );
  }
}