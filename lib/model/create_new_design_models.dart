import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


// ---------------------========================-------------------------
//    ------------------ ==== Create new Design Model ==== ------------------
// ---------------------========================-------------------------

class NewShirtDesignModel {
  NewShirtDesignModel({
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
    this.textsOfSecondImage,
    this.frontImageOfDesign,
    this.currentDateTime,
    this.designName,
    this.shirtType,
    this.popularityCount,
    this.totalPrice
  });
  String? id;
  String? userId;
  String? frontImage;
  String? backImage;
  int? firstShirtColor;
  int? secondShirtColor;
  String? shirtType;
  String? designName;
  String? frontImageOfDesign;
  Timestamp? currentDateTime;
  List<ImageFromGalleryAndCamModel>? galleryImagesOfFirstImage;
  List<ImageFromGalleryAndCamModel>? galleryImagesOfSecondImage;
  List<StickerModel>? stickersOfFirstImage;
  List<StickerModel>? stickersOfSecondImage;
  List<TextModel>? textsOfFirstImage;
  List<TextModel>? textsOfSecondImage;
  int? popularityCount;
  double?  totalPrice;

  NewShirtDesignModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    userId = doc["userId"];
    popularityCount = doc["popularityCount"];
    frontImage = doc["frontImage"];
    backImage = doc["backImage"];
    firstShirtColor = doc["firstShirtColor"];
    secondShirtColor = doc["secondShirtColor"];
    shirtType = doc["shirtType"];
    designName = doc["designName"];
    currentDateTime = doc["currentDateTime"];
    galleryImagesOfFirstImage =  _imagesOfFirstImageItems(doc["galleryImagesOfFirstImage"] ?? []);
    galleryImagesOfSecondImage = _imagesOfSecondImageItems(doc["galleryImagesOfSecondImage"] ?? []);
    stickersOfFirstImage =   _stickersOfFirstImageItems(doc["stickersOfFirstImage"] ?? []);
    stickersOfSecondImage =   _stickersOfSecondImageItems(doc["stickersOfSecondImage"] ?? []);
    textsOfFirstImage = _textOfFirstImageItems(doc["textsOfFirstImage"] ?? []);
    textsOfSecondImage =   _textOfSecondImageItems(doc["textsOfSecondImage"] ?? []);
    frontImageOfDesign = doc["frontImageOfDesign"];
    totalPrice = doc["totalPrice"];

  }
  // ------= -=-== convert text of first image ==-=- =------
  List<TextModel> _textOfFirstImageItems(List textFromDB){
    List<TextModel> _result = [];
    if(textFromDB.isNotEmpty){
      for (var element in textFromDB) {
        _result.add(TextModel.fromMap(element));
      }
    }
    return _result;
  }

  // ------= -=-== convert text of second image ==-=- =------
  List<TextModel> _textOfSecondImageItems(List textFromDB){
    List<TextModel> _result = [];
    if(textFromDB.isNotEmpty){
      for (var element in textFromDB) {
        _result.add(TextModel.fromMap(element));
      }
    }
    return _result;
  }

  // ------= -=-== convert sticker of first image ==-=- =------
  List<StickerModel> _stickersOfFirstImageItems(List stickerFromDB){
    List<StickerModel> _result = [];
    if(stickerFromDB.isNotEmpty){
      for (var element in stickerFromDB) {
        _result.add(StickerModel.fromMap(element));
      }
    }
    return _result;
  }

  // ------= -=-== convert sticker of second image ==-=- =------
  List<StickerModel> _stickersOfSecondImageItems(List stickerFromDB){
    List<StickerModel> _result = [];
    if(stickerFromDB.isNotEmpty){
      for (var element in stickerFromDB) {
        _result.add(StickerModel.fromMap(element));
      }
    }
    return _result;
  }

  //    ------= -=-== convert images of first shirt image ==-=- =------
  List<ImageFromGalleryAndCamModel> _imagesOfFirstImageItems(List imagesOfShirtFromDB){
    List<ImageFromGalleryAndCamModel> _result = [];
    if(imagesOfShirtFromDB.isNotEmpty){
      for (var element in imagesOfShirtFromDB) {
        _result.add(ImageFromGalleryAndCamModel.fromMap(element));
      }
    }
    return _result;
  }

  //    ------= -=-== convert images of first shirt image ==-=- =------
  List<ImageFromGalleryAndCamModel> _imagesOfSecondImageItems(List imagesOfShirtFromDB){
    List<ImageFromGalleryAndCamModel> _result = [];
    if(imagesOfShirtFromDB.isNotEmpty){
      for (var element in imagesOfShirtFromDB) {
        _result.add(ImageFromGalleryAndCamModel.fromMap(element));
      }
    }
    return _result;
  }

}

// ---------------------====================================-------------------------
//    ------------------ ==== shirt Model  ==== ------------------
// ---------------------====================================-------------------------
class ShirtModel{
  String? frontImage;
  String? backImage;
  String? title;
  double? shirtPrice;

  ShirtModel({this.frontImage,this.title, this.backImage,this.shirtPrice});
}


// ---------------------=================================-------------------------
//    ------------------ ==== Color model use for text  ==== ------------------
// ---------------------=================================-------------------------
class ColorsModel {

  String? image;
  int? color;
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
  int? color;
  double? fontSize;
  FontWeight? fontWeight;
  FontStyle? fontStyle;
  TextAlign? textAlign;
  String? fontFamily;
  double? textPrice;

  TextModel(
      {
        this.fontSize,
        this.textAlign,
        this.fontStyle,
        this.fontWeight,
        this.fontFamily,
        this.color,
        this.top,
        this.text,
        this.left,
        this.textPrice
      });

  TextModel.fromMap(Map<String, dynamic> data){
    FontStyle? fontStylee;
    if(data["fontStyle"] == FontStyle.normal.toString()) {
      fontStylee = FontStyle.normal;
    } else if(data["fontStyle"] == FontStyle.italic.toString()) {
      fontStylee = FontStyle.italic;
    }

    TextAlign? textAlignn;
    if(data["textAlign"] == TextAlign.right.toString()) {
      textAlignn = TextAlign.right;
    } else if(data["textAlign"] == TextAlign.left.toString()) {
      textAlignn = TextAlign.left;
    } else{
      textAlignn = TextAlign.center;
    }

    FontWeight? fontWeightt;
    if(data["fontWeight"] == FontWeight.normal.toString()) {
      fontWeightt = FontWeight.normal;
    } else if(data["fontWeight"] == FontWeight.bold.toString()) {
      fontWeightt = FontWeight.bold;
    }

    fontSize = data["fontSize"];
    textAlign = textAlignn;
    left = data["left"];
    top = data["top"];
    fontStyle = fontStylee;
    fontWeight = fontWeightt;
    fontFamily = data["fontFamily"];
    color = data["color"];
    text = data["text"];
    textPrice = data["textPrice"];
  }

}

// ---------------------========================-------------------------
//    ------------------ ==== Sticker Model ==== ------------------
// ---------------------========================-------------------------

class StickerModel {

  String? sticker;
  double? left;
  double? top;
  String? title;
  double? stickerPrice;
  StickerModel({this.sticker,this.title,this.top,this.left,this.stickerPrice});

  StickerModel.fromMap(Map<String, dynamic> data){
    sticker = data["sticker"];
    left = data["left"];
    top = data["top"];
    title = data["title"];
    stickerPrice = data["stickerPrice"];
  }

}

// ---------------------========================-------------------------
//    ------------------ ==== Image From Gallery And Cam Model ==== ------------------
// ---------------------========================-------------------------
class ImageFromGalleryAndCamModel {

  File? image;
  double? left;
  double? top;
  String? imageUrl;
  double? imagePrice;

  ImageFromGalleryAndCamModel({
    this.image, this.imagePrice,
    this.top,this.left,this.imageUrl});

  ImageFromGalleryAndCamModel.fromMap(Map<String, dynamic> data){
    // image = data["image"];
    left = data["left"];
    top = data["top"];
    imageUrl = data["imageUrl"];
    imagePrice = data["imagePrice"];
  }

}