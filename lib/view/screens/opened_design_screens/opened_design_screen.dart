import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/controller/shipping_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/opened_design_screens/back_image_of_opened_design_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/opened_design_screens/front_image_of_opened_design_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/create_new_design_widgets/create_new_design_screen_widget.dart';
import 'package:ifreshoriginals_userapp/view/widgets/create_new_design_widgets/front_image_text_editor_widget.dart';
import 'package:ifreshoriginals_userapp/view/widgets/home_screen_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/view/widgets/opened_design_screen_widgets/front_image_text_editor_widget_of_od.dart';
import 'package:ifreshoriginals_userapp/view/widgets/opened_design_screen_widgets/shirt_color_alert_dialog_widget_of_Od.dart';
import 'package:ifreshoriginals_userapp/view/widgets/opened_design_screen_widgets/sticker_generate_alert_dialog_second_image_Of_Od.dart';
import 'package:ifreshoriginals_userapp/view/widgets/opened_design_screen_widgets/sticker_generate_alert_dialog_widget_of_OD.dart';
import 'package:ifreshoriginals_userapp/view/widgets/opened_design_screen_widgets/text_generate_alert_dialog_widget_of_od.dart';
import 'package:ifreshoriginals_userapp/view/widgets/opened_design_screen_widgets/text_generate_alert_dialog_widget_second_image_of_od.dart';
import '../../../controller/functionality_on_opened_design_controller.dart';
import '../../../controller/home_controller.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import '../../widgets/opened_design_screen_widgets/image_picker_alert_dialog_widget_of_od.dart';
import '../../widgets/opened_design_screen_widgets/image_picker_alert_dialog_widget_second_image_of_od.dart';
import '../../widgets/opened_design_screen_widgets/opened_design_screen_widget.dart';
import '../../widgets/opened_design_screen_widgets/shirt_color_alert_dialog_widget_second_image_Of_Od.dart';


class OpenedDesignScreen extends StatelessWidget{
  OpenedDesignScreen({Key? key}) : super(key: key);

  final OpenedDesignController openedDesignController = Get.put(OpenedDesignController());
  final HomeController homeController = Get.put(HomeController());
  final FunctionalityOnOpenedDesignController functionalityOnOpenedDesignController = Get.put(FunctionalityOnOpenedDesignController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(
          title: "${homeController.selectedShirtTypeOfOpenedDesign}",
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
          child: GetBuilder<OpenedDesignController>(
              init: OpenedDesignController(),
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    controller.textSelectedOfOd = false;
                    controller.stickerSelected = false;
                    controller.imageSelected = false;
                    controller.update();
                  },
                  child: Column(children: [

                    // -----------------------------------------------------
                    // -----=--======= save image function ========--=-----
                    // -----------------------------------------------------
                    controller.textSelectedOfOd == true ? frontTextEditorWidgetOfOd(controller)  :
                    controller.stickerSelected == true ? frontStickerEditorWidgetOfOd(controller)  :
                    controller.imageSelected == true ? frontImageEditorWidgetOfOd(controller) :
                     saveImageWidgetOfOpenedDesign(context) ,

                    SizedBox(height: 30.h,),
                    // -----------------------------------------------------
                    // -----=--======= Shirt Imagessss  ========--=-----
                    // -----------------------------------------------------
                    GetBuilder<OpenedDesignController>(
                        init: OpenedDesignController(),
                        builder: (controller) {
                          return  Container(
                            height: 400,
                            width: 1.sw,
                            color: Color(0xffE2E2E2),
                            child: Center(
                                child: InteractiveViewer(
                                  transformationController: functionalityOnOpenedDesignController.interactiveViewerControllerOfOD,
                                  child:  FlipCard(
                                    rotateSide: RotateSide.right,
                                    onTapFlipping: false,
                                    axis: FlipAxis.vertical,
                                    controller: functionalityOnOpenedDesignController.flipCarControllerOfOD,
                                    // -----------------------------------------------------
                                    // -----=--======= front image of Shirt ========--=-----
                                    // -----------------------------------------------------
                                    frontWidget: frontImageOfOpenedDesign(context),
                                    // -----------------------------------------------------
                                    // -----=--======= back image of Shirt ========--=-----
                                    // -----------------------------------------------------
                                    backWidget: backImageOfOpenedDesign(context),
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
                          zoomAndChangeImageSideWidgetOfOpenedDesign(),
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
                                            return  functionalityOnOpenedDesignController.flipCarControllerOfOD.state!.isFront ?
                                            shirtColorAlertDialogWidgetOfOd() :  shirtColorAlertDialogWidgetSecondImageOfOd();
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
                                            return functionalityOnOpenedDesignController.flipCarControllerOfOD.state!.isFront ?
                                            imagePickerAlertDialogWidgetOfOd() : imagePickerAlertDialogWidgetSecondImageOfOd();
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
                                            return functionalityOnOpenedDesignController.flipCarControllerOfOD.state!.isFront ?
                                            stickerGenerateAlertDialogOfOD() : stickerGenerateAlertDialogSecondImageOfOd();
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
                                            return functionalityOnOpenedDesignController.flipCarControllerOfOD.state!.isFront ?
                                            textGenerateAlertDialogWidgetOfOd() :    textGenerateAlertDialogWidgetSecondImageOfOd();
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
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: commonButton(
                                  buttonName: "Proceed",
                                  textColor: whiteColor,
                                  onTap: () {
                                    controller.calculationFun();
                                    functionalityOnOpenedDesignController.getByteImagesOfOD(
                                        openedDesignController);
                                  },
                                  buttonColor: redColor,
                                  buttonWidth: 1.sw
                              ),
                            );
                          }),
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