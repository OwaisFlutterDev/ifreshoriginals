import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/view/screens/shipping_screens/select_size_and_quantity_screen_for_OD.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:widget_to_image/widget_to_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../view/widgets/common_widgets.dart';

class FunctionalityOnOpenedDesignController extends GetxController{
  bool imageSideOfOIBool = false;

  //  ==========================================================================
  //   ------- === --- == ---- flip image controller ---- == --- === ----------
  //  ==========================================================================
  final flipCarControllerOfOD = FlipCardController();


  //  ====================================================================================
  //     ------- === --- == ---- Zoom controller and Functions ---- == --- === --------
  //  ====================================================================================
  TransformationController  interactiveViewerControllerOfOD = TransformationController();
  TransformationController  interactiveViewerTwoControllerOfOD = TransformationController();

  zoomInOfOD() {
    double  scale = 2;
    final zoomed = Matrix4.identity()..scale(scale);
    final value = zoomed;

    interactiveViewerControllerOfOD.value = value;
    update();
  }

  zoomOutOfOD() {
    // const double  scale = 0;
    final zoomed = Matrix4.identity();
    final value = zoomed;

    interactiveViewerControllerOfOD.value = value;
    update();
  }


  zoomInForSelectedSizeAndQuaOfOD() {
    double  scale = 2;
    final zoomed = Matrix4.identity()..scale(scale);
    final value = zoomed;

    interactiveViewerTwoControllerOfOD.value = value;
    update();
  }

  zoomOutForSelectedSizeAndQuaOfOD() {
    // const double  scale = 0;
    final zoomed = Matrix4.identity();
    final value = zoomed;

    interactiveViewerTwoControllerOfOD.value = value;
    update();
  }

//  =========================================================================================
//     ------- === --- == ---- Save Image Function And Controller ---- == --- === --------
//  =========================================================================================

  ScreenshotController screenshotControllerOfOD = ScreenshotController();
  ScreenshotController screenshotControllerForSelectedSAQOfOD = ScreenshotController();


  saveImageOfOD(context) async {

    final image = await screenshotControllerForSelectedSAQOfOD.capture();
    print(image.toString());
    await saveImageToGalleryOfOD(image!);
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
  Future<String>  saveImageToGalleryOfOD(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String().replaceAll('.', '-')..replaceAll(':', '-');
    final name = "ss_$time";
    print(time);

    final result = await ImageGallerySaver.saveImage(bytes,name: name);
    return result['filePath'].toString();

  }

//  ==============================================================================================================
//     ------- === --- == ---- byte image and function for selected size and quantity screen ---- == --- === --------
//  ==================================================================================================================

  ByteData? frontByteImageOfOD;
  ByteData? backByteImageOfOD;
  GlobalKey? frontGlobalKeyOfOD = GlobalKey();
  GlobalKey? backGlobalKeyOfOD = GlobalKey();

  getByteImagesOfOD(controller) async {

    if(flipCarControllerOfOD.state!.isFront  ) {
      ByteData frontImage = await WidgetToImage.repaintBoundaryToImage(frontGlobalKeyOfOD!);
      // final frontImage = await frontImageScreenshotController.capture();
      frontByteImageOfOD =  frontImage;
      // print("frontImage");
      // update();

      await flipCarControllerOfOD.flipcard();

      ByteData backImage = await WidgetToImage.repaintBoundaryToImage(backGlobalKeyOfOD!);
      // final backImage = await backImageScreenshotController.capture();
      backByteImageOfOD =  backImage;
      // print("BackImage");

      update();
      // print("after update");
      Get.to(() => SelectSizeAndQuantityScreenForOD());
    }
    else if (flipCarControllerOfOD.state!.isFront == false) {

      ByteData backImage = await WidgetToImage.repaintBoundaryToImage(backGlobalKeyOfOD!);
      // final backImage = await backImageScreenshotController.capture();
      backByteImageOfOD =  backImage;
      // print("BackImage");

      await flipCarControllerOfOD.flipcard();

      ByteData frontImage = await WidgetToImage.repaintBoundaryToImage(frontGlobalKeyOfOD!);
      // final frontImage = await frontImageScreenshotController.capture();
      frontByteImageOfOD =  frontImage;
      // print("frontImage");

      update();
      // print("after update");
      Get.to(() => SelectSizeAndQuantityScreenForOD());
    }

  }

}