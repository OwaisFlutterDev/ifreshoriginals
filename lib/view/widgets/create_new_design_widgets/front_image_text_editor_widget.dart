
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            functionalityOnImageController .flipCarController.state!.isFront ? controller.addLinesToText() :
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
                    controller.changeTextColor(Colors.red) : controller.changeTextColorSecondImage(Colors.red); },
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
                controller.changeTextColor(Colors.white) : controller.changeTextColorSecondImage(Colors.white); },
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
                controller.changeTextColor(Colors.black) : controller.changeTextColorSecondImage(Colors.black); },
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
                controller.changeTextColor(Colors.blue) : controller.changeTextColorSecondImage(Colors.blue); },
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
                controller.changeTextColor(Colors.yellow) : controller.changeTextColorSecondImage(Colors.yellow); },
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
                controller.changeTextColor(Colors.green) : controller.changeTextColorSecondImage(Colors.green); },
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
                controller.changeTextColor(Colors.brown) : controller.changeTextColorSecondImage(Colors.brown); },
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
                controller.changeTextColor(Colors.purple) : controller.changeTextColorSecondImage(Colors.purple); },
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