import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/controller/order_controller.dart';
import 'package:ifreshoriginals_userapp/controller/user_auth_controller.dart';
import 'package:ifreshoriginals_userapp/controller/user_profile_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/opened_design_screens/opened_design_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/profile_screens/order_history_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/profile_screens/saved_designs_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/profile_screens/edit_profile_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/home_screen_widget.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);
   final HomeController homeController = Get.find<HomeController>();
   final OpenedDesignController openedDesignController = Get.put(OpenedDesignController());
   final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
            child: GetBuilder<UserAuthController>(
              init: UserAuthController(),
              builder: (controller) {
                return FirebaseAuth.instance.currentUser!.isAnonymous ?
                //-------------------------------------------------------------
                //     ------ ========== If SignIn Anonymously   ======== ------
                //-------------------------------------------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: GetBuilder<UserProfileController>(
                          init: UserProfileController(),
                          builder: (controller) {
                            return Column(
                              children: [
                                Center(
                                  child: Container(
                                    height: 330.h,
                                    width: 330.w,
                                    decoration: BoxDecoration(
                                        color: redColor,
                                        shape: BoxShape.circle,
                                          ),
                                    child: Center(
                                      child: commonText(
                                          title: "G",
                                          textAlign:  TextAlign.center,
                                          textStyle:  TextStyle(
                                            color: whiteColor,
                                            fontSize: 120.sp
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40.h,),
                                // --- === name === ---
                                Center(
                                    child: largeText(title: "Guest Account",fontWeight: FontWeight.bold)),
                                SizedBox(height: 15.h,),
                                // // --- === email === ---
                                // Center(child: smallText(title: "To ",)),

                              ],
                            );
                          }
                      ),
                    ),
                  ],
                ) :

                //-------------------------------------------------
                //     ------ ========== Profile image and Data ======== ------
                //-------------------------------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 35.h,),

                        //-------------------------------------------------
                        //     ------ ========== Profile image and Data ======== ------
                        //-------------------------------------------------
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: GetBuilder<UserProfileController>(
                              init: UserProfileController(),
                              builder: (controller) {
                                return Column(
                                children: [
                                  Center(
                                    child: Container(
                                      height: 330.h,
                                      width: 330.w,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(image: CachedNetworkImageProvider(controller.userProfileModel.image!),fit: BoxFit.cover)
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 40.h,),
                                  // --- === name === ---
                                  Center(
                                      child: largeText(title: controller.userProfileModel.username,fontWeight: FontWeight.bold)),
                                  SizedBox(height: 15.h,),
                                  // --- === email === ---
                                  Center(child: smallText(title: controller.userProfileModel.email,)),
                                  SizedBox(height: 60.h,),
                                  // --- === Edit Profile Button === ---
                                  commonButton(
                                      buttonHeight: 37,
                                      buttonName: "Edit Profile",
                                      buttonColor: redColor,
                                      buttonWidth: 420.w,
                                      textColor: whiteColor,
                                       textSize: 12.5,
                                      onTap: () => Get.to(() => EditProfileScreen())
                                  )
                                ],
                              );
                            }
                          ),
                        ),
                        SizedBox(height: 90.h,),
                        Divider(height: 0.2.h,color: Colors.black12,),
                        //-------------------------------------------------
                        //     ------ ========== Bottom Section ======== ------
                        //-------------------------------------------------
                        SizedBox(height: 90.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              //-------------------------------------------------
                              //     ------ ========== Saved Designs section ======== ------
                              //-------------------------------------------------
                              // SizedBox(height: 90.h,),
                              // -- == section title == ---
                              Obx(
                                () => homeController.savedDesignDataList.isNotEmpty ? sectionTitleWidget(
                                  title: "Saved Designs",
                                  onTap: () => Get.to(() => SavedDesignsScreen())
                              ): Container()),
                              SizedBox(height: 50.h,),
                              Obx(
                                    () => homeController.savedDesignDataList.isNotEmpty ?  Container(
                                    color: Colors.transparent,
                                     height: 370.h,
                                     child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homeController.savedDesignDataList.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            savedAndDesignHistoryWidget(
                                                image: homeController.savedDesignDataList[index].frontImageOfDesign,
                                                name: homeController.savedDesignDataList[index].designName,
                                                onTap: () async {

                                                  homeController.selectedFrontImageOfOpenedDesign =  homeController.savedDesignDataList[index].frontImage;
                                                  homeController.selectedBackImageOfOpenedDesign =   homeController.savedDesignDataList[index].backImage;
                                                  homeController.selectedShirtNameOfOpenedDesign =   homeController.savedDesignDataList[index].designName;
                                                  homeController.selectedShirtTypeOfOpenedDesign =   homeController.savedDesignDataList[index].shirtType;
                                                  homeController.update();

                                                  //-=-= payment details =-=-
                                                  homeController.newDesignPrice = 0;
                                                  homeController.update();
                                                  homeController.newDesignPrice =  homeController.newDesignPrice! + homeController.savedDesignDataList[index].totalPrice!;
                                                  homeController.update();

                                                  openedDesignController.selectedColorsForShirt = homeController.savedDesignDataList[index].firstShirtColor;
                                                  openedDesignController.hexToColor();
                                                  openedDesignController.selectedColorsForShirtSecondImage = homeController.savedDesignDataList[index].secondShirtColor;
                                                  openedDesignController.hexToColorForSecondShort();

                                                  // --------= -=-=-= clear lists =-=-=- =--------
                                                  openedDesignController.stickerListFirstImageOfOD.clear();
                                                  openedDesignController.stickerListSecondImageOfOD.clear();
                                                  openedDesignController.imageListOfOd.clear();
                                                  openedDesignController.imageListSecondImageOfOd.clear();
                                                  openedDesignController.textListOfOd.clear();
                                                  openedDesignController.textListForSecondImageOfOd.clear();

                                                  openedDesignController.docID = homeController.savedDesignDataList[index].id;
                                                  openedDesignController.userID = homeController.savedDesignDataList[index].userId;
                                                  openedDesignController.designNameControllerOfOd.text = homeController.savedDesignDataList[index].designName!;

                                                  // --------= -=-=-= adding value to lists =-=-=- =--------
                                                  openedDesignController.stickerListFirstImageOfOD.addAll(homeController.savedDesignDataList[index].stickersOfFirstImage!);
                                                  openedDesignController.stickerListSecondImageOfOD.addAll(homeController.savedDesignDataList[index].stickersOfSecondImage!);

                                                  openedDesignController.imageListOfOd.addAll(homeController.savedDesignDataList[index].galleryImagesOfFirstImage!);
                                                  openedDesignController.imageListSecondImageOfOd.addAll(homeController.savedDesignDataList[index].galleryImagesOfSecondImage!);

                                                  openedDesignController.textListOfOd.addAll(homeController.savedDesignDataList[index].textsOfFirstImage!);
                                                  openedDesignController.textListForSecondImageOfOd.addAll(homeController.savedDesignDataList[index].textsOfSecondImage!);

                                                  homeController.popularityCountInt = homeController.savedDesignDataList[index].popularityCount;

                                                  int? popularityCount;
                                                  popularityCount = homeController.popularityCountInt! + 1;

                                                  openedDesignController.update();
                                                  await FirebaseFirestore.instance.collection("NewShirtDesign").doc(openedDesignController.docID).update({
                                                    "popularityCount" : popularityCount,
                                                  });

                                                  Get.to(() => OpenedDesignScreen());

                                                }
                                            ),
                                            SizedBox(width: 60.w,)
                                          ],
                                        );
                                      }),
                                ) : Container(),
                              ),
                              SizedBox(height: 30.h,),

                              //-------------------------------------------------
                              //     ------ ========== Order History section ======== ------
                              //-------------------------------------------------
                              // -- == section title == ---
                              Obx( () => orderController.orderHistoryList.isNotEmpty ? sectionTitleWidget(
                                  title: "Order History",
                                  onTap: () => Get.to(() => OrderHistoryScreen())
                               ) : Container() ),
                              SizedBox(height: 50.h,),
                              Obx( () =>orderController.orderHistoryList.isNotEmpty ?
                                    ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount: orderController.orderHistoryList.length,
                                      itemBuilder: (BuildContext context,int index){
                                        return Column(
                                          children: [
                                            // -=-==-=
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
                                                                      itemCount: orderController.orderHistoryList[index].productList!.length,
                                                                      itemBuilder: (BuildContext context,int inde){
                                                                      return Column(
                                                                        children: [
                                                                          Container(
                                                                              height: 365,
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
                                                                                      Image.network("${orderController.orderHistoryList[index].productList![inde].frontImage}",
                                                                                        fit: BoxFit.cover, width: 100,height: 140,),
                                                                                      Image.network("${orderController.orderHistoryList[index].productList![inde].backImage}",
                                                                                        fit: BoxFit.cover, width: 100,height: 140,),
                                                                                    ],),
                                                                                  ),
                                                                                SizedBox(height: 21,),
                                                                                textOrderWidget(
                                                                                  title: "Design Type",
                                                                                  value: "${orderController.orderHistoryList[index].productList![inde].designType}",
                                                                                ),
                                                                                SizedBox(height: 15,),
                                                                                textOrderWidget(
                                                                                  title: "Selected Size",
                                                                                  value: "${orderController.orderHistoryList[index].productList![inde].selectedSize}",
                                                                                ),
                                                                                SizedBox(height: 15,),
                                                                                textOrderWidget(
                                                                                  title: "Per Shirt Price",
                                                                                  value: "${orderController.orderHistoryList[index].productList![inde].perShirtPrice}",
                                                                                ),
                                                                                SizedBox(height: 15,),
                                                                                textOrderWidget(
                                                                                  title: "Selected Quantity",
                                                                                  value: "${orderController.orderHistoryList[index].productList![inde].selectedQuantity}",
                                                                                ),
                                                                                SizedBox(height: 15,),
                                                                                textOrderWidget(
                                                                                  title: "Total Price",
                                                                                  value: "${orderController.orderHistoryList[index].productList![inde].totalPrice}",
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
                                                              itemCount: orderController.orderHistoryList[index].productList!.length,
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
                                                                     child: Image.network(orderController.orderHistoryList[index].productList![inde].frontImage!,
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
                                                                title: orderController.orderHistoryList[index].deliveryTime,
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
                                                              title: "\$${orderController.orderHistoryList[index].deliveryCharge}",
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
                                                              title: "\$${orderController.orderHistoryList[index].payedAmount}",
                                                              textStyle: TextStyle(color: blackColor,
                                                                fontWeight: FontWeight.w600,fontSize: 15)
                                                            ),
                                                          ],),
                                                        SizedBox(height: 20,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                             commonButton(
                                                               buttonColor: orderController.orderHistoryList[index].status == false ?  Colors.red.shade400 : Colors.blue.shade500 ,
                                                               buttonName:  orderController.orderHistoryList[index].status == false ?  "Pending" : "Delivered",
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
                                    ) : Container())
                                ],),
                        ),
                    SizedBox(height: 20,),
                    ]);
              }
            )),
      ),
    );
  }

}
