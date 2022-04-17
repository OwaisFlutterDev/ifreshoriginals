import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/create_new_design_controller.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_image_controller.dart';
import 'package:ifreshoriginals_userapp/controller/shipping_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/create_new_design_screens/front_image_of_new_design.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/create_new_design_widgets/create_new_design_screen_widget.dart';
import 'package:ifreshoriginals_userapp/view/widgets/create_new_design_widgets/front_image_text_editor_widget.dart';
import 'package:ifreshoriginals_userapp/view/widgets/create_new_design_widgets/image_picker_alert_dialog_widget_second_image.dart';
import 'package:ifreshoriginals_userapp/view/widgets/create_new_design_widgets/shirt_color_alert_dialog_widget.dart';
import 'package:ifreshoriginals_userapp/view/widgets/create_new_design_widgets/shirt_color_alert_dialog_widget_second_image.dart';
import 'package:ifreshoriginals_userapp/view/widgets/create_new_design_widgets/sticker_generate_alert_dialog_second_image.dart';
import 'package:ifreshoriginals_userapp/view/widgets/create_new_design_widgets/sticker_generate_alert_dialog_widget.dart';
import 'package:ifreshoriginals_userapp/view/widgets/create_new_design_widgets/text_generate_alert_dialog_widget.dart';
import 'package:ifreshoriginals_userapp/view/widgets/create_new_design_widgets/text_generate_alert_dialog_widget_second_image.dart';
import 'package:ifreshoriginals_userapp/view/widgets/home_screen_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controller/home_controller.dart';
import '../../widgets/create_new_design_widgets/image_picker_alert_dialog_widget.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'back_image_of_new_design.dart';


class CreateNewDesignScreen extends StatelessWidget{
  CreateNewDesignScreen({Key? key}) : super(key: key);

  final CreateNewDesignController createNewDesignController = Get.put(CreateNewDesignController());
  final HomeController homeController = Get.put(HomeController());
  final FunctionalityOnImageController functionalityOnImageController = Get.put(FunctionalityOnImageController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(
        title: "${homeController.selectedDesignType}",
          leadingWidget: InkWell(
            onTap: () {
              Get.back();
            } ,
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
          child: GetBuilder<CreateNewDesignController>(
            init: CreateNewDesignController(),
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  controller.textSelected = false;
                  controller.update();
                },
                child: Column(children: [

                  // -----------------------------------------------------
                  // -----=--======= save image function ========--=-----
                  // -----------------------------------------------------
                  controller.textSelected == false ? saveImageWidget(context) :
                   frontTextEditorWidget(controller),

                  SizedBox(height: 30.h,),
                  // -----------------------------------------------------
                  // -----=--======= Shirt Imagessss  ========--=-----
                  // -----------------------------------------------------
                  GetBuilder<CreateNewDesignController>(
                    init: CreateNewDesignController(),
                    builder: (controller) {
                      return  Container(
                          height: 340,
                          width: 1.sw,
                          color: Color(0xffE2E2E2),
                          child: Center(
                            child: InteractiveViewer(
                              transformationController: functionalityOnImageController.interactiveViewerController,
                              child:  FlipCard(
                                rotateSide: RotateSide.right,
                                onTapFlipping: false,
                                axis: FlipAxis.vertical,
                                controller: functionalityOnImageController.flipCarController,
                                // -----------------------------------------------------
                                // -----=--======= front image of Shirt ========--=-----
                                // -----------------------------------------------------
                                frontWidget: frontImageOfNewDesign(context),
                                // -----------------------------------------------------
                                // -----=--======= back image of Shirt ========--=-----
                                // -----------------------------------------------------
                                backWidget: backImageOfNewDesign(context),
                              ),
                            )

                          ),
                        );
                    }
                  ),

                  // -----------------------------------------------------
                  // -----=--======= below image section ========--=-----
                  // -----------------------------------------------------
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        // ----======= zoom in , zoom out & change image side  ========----
                        zoomAndChangeImageSideWidget(),
                        // -----=--======= below image section ========--=-----
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 40.w,),
                            largeText(title: "Add Something",color: blackColor, fontWeight: FontWeight.w500),
                          ],
                        ),
                        SizedBox(height: 30.h,),
                        // ------=======  color, text, sticker and image buttons  ========------
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              // -- == color button
                              imageButton(
                                title: "Color",
                                image:"assets/Asset 42.png",
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return  functionalityOnImageController.flipCarController.state!.isFront ?
                                        shirtColorAlertDialogWidget() :  shirtColorAlertDialogWidgetSecondImage();
                                      });
                                }
                              ),
                              // -- == Image button
                              imageButton(
                                  title: "Image",
                                  image:"assets/Asset 43.png",
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return functionalityOnImageController.flipCarController.state!.isFront ?
                                            imagePickerAlertDialogWidget() : imagePickerAlertDialogWidgetSecondImage();
                                        });
                                  }
                              ),
                              // -- == Sticker button
                              imageButton(
                                  title: "Sticker",
                                  image:"assets/Asset 44.png",
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return functionalityOnImageController.flipCarController.state!.isFront ?
                                          stickerGenerateAlertDialog() : stickerGenerateAlertDialogSecondImage();
                                        });
                                  }
                              ),
                              // -- == color button
                              imageButton(
                                  title: "Text",
                                  image:"assets/Asset 45.png",
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return functionalityOnImageController.flipCarController.state!.isFront ?
                                            textGenerateAlertDialogWidget() :    textGenerateAlertDialogWidgetSecondImage();
                                        });
                                  }
                              ),
                          ],),
                        ),
                        SizedBox(height: 70.h,),

                        // -----------------------------------------------------
                        // -----=--======= Proceed Button ========--=-----
                        // -----------------------------------------------------
                        GetBuilder<ShippingController>(
                          init: ShippingController() ,
                          builder: (controller) {
                            return Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                                  child: commonButton(
                                    buttonName: "Proceed",
                                    textColor: whiteColor,
                                    onTap: (){
                                      controller.calculationFun();
                                      functionalityOnImageController.createDesignBool = true;
                                      functionalityOnImageController.update();
                                      functionalityOnImageController.getByteImages(createNewDesignController);

                                      },
                                    buttonColor: redColor,
                                    buttonWidth: 1.sw
                                  ),
                                );
                          }
                        )
                      ],
                    ),
                  ),
                   SizedBox(height: 50.h,)
                ],),
              );
            }
          )
          ,),),
    );
  }
}