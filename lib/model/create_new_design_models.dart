import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


// ---------------------========================-------------------------
//    ------------------ ==== Create new Design Model ==== ------------------
// ---------------------========================-------------------------

class UserProfileModel {
  UserProfileModel({
    this.id,
    this.userId,
    this.frontImage,
    this.backImage,
    this.firstShirtColor,
    this.secondShirtColor,
    this.galleryImagesOfFirstImage,
    this.galleryImagesOfSecondImage,
    this.stickersOfFirstImage,
    this.stickersOfSecondImage,
    this.textsOfFirstImage,
    this.textsOfSecondImage
  });
  String? id;
  String? userId;
  String? frontImage;
  String? backImage;
  String? firstShirtColor;
  String? secondShirtColor;
  String? shirtType;
  String? designName;
  DateTime? currentDateTime;
  List? galleryImagesOfFirstImage;
  List? galleryImagesOfSecondImage;
  List? stickersOfFirstImage;
  List? stickersOfSecondImage;
  List? textsOfFirstImage;
  List? textsOfSecondImage;

  UserProfileModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    userId = doc["userId"];
    frontImage = doc["frontImage"];
    backImage = doc["backImage"];
    firstShirtColor = doc["firstShirtColor"];
    secondShirtColor = doc["secondShirtColor"];
    shirtType = doc["shirtType"];
    designName = doc["designName"];
    currentDateTime = doc["currentDateTime"];
    galleryImagesOfFirstImage = doc["galleryImagesOfFirstImage"];
    galleryImagesOfSecondImage = doc["galleryImagesOfSecondImage"];
    stickersOfFirstImage = doc["stickersOfFirstImage"];
    stickersOfSecondImage = doc["stickersOfSecondImage"];
    textsOfFirstImage = doc["textsOfFirstImage"];
    textsOfSecondImage = doc["textsOfSecondImage"];
  }
}

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

// ---------------------=================================-------------------------
//    ------------------ ==== Font Family model use for text  ==== ------------------
// ---------------------=================================-------------------------
class FontFamilyModel {

  String? name;

  FontFamilyModel({this.name});
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
  String? fontFamily;


  TextModel(
      {
        required this.fontSize,
        this.textAlign,
        this.fontStyle,
        this.fontWeight,
        this.fontFamily,
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