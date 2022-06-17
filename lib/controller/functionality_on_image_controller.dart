
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:widget_to_image/widget_to_image.dart';
import '../view/screens/shipping_screens/select_size_and_quantity_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../view/widgets/common_widgets.dart';

class FunctionalityOnImageController extends GetxController{

  // bool createDesignBool = false;
   bool imageSideBool = false;

  //  ==========================================================================
  //   ------- === --- == ---- flip image controller ---- == --- === ----------
  //  ==========================================================================
  final flipCarController = FlipCardController();


  //  ====================================================================================
  //     ------- === --- == ---- Zoom controller and Functions ---- == --- === --------
  //  ====================================================================================
  TransformationController  interactiveViewerController = TransformationController();
  TransformationController  interactiveViewerTwoController = TransformationController();

  zoomIn() {
    double  scale = 2;
    final zoomed = Matrix4.identity()..scale(scale);
    final value = zoomed;

    interactiveViewerController.value = value;
    update();
  }

  zoomOut() {
    // const double  scale = 0;
    final zoomed = Matrix4.identity();
    final value = zoomed;

    interactiveViewerController.value = value;
    update();
  }


  zoomInForSelectedSizeAndQua() {
    double  scale = 2;
    final zoomed = Matrix4.identity()..scale(scale);
    final value = zoomed;

    interactiveViewerTwoController.value = value;
    update();
  }

  zoomOutForSelectedSizeAndQua() {
    // const double  scale = 0;
    final zoomed = Matrix4.identity();
    final value = zoomed;

    interactiveViewerTwoController.value = value;
    update();
  }

//  =========================================================================================
//     ------- === --- == ---- Save Image Function And Controller ---- == --- === --------
//  =========================================================================================

  ScreenshotController screenshotController = ScreenshotController();
  ScreenshotController screenshotControllerForSelectedSAQ = ScreenshotController();


  saveImage(context) async {

    final image = await screenshotControllerForSelectedSAQ.capture();
    await saveImageToGallery(image!);
    update();
    //  ---- === SnackBar === ----
    final snackBar =  SnackBar(
      content:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          smallText(title: "Image Saved To Gallery",color: whiteColor),
          Icon(Icons.download_done_sharp,size: 70.r, color: whiteColor,)
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
  // --= =-----===  Save Image To Gallery  ===------= =--
  Future<String>  saveImageToGallery(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
       .toIso8601String().replaceAll('.', '-')..replaceAll(':', '-');
    final name = "ss_$time";

    final result = await ImageGallerySaver.saveImage(bytes,name: name);
    return result['filePath'].toString();

  }

//  ==============================================================================================================
//     ------- === --- == ---- byte image and function for selected size and quantity screen ---- == --- === --------
//  ==================================================================================================================

  ByteData? frontByteImage;
  ByteData? backByteImage;
  GlobalKey? frontGlobalKey = GlobalKey();
  GlobalKey? backGlobalKey = GlobalKey();

  getByteImages(controller) async {

    if(flipCarController.state!.isFront  ) {
       ByteData frontImage = await WidgetToImage.repaintBoundaryToImage(frontGlobalKey!);
      // final frontImage = await frontImageScreenshotController.capture();
      frontByteImage =  frontImage;
      // print("frontImage");
      // update();

      await flipCarController.flipcard();

      ByteData backImage = await WidgetToImage.repaintBoundaryToImage(backGlobalKey!);
      // final backImage = await backImageScreenshotController.capture();
      backByteImage =  backImage;
      // print("BackImage");

      update();
      // print("after update");
      Get.to(() => SelectSizeAndQuantityScreen());
    }
    else if (flipCarController.state!.isFront == false) {

      ByteData backImage = await WidgetToImage.repaintBoundaryToImage(backGlobalKey!);
      // final backImage = await backImageScreenshotController.capture();
      backByteImage =  backImage;
      // print("BackImage");

      await flipCarController.flipcard();

      ByteData frontImage = await WidgetToImage.repaintBoundaryToImage(frontGlobalKey!);
      // final frontImage = await frontImageScreenshotController.capture();
      frontByteImage =  frontImage;
      // print("frontImage");

      update();
      // print("after update");
      Get.to(() => SelectSizeAndQuantityScreen());
    }


    // final frontImage = await screenshotController.captureFromWidget(
    //                               frontImageOfNewDesign(controller, Get.context!));
    //
    // final backImage = await screenshotController.captureFromWidget(
    //                               backImageOfNewDesign(controller, Get.context));

    // frontByteImage =  frontImage;
    // backByteImage =  backImage;

  }

}