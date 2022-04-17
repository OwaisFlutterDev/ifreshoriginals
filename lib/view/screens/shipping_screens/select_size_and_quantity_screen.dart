import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/cart_controller.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_image_controller.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import 'package:ifreshoriginals_userapp/controller/shipping_controller.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/home_screen_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/view/widgets/selected_size_and_quantity_screen_widget.dart';
import 'package:ifreshoriginals_userapp/view/widgets/user_auth_screen_widget.dart';
import 'package:screenshot/screenshot.dart';

class SelectSizeAndQuantityScreen extends StatelessWidget{
  SelectSizeAndQuantityScreen({Key? key}) : super(key: key);

  final ShippingController _shippingController = Get.put(ShippingController());
  final  HomeController homeController = Get.find<HomeController>();
  final FunctionalityOnImageController functionalityOnImageController = Get.put(FunctionalityOnImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(
          title: "${homeController.selectedDesignType}",
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
            cartButtonWidget(),
            SizedBox(width: 40.w,)
          ]
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 10.h,),
            // -----------------------------------------------------
            // -----=--======= save image function ========--=-----
            // -----------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 30.w,),
                SizedBox(width: 50.w,),
                headerThree(title: "Animal Kingdom",color: blackColor, fontWeight: FontWeight.w700),
                InkWell(
                  onTap: () {
                    functionalityOnImageController.saveImage(context);
                  },
                child: Row(
                  children: [
                    Container(
                      width: 125.w,
                      height: 125.h,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          shape: BoxShape.circle,
                          boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2.0,
                            offset: Offset(0, 2,),
                          )
                        ],
                      ),
                      child: Icon(Icons.download_outlined,size: 75.r,)
                      // Image(image: AssetImage("assets/Asset 34.png"),
                      //   fit: BoxFit.scaleDown,),
                    ),
                    SizedBox(width: 40.w,)
                  ],
                ),
              ),
            ],
          ),

            SizedBox(height: 40.h,),
            // -----------------------------------------------------
            // -----=--======= Both Shirt Image (Front And Back) ========--=-----
            // -----------------------------------------------------
            GetBuilder<FunctionalityOnImageController>(
                init: FunctionalityOnImageController(),
                builder: (controller) {
                  return Screenshot(
                    controller: controller.screenshotControllerForSelectedSAQ,
                    child: InteractiveViewer(
                            transformationController: controller.interactiveViewerTwoController,
                       child:  Container(
                        height: 340,
                        width: 1.sw,
                        color: Color(0xffE2E2E2),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 40.w,vertical: 20.h),
                          child: Row(
                            children: [
                              Container(
                                height: 250,
                                width: 570.w,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    // border: Border.all(color: blackColor,width: 1),
                                    image: DecorationImage(image: MemoryImage(controller.frontByteImage!.buffer.asUint8List()),
                                        fit: BoxFit.fill,
                                    )
                                ),

                              ),

                              Padding(
                                padding:  EdgeInsets.only(top: 120),
                                child: Container(
                                  height: 160,
                                  width: 400.w,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      // border: Border.all(color: blackColor,width: 1),
                                      image: DecorationImage(image: MemoryImage(controller.backByteImage!.buffer.asUint8List()),
                                        fit: BoxFit.fill,
                                      )
                                  ),

                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ) ,

            // -----------------------------------------------------
            // -----=--======= below image section ========--=-----
            // -----------------------------------------------------
            SizedBox(height: 20.h,),
            GetBuilder<ShippingController>(
                init: ShippingController(),
                builder: (controller) {
                  return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 50.w),
                  child: Column(
                    children: [
                      // ----======= zoom in , zoom out & change image side  ========----
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        InkWell(
                          onTap: (){
                            functionalityOnImageController.zoomInForSelectedSizeAndQua() ;
                          },
                          child: imageWidget(
                            image: "assets/Asset 39.png",
                            width: 170.w,
                            height: 170.h,
                          ),
                        ),
                        // --- ===  _ button === ---
                        SizedBox(width: 7.w,),
                        InkWell(
                          onTap: (){
                            functionalityOnImageController.zoomOutForSelectedSizeAndQua();
                          },
                          child: imageWidget(
                            image: "assets/Asset 40.png",
                            width: 170.w,
                            height: 170.h,
                          ),
                        ),
                      ],),
                      SizedBox(height: 20.h,),
                      Divider(height: 1,color: Colors.black12),
                      // ===========-----=--======= below image section ========--=-----========

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
                                itemCount: controller.selectSizeList.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return  InkWell(
                                      onTap: () {
                                        controller.selectedSizedIndex = index;
                                        controller.selectedSize = controller.selectSizeList[index].size;
                                        print( controller.selectedSize);
                                        controller.update();
                                      },
                                      child: Container(
                                        height: 48,
                                        width: 48,
                                        decoration: BoxDecoration(
                                          color: controller.selectedSizedIndex == index ? redColor : whiteColor,
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
                                            color: controller.selectedSizedIndex == index ? whiteColor : blackColor,
                                            title: controller.selectSizeList[index].size
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
                      SizedBox(height: 40.h,),
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
                            itemCount: controller.selectQuantityList.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return  Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        controller.selectedQuantityIndex = index;
                                        controller.selectedQuantity = controller.selectQuantityList[index].quantity!;
                                        controller.discount =  controller.selectQuantityList[index].discount!;
                                        controller.calculationFun();
                                        print( controller.selectedQuantity);
                                        controller.update();
                                      },
                                      child: Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                            color: controller.selectedQuantityIndex == index ? redColor : whiteColor,
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
                                              color: controller.selectedQuantityIndex == index ? whiteColor : blackColor,
                                              title: "${controller.selectQuantityList[index].quantity}"
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


                      // -----------------------------------------------------
                      // -----=--======= Sized Selected Button ========--=-----
                      // -----------------------------------------------------
                      SizedBox(height: 40.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          largeText(
                              title: "  Discount",
                              fontWeight: FontWeight.w600
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h,),
                      // ------------ ==== discount ==== -----------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          discountWidget(
                            quantity: "0-2",
                            discount: "0",
                            textColorForDiscount: controller.selectedQuantity == 0 || controller.selectedQuantity! < 3   ? redColor : blackColor,
                            textColorForQuantity: controller.selectedQuantity == 0 || controller.selectedQuantity! < 3  ? redColor : Colors.black54,
                            boxDecoration: controller.selectedQuantity == 0 || controller.selectedQuantity! < 3 ?  BoxDecoration(
                              color:  whiteColor,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2.0,
                                  offset: Offset(0, 4,),
                                )
                              ],
                            ) : BoxDecoration(
                              color:  Colors.transparent,
                            ),
                          ),
                          discountWidget(
                            quantity: "3-5",
                            discount: "-4",
                            textColorForDiscount: controller.selectedQuantity == 3 || (controller.selectedQuantity! > 3 && controller.selectedQuantity! < 6 )  ? redColor : blackColor,
                            textColorForQuantity: controller.selectedQuantity == 3 || (controller.selectedQuantity! > 3 && controller.selectedQuantity! < 6 )  ? redColor : Colors.black54,
                            boxDecoration: controller.selectedQuantity == 3 || (controller.selectedQuantity! > 3 && controller.selectedQuantity! < 6 ) ?  BoxDecoration(
                              color:  whiteColor,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2.0,
                                  offset: Offset(0, 4,),
                                )
                              ],
                            ) : BoxDecoration(
                              color:  Colors.transparent,
                            ),
                          ),
                          discountWidget(
                            quantity: "10",
                            discount: "-8",
                            textColorForDiscount: controller.selectedQuantity == 10  ? redColor : blackColor,
                            textColorForQuantity: controller.selectedQuantity == 10  ? redColor : Colors.black54,
                            boxDecoration: controller.selectedQuantity == 10  ?  BoxDecoration(
                              color:  whiteColor,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2.0,
                                  offset: Offset(0, 4,),
                                )
                              ],
                            ) : BoxDecoration(
                              color:  Colors.transparent,
                            ),
                          ),
                          discountWidget(
                            quantity: "15",
                            discount: "-12",
                            textColorForDiscount: controller.selectedQuantity == 15  ? redColor : blackColor,
                            textColorForQuantity: controller.selectedQuantity == 15  ? redColor : Colors.black54,
                            boxDecoration: controller.selectedQuantity == 15  ?  BoxDecoration(
                              color:  whiteColor,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2.0,
                                  offset: Offset(0, 4,),
                                )
                              ],
                            ) : BoxDecoration(
                              color:  Colors.transparent,
                            ),
                          ),
                          discountWidget(
                            quantity: "20",
                            discount: "-16",
                            textColorForDiscount: controller.selectedQuantity == 20  ? redColor : blackColor,
                            textColorForQuantity: controller.selectedQuantity == 20  ? redColor : Colors.black54,
                            boxDecoration: controller.selectedQuantity == 20  ?  BoxDecoration(
                              color:  whiteColor,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2.0,
                                  offset: Offset(0, 4,),
                                )
                              ],
                            ) : BoxDecoration(
                              color:  Colors.transparent,
                            ),
                          ),
                          discountWidget(
                            quantity: "25",
                            discount: "-20",
                            textColorForDiscount: controller.selectedQuantity == 25  ? redColor : blackColor,
                            textColorForQuantity: controller.selectedQuantity == 25  ? redColor : Colors.black54,
                            boxDecoration: controller.selectedQuantity == 25  ?  BoxDecoration(
                              color:  whiteColor,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2.0,
                                  offset: Offset(0, 4,),
                                )
                              ],
                            ) : BoxDecoration(
                              color:  Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.h,),
                      Divider(height: 1,color: Colors.black12),
                      SizedBox(height: 40.h,),
                      // -----------------------------------------------------
                      // -----=--======= Total And Discount ========--=-----
                      // -----------------------------------------------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          smallText(
                              title: "Total Discount",
                              color: Colors.black87,
                              fontWeight: FontWeight.w500
                          ),
                          smallText(
                              title: "\$${controller.discountPer}",
                              color: Colors.black87,
                              fontWeight: FontWeight.w500
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          largeText(
                              title: "Total",
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                          ),
                          largeText(
                              title: "\$${controller.totalPrice}",
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                          ),
                        ],
                      ),

                      // -----------------------------------------------------
                      // -----=--======= Add To Cart Button ========--=-----
                      // -----------------------------------------------------
                      SizedBox(height: 60.h,),
                      GetBuilder<CartController>(
                        init: CartController(),
                        builder: (controller) {
                          return controller.addToCartBool == false ? commonButton(
                              buttonName: "Add To Cart",
                              textColor: whiteColor,
                              onTap: (){

                                   controller.addCartData();
                                   functionalityOnImageController.createDesignBool = false;
                                   functionalityOnImageController.update();

                              },
                              buttonColor: redColor,

                              buttonWidth: 1.sw
                          ) : CircularProgressIndicator();
                        }
                      )
                    ],
                  ),
                );
              }
            ),
            SizedBox(height: 50.h,)
          ],)
          ,),),
    );
  }



}