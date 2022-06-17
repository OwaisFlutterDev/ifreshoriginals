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
  int?  totalPrice;

  // NewShirtDesignModel.fromJson(Map<String, Object?> json)
  //     : this(
  //   id: json['id']! as String,
  //   userId: json['userId']! as String,
  //   popularityCount : json['popularityCount']! as int,
  //   frontImage : json['frontImage']! as String,
  //   backImage : json['backImage']! as String,
  //   firstShirtColor : json['firstShirtColor']! as int,
  //   secondShirtColor: json['secondShirtColor']! as int,
  //   shirtType : json['shirtType']! as String,
  //   designName : json['designName']! as String,
  //   currentDateTime : json['currentDateTime']! as Timestamp,
  //   frontImageOfDesign : json['frontImageOfDesign']! as String,
  //   totalPrice : json['totalPrice']! as double,
  //   galleryImagesOfFirstImage: (json["galleryImagesOfFirstImage"]! ?? []) as List<ImageFromGalleryAndCamModel>? ,
  //   galleryImagesOfSecondImage: _imagesOfSecondImageItems(doc["galleryImagesOfSecondImage"] ?? []),
  //   // stickersOfFirstImage =   _stickersOfFirstImageItems(doc["stickersOfFirstImage"] ?? []),
  //   // stickersOfSecondImage =   _stickersOfSecondImageItems(doc["stickersOfSecondImage"] ?? []),
  //   // textsOfFirstImage = _textOfFirstImageItems(doc["textsOfFirstImage"] ?? []),
  //   // textsOfSecondImage =   _textOfSecondImageItems(doc["textsOfSecondImage"] ?? []),
  // );

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

  Map<String, Object?> toJson() {
    return {
      'id': id,
      "userId" : userId,
      "popularityCount": popularityCount,
      "frontImage": frontImage,
      "backImage":backImage,
      "firstShirtColor": firstShirtColor,
      "secondShirtColor" :secondShirtColor,
      "shirtType" :shirtType,
      "designName" :designName,
      "currentDateTime" :currentDateTime,
      "frontImageOfDesign": frontImageOfDesign,
      "totalPrice": totalPrice,
      "galleryImagesOfFirstImage" :galleryImagesOfFirstImage,
      "galleryImagesOfSecondImage": galleryImagesOfSecondImage,
      "stickersOfFirstImage" :   stickersOfFirstImage,
      "stickersOfSecondImage" :  stickersOfSecondImage,
      "textsOfFirstImage" : textsOfFirstImage,
      "textsOfSecondImage" :  textsOfSecondImage,
    };
  }
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



// ---------------------====================================-------------------------
//    ------------------ ==== shirt Model  ==== ------------------
// ---------------------====================================-------------------------
class ShirtModel{
  String? frontImage;
  String? backImage;
  String? title;
  int? shirtPrice;

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
  int? textPrice;

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
  int? stickerPrice;
  double? stickerHeight;
  double? stickerWeight;
  StickerModel({this.sticker,this.title,this.top,this.left,this.stickerPrice,this.stickerHeight,this.stickerWeight});

  StickerModel.fromMap(Map<String, dynamic> data){
    sticker = data["sticker"];
    stickerHeight = data["stickerHeight"];
    stickerWeight = data["stickerWeight"];
    left = data["left"];
    top = data["top"];
    title = data["title"];
    stickerPrice = data["stickerPrice"];
  }

}

class StickerDataModel {
  String? id;
  String? stickerImage;
  String? stickerName;

  StickerDataModel({
    this.id,
    this.stickerImage,
    this.stickerName,
  });

  StickerDataModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    stickerImage = doc["stickerImage"];
    stickerName = doc["stickerName"];
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
  int? imagePrice;
  double? imageHeight;
  double? imageWeight;

  ImageFromGalleryAndCamModel({
    this.image, this.imagePrice, this.imageHeight,this.imageWeight,
    this.top,this.left,this.imageUrl});

  ImageFromGalleryAndCamModel.fromMap(Map<String, dynamic> data){
    // image = data["image"];
    imageHeight = data["imageHeight"];
    imageWeight = data["imageWeight"];
    left = data["left"];
    top = data["top"];
    imageUrl = data["imageUrl"];
    imagePrice = data["imagePrice"];
  }

}