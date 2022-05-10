import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/create_new_design_controller.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_image_controller.dart';

Widget frontTextEditorWidget(CreateNewDesignController controller) {
  FunctionalityOnImageController functionalityOnImageController = Get.put(FunctionalityOnImageController());
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
            functionalityOnImageController.flipCarController.state!.isFront ?
            controller.increaseFontSize() : controller.increaseFontSizeSecondImage();
          },
          // onPressed: increaseFontSize,
          tooltip: 'Increase font size',
        ),

        IconButton(
          icon: const Icon(
            Icons.remove,
            color: Colors.black,
          ),
          onPressed: () { functionalityOnImageController.flipCarController.state!.isFront ?
                         controller.decreaseFontSize() : controller.decreaseFontSizeSecondImage();
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
            functionalityOnImageController.flipCarController.state!.isFront ?
            controller.alignLeft() : controller.alignLeftSecondImage();
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
            functionalityOnImageController.flipCarController.state!.isFront
                ? controller.alignCenter()
                : controller.alignCenterSecondImage();
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
                 functionalityOnImageController.flipCarController.state!.isFront ?
                 controller.alignRight() : controller.alignRightSecondImage(); },
          tooltip: 'Align Right',
        ),
        IconButton(
          icon: const Icon(
            Icons.format_bold,
            color: Colors.black,
          ),
          onPressed: () {
            functionalityOnImageController.flipCarController.state!.isFront ?
            controller.boldText() : controller.boldTextSecondImage(); },
          // onPressed: boldText,
          tooltip: 'Bold',
        ),
        IconButton(
          icon: const Icon(
            Icons.format_italic,
            color: Colors.black,
          ),
          onPressed: () {
             functionalityOnImageController.flipCarController.state!.isFront ? controller.italicText() :
                        controller.italicTextSecondImage();
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
            functionalityOnImageController.flipCarController.state!.isFront ? controller.addLinesToText() :
           controller.addLinesToTextSecondImage();
            },
          // onPressed: addLinesToText,
          tooltip: 'Add New Line',
        ),
        Tooltip(
          message: 'Red',
          child: GestureDetector(
              onTap: () {
                functionalityOnImageController.flipCarController.state!.isFront ?
                    controller.changeTextColor(redHexColor) : controller.changeTextColorSecondImage(redHexColor); },
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
                functionalityOnImageController.flipCarController.state!.isFront ?
                controller.changeTextColor(whiteHexColor) : controller.changeTextColorSecondImage(whiteHexColor); },
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
                functionalityOnImageController.flipCarController.state!.isFront ?
                controller.changeTextColor(blackHexColor) : controller.changeTextColorSecondImage(blackHexColor); },
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
                functionalityOnImageController.flipCarController.state!.isFront ?
                controller.changeTextColor(blueHexColor) : controller.changeTextColorSecondImage(blueHexColor); },
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
                functionalityOnImageController.flipCarController.state!.isFront ?
                controller.changeTextColor(yellowHexColor) : controller.changeTextColorSecondImage(yellowHexColor); },
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
                functionalityOnImageController.flipCarController.state!.isFront ?
                controller.changeTextColor(greenHexColor) : controller.changeTextColorSecondImage(greenHexColor); },
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
                functionalityOnImageController.flipCarController.state!.isFront ?
                controller.changeTextColor(brownHexColor) : controller.changeTextColorSecondImage(brownHexColor); },
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
                functionalityOnImageController.flipCarController.state!.isFront ?
                controller.changeTextColor(purpleHexColor) : controller.changeTextColorSecondImage(purpleHexColor); },
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
Widget frontStickerEditorWidget(CreateNewDesignController controller) {
  FunctionalityOnImageController functionalityOnImageController = Get.put(FunctionalityOnImageController());
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
                functionalityOnImageController.flipCarController.state!.isFront ?
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
              onPressed: () { functionalityOnImageController.flipCarController.state!.isFront ?
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
Widget frontImageEditorWidget(CreateNewDesignController controller) {
  FunctionalityOnImageController functionalityOnImageController = Get.put(FunctionalityOnImageController());
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
            functionalityOnImageController.flipCarController.state!.isFront ?
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
          onPressed: () { functionalityOnImageController.flipCarController.state!.isFront ?
          controller.decreaseSizeOfImage() : controller.decreaseSizeOfImageSI();
          },
          // onPressed: decreaseFontSize,
          tooltip: 'Decrease font size',
        ),
      ],
    ),
  );
}



