
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/create_new_design_controller.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_image_controller.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';

Widget frontTextEditorWidgetOfOd(OpenedDesignController controller) {
  FunctionalityOnOpenedDesignController functionalityOnImageController = Get.put(FunctionalityOnOpenedDesignController());
  return SizedBox(
    height: 60,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [

        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
            controller.increaseFontSizeOfOd() : controller.increaseFontSizeSecondImageOfOd();
          },
          // onPressed: increaseFontSize,
          tooltip: 'Increase font size',
        ),

        IconButton(
          icon: const Icon(
            Icons.remove,
            color: Colors.black,
          ),
          onPressed: () { functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
                         controller.decreaseFontSizeOfOd() : controller.decreaseFontSizeSecondImageOfOd();
          },
          // onPressed: decreaseFontSize,
          tooltip: 'Decrease font size',
        ),
        IconButton(
          icon: const Icon(
            Icons.format_align_left,
            color: Colors.black,
          ),
          onPressed: ()  {
            functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
            controller.alignLeftOfOd() : controller.alignLeftSecondImageOfOd();
          },
          // onPressed: alignLeft,
          tooltip: 'Align left',
        ),
        IconButton(
          icon: const Icon(
            Icons.format_align_center,
            color: Colors.black,
          ),
          onPressed: () {
            functionalityOnImageController.flipCarControllerOfOD.state!.isFront
                ? controller.alignCenterOfOd()
                : controller.alignCenterSecondImageOfOd();
          },
          // onPressed: alignCenter,
          tooltip: 'Align Center',
        ),
        IconButton(
          icon: const Icon(
            Icons.format_align_right,
            color: Colors.black,
          ),
          // onPressed: alignRight,
          onPressed: () {
                 functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
                 controller.alignRightOfOd() : controller.alignRightSecondImageOfOd(); },
          tooltip: 'Align Right',
        ),
        IconButton(
          icon: const Icon(
            Icons.format_bold,
            color: Colors.black,
          ),
          onPressed: () {
            functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
            controller.boldTextOfOd() : controller.boldTextSecondImageOfOd(); },
          // onPressed: boldText,
          tooltip: 'Bold',
        ),
        IconButton(
          icon: const Icon(
            Icons.format_italic,
            color: Colors.black,
          ),
          onPressed: () {
             functionalityOnImageController.flipCarControllerOfOD.state!.isFront ? controller.italicTextOfOd() :
                        controller.italicTextSecondImageOfOd();
             },
          // onPressed: italicText,
          tooltip: 'Italic',
        ),
        IconButton(
          icon: const Icon(
            Icons.space_bar,
            color: Colors.black,
          ),
          onPressed: () {
            functionalityOnImageController.flipCarControllerOfOD.state!.isFront ? controller.addLinesToTextOfOd() :
           controller.addLinesToTextSecondImageOfOd();
            },
          // onPressed: addLinesToText,
          tooltip: 'Add New Line',
        ),
        Tooltip(
          message: 'Red',
          child: GestureDetector(
              onTap: () {
                functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
                    controller.changeTextColorOfOd(redHexColor) : controller.changeTextColorSecondImageOfOd(redHexColor); },
              child: const CircleAvatar(
                backgroundColor: Colors.red,
              )),
        ),
        const SizedBox(
          width: 5,
        ),
        Tooltip(
          message: 'White',
          child: GestureDetector(
              onTap: () {
                functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
                controller.changeTextColorOfOd(whiteHexColor) : controller.changeTextColorSecondImageOfOd(whiteHexColor); },
              child: const CircleAvatar(
                backgroundColor: Colors.white,
              )),
        ),
        const SizedBox(
          width: 5,
        ),
        Tooltip(
          message: 'Black',
          child: GestureDetector(
              onTap: (){
                functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
                controller.changeTextColorOfOd(blackHexColor) : controller.changeTextColorSecondImageOfOd(blackHexColor); },
              child: const CircleAvatar(
                backgroundColor: Colors.black,
              )),
        ),
        const SizedBox(
          width: 5,
        ),
        Tooltip(
          message: 'Blue',
          child: GestureDetector(
              onTap: () {
                functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
                controller.changeTextColorOfOd(blueHexColor) : controller.changeTextColorSecondImageOfOd(blueHexColor); },
              child: const CircleAvatar(
                backgroundColor: Colors.blue,
              )),
        ),
        const SizedBox(
          width: 5,
        ),
        Tooltip(
          message: 'Yellow',
          child: GestureDetector(
              onTap: () {
                functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
                controller.changeTextColorOfOd(yellowHexColor) : controller.changeTextColorSecondImageOfOd(yellowHexColor); },
              child: const CircleAvatar(
                backgroundColor: Colors.yellow,
              )),
        ),
        const SizedBox(
          width: 5,
        ),
        Tooltip(
          message: 'Green',
          child: GestureDetector(
              onTap: () {
                functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
                controller.changeTextColorOfOd(greenHexColor) : controller.changeTextColorSecondImageOfOd(greenHexColor); },
              child: const CircleAvatar(
                backgroundColor: Colors.green,
              )),
        ),
        const SizedBox(
          width: 5,
        ),
        Tooltip(
          message: 'Brown',
          child: GestureDetector(
              onTap: (){
                functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
                controller.changeTextColorOfOd(brownHexColor) : controller.changeTextColorSecondImageOfOd(brownHexColor); },
              child: const CircleAvatar(
                backgroundColor: Colors.brown,
              )),
        ),
        const SizedBox(
          width: 5,
        ),
        Tooltip(
          message: 'Purple',
          child: GestureDetector(
              onTap: () {
                functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
                controller.changeTextColorOfOd(purpleHexColor) : controller.changeTextColorSecondImageOfOd(purpleHexColor); },
              child: const CircleAvatar(
                backgroundColor: Colors.purple,
              )),
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    ),
  );
}

// -=-=-============-=-= sticker editor =-=-==============-=-=-=
Widget frontStickerEditorWidgetOfOd(OpenedDesignController controller) {
  FunctionalityOnOpenedDesignController functionalityOnImageController = Get.put(FunctionalityOnOpenedDesignController());

  return SizedBox(
    height: 60,
    child:
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
            controller.increaseSizeOfSticker() : controller.increaseSizeOfStickerSI();
          },
          // onPressed: increaseFontSize,
          tooltip: 'Increase font size',
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
          icon: const Icon(
            Icons.remove,
            color: Colors.black,
          ),
          onPressed: () { functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
          controller.decreaseSizeOfSticker() : controller.decreaseSizeOfStickerSI();
          },
          // onPressed: decreaseFontSize,
          tooltip: 'Decrease font size',
        ),
      ],
    ),
  );
}

// -=-=-============-=-= image editor =-=-==============-=-=-=
Widget frontImageEditorWidgetOfOd(OpenedDesignController controller) {
  FunctionalityOnOpenedDesignController functionalityOnImageController = Get.put(FunctionalityOnOpenedDesignController());

  return SizedBox(
    height: 60,
    child:
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
            controller.increaseSizeOfImage() : controller.increaseSizeOfImageSI();
          },
          // onPressed: increaseFontSize,
          tooltip: 'Increase font size',
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
          icon: const Icon(
            Icons.remove,
            color: Colors.black,
          ),
          onPressed: () { functionalityOnImageController.flipCarControllerOfOD.state!.isFront ?
          controller.decreaseSizeOfImage() : controller.decreaseSizeOfImageSI();
          },
          // onPressed: decreaseFontSize,
          tooltip: 'Decrease font size',
        ),
      ],
    ),
  );
}
