import 'dart:io';

import 'package:flutter/material.dart';


// ---------------------====================================-------------------------
//    ------------------ ==== Create New Design Model  ==== ------------------
// ---------------------====================================-------------------------
class CreateNewDesignModel{
  String? frontImage;
  String? backImage;
  String? title;

  CreateNewDesignModel({this.frontImage,this.title, this.backImage});
}


// ---------------------=================================-------------------------
//    ------------------ ==== Color model use for text  ==== ------------------
// ---------------------=================================-------------------------
class ColorsModel {

  String? image;
  Color? color;
  String? name;

  ColorsModel({this.image,this.color,this.name});
}

// ---------------------========================-------------------------
//    ------------------ ==== Text Model ==== ------------------
// ---------------------========================-------------------------

class TextModel {
  String? text;
  double? left;
  double? top;
  Color? color;
  FontWeight? fontWeight;
  FontStyle? fontStyle;
  double fontSize;
  TextAlign? textAlign;

  TextModel(
      {
      required this.fontSize,
      this.textAlign,
      this.fontStyle,
      this.fontWeight,
      this.color,
      this.top,
      this.text,
      this.left,
      });

}

// ---------------------========================-------------------------
//    ------------------ ==== Sticker Model ==== ------------------
// ---------------------========================-------------------------

class StickerModel {

  String? sticker;
  double? left;
  double? top;
  String? title;

  StickerModel({this.sticker,this.title,this.top,this.left});
}

// ---------------------========================-------------------------
//    ------------------ ==== Shirt Color Model ==== ------------------
// ---------------------========================-------------------------
class ImageFromGalleryAndCamModel {

  File? image;
  double? left;
  double? top;

  ImageFromGalleryAndCamModel({this.image,this.top,this.left});
}