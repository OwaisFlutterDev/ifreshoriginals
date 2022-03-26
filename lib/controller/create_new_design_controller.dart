import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import 'package:ifreshoriginals_userapp/model/create_new_design_models.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class CreateNewDesignController extends GetxController {


  // @override
  // void onInit() {
  //   super.onInit();
  //
  // }


  // ----------------------------=== ==================================== ===------------------------
  // ----------------------------===        Text For First Image      ===------------------------
  // ----------------------------=== ==================================== ===------------------------
  List<ColorsModel> colorsList = [
    ColorsModel(
      image: "assets/Asset 47.png",
      color: Colors.white,
      name: "White"
    ),
    ColorsModel(
      image: "assets/Asset 48.png",
      color: Colors.black,
      name: "Black"
    ),
    ColorsModel(
      image: "assets/Asset 49.png",
      color: Colors.blue.shade900,
      name: "Blue"
    ),
    ColorsModel(
      image: "assets/Asset 50.png",
      color: Colors.red,
        name: "Red"
    ),
    ColorsModel(
      image: "assets/Asset 51.png",
      color: Colors.green,
        name: "Green"
    ),
    ColorsModel(
      image: "assets/Asset 52.png",
      color: Colors.purple,
        name: "Purple"
    ),
    ColorsModel(
      image: "assets/Asset 53.png",
      color: Colors.brown.shade900,
        name: "Brown"
    ),
    ColorsModel(
      image: "assets/Asset 54.png",
      color: Colors.yellow,
        name: "Yellow"
    ),
  ];

  List<FontFamilyModel> fontFamilyList = [
    FontFamilyModel(
        name: "Adamina",
    ),
    FontFamilyModel(
      name: "Allerta",
    ),
    FontFamilyModel(
      name: "Roboto",
    ),
    FontFamilyModel(
      name: "Poppins",
    ),
    FontFamilyModel(
      name: "Actor",
    ),
    FontFamilyModel(
      name: "Montserrat",
    ),

  ];

  TextEditingController textController = TextEditingController();
  List<TextModel> textList = [];
  Color? color;
  int? selectedIndexOfColor ;
  bool textSelected = false;
  int currentIndexOfText = 0;
  String? fontFamily = 'Lato';
  int? selectedIndexOfFont ;



  // --- ===  add text on short from TextField === ---
  addNewText() {
    textList.add(TextModel(color: color, top: 75, text: textController.text,
      textAlign: TextAlign.center, fontStyle: FontStyle.normal,
      left: 78,fontSize: 18,fontWeight: FontWeight.bold,  fontFamily: fontFamily
    ));
    Get.back();
    update();
  }
  
  //   ---  == remove text ==  ---
  int? removeTextIndex = 0;
  removeText(){
    textList.removeAt(removeTextIndex!);
    update();
  }

  changeTextColor(Color color) {
    textList[currentIndexOfText].color = color;
    update();
  }

  increaseFontSize() {
    textList[currentIndexOfText].fontSize += 2;
    update();
  }

  decreaseFontSize() {
    textList[currentIndexOfText].fontSize -= 2;
    update();
  }

  alignLeft() {
      textList[currentIndexOfText].textAlign = TextAlign.left;
      update();
  }

  alignCenter() {
      textList[currentIndexOfText].textAlign = TextAlign.center;
      update();
  }

  alignRight() {
    textList[currentIndexOfText].textAlign = TextAlign.right;
    update();
  }

  boldText() {
      if (textList[currentIndexOfText].fontWeight == FontWeight.bold) {
        textList[currentIndexOfText].fontWeight = FontWeight.normal;
        update();
      } else {
        textList[currentIndexOfText].fontWeight = FontWeight.bold;
        update();
      }

  }

  italicText() {
      if (textList[currentIndexOfText].fontStyle == FontStyle.italic) {
        textList[currentIndexOfText].fontStyle = FontStyle.normal;
        update();
      } else {
        textList[currentIndexOfText].fontStyle = FontStyle.italic;
        update();
      }
  }

  addLinesToText() {
      if (textList[currentIndexOfText].text!.contains('\n')) {
        textList[currentIndexOfText].text =
            textList[currentIndexOfText].text!.replaceAll('\n', ' ');
        update();
      } else {
        textList[currentIndexOfText].text =
        textList[currentIndexOfText].text!.replaceAll(' ', '\n');
        update();
      }

  }

// ----------------------------=== ===================== ===------------------------
// ----------------------------===      For Sticker      ===------------------------
// ----------------------------=== ===================== ===------------------------

  List<StickerModel> stickerAssetList = [
    StickerModel(
      sticker: "assets/Asset 57.png",
      title: "white",
    ),
    StickerModel(
      sticker: "assets/Asset 58.png",
      title: "Black",
    ),
    StickerModel(
      sticker: "assets/Asset 59.png",
      title: "Blue",
    ),
    StickerModel(
      sticker: "assets/Asset 60.png",
      title: "Yellow",
    ),
    StickerModel(
      sticker: "assets/Asset 61.png",
      title: "Red",
    ),
    StickerModel(
      sticker: "assets/Asset 62.png",
      title: "Green",
    ),
    StickerModel(
      sticker: "assets/Asset 63.png",
      title: "Pink",
    ),
    StickerModel(
      sticker: "assets/Asset 64.png",
      title: "Brown",
    ),
  ];


  List<StickerModel> stickerList = [];
  int? selectedIndexOfSticker ;
  String? selectedSticker;

  // --- ===  add Sticker on short from TextField === ---
  addNewSticker() {
    stickerList.add(StickerModel(sticker: selectedSticker, left: 90,top: 75,));
    Get.back();
    update();
  }

  //   ---  == remove text ==  ---
  int? removeStickerIndex = 0;
  removeSticker(){
    stickerList.removeAt(removeStickerIndex!);
    update();
  }

// ----------------------------=== ===================== ===------------------------
// ----------------------------===    For Shirt Color    ===------------------------
// ----------------------------=== ===================== ===------------------------

  Color? selectedColorsForShirt;
  int? selectIndexColorsForShirt = 0;

  giveColorToShirt() {

    Get.back();
    update();
  }

// ----------------------------=== ======================================= ===------------------------
// ----------------------------===    Choose Image From Cam And Gallery    ===------------------------
// ----------------------------=== ======================================= ===------------------------

  File? imageFromGallery;
  String? imageFromGalleryToString;
  //  ---------------- get the image from gallery ---------------------
  void getImageFromGallery() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    imageFromGallery = File(img!.path);
    imageFromGalleryToString = basename(imageFromGallery!.path);
    update();
  }
  File? imageFromCam;
  String? imageFromCamToString;
  //  ---------------- get the image from gallery ---------------------
  void getImageFromCamera() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.camera);
    imageFromCam = File(img!.path);
    imageFromCamToString = basename(imageFromCam!.path);
    update();
  }

  List<ImageFromGalleryAndCamModel> imageList = [];

  // --- ===  add Sticker on short from TextField === ---
  addNewImage() {
    imageList.add(ImageFromGalleryAndCamModel(image: imageFromGallery ?? imageFromCam ,left: 80,top: 75,));
    Get.back();
    update();
    imageFromGallery = null;
    imageFromCam = null;
  }

  //   ---  == remove text ==  ---
  int? removeImageIndex = 0;
  removeImage(){
    imageList.removeAt(removeImageIndex!);
    update();
  }


//  ---------------------------------------------------------------------------------------------------------------------
//  -=-=---= ======================================================================================================== =---=-=-
//  ============== -------=----------=--=== ==-=-=-== Second Image Functions ==-=-=-== ===----=------=-------============
//  ---------------------------------------------------------------------------------------------------------------------
//  -=-=---= ======================================================================================================== =---=-=-

  // ----------------------------=== ==================================== ===------------------------
  // ----------------------------===        For Text For Second Image      ===------------------------
  // ----------------------------=== ==================================== ===------------------------

  TextEditingController textControllerForSecondImage = TextEditingController();
  List<TextModel> textListForSecondImage = [];
  Color? colorSecondImage;
  int? selectedIndexOfColorSecondImage ;
  bool textSelectedSecondImage = false;
  int currentIndexOfTextSecondImage = 0;
  String? fontFamilySecImage = 'Lato';
  int? selectedIndexOfFontSecImage ;


  // --- ===  add text on short from TextField === ---
  addNewTextSecondImage() {
    textListForSecondImage.add(TextModel(color: colorSecondImage, top: 75, text: textControllerForSecondImage.text,
      textAlign: TextAlign.center, fontStyle: FontStyle.normal, fontFamily: fontFamilySecImage,
      left: 78,fontSize: 18,fontWeight: FontWeight.bold,));
    Get.back();
    update();
  }

  //   ---  == remove text ==  ---
  int? removeTextIndexSecondImage = 0;
  removeTextSecondImage(){
    textListForSecondImage.removeAt(removeTextIndexSecondImage!);
    update();
  }

  changeTextColorSecondImage(Color color) {
    textListForSecondImage[currentIndexOfTextSecondImage].color = color;
    update();
  }

  increaseFontSizeSecondImage() {
    textListForSecondImage[currentIndexOfTextSecondImage].fontSize += 2;
    update();
  }

  decreaseFontSizeSecondImage() {
    textListForSecondImage[currentIndexOfTextSecondImage].fontSize -= 2;
    update();
  }

  alignLeftSecondImage() {
    textListForSecondImage[currentIndexOfTextSecondImage].textAlign = TextAlign.left;
    update();
  }

  alignCenterSecondImage() {
    textListForSecondImage[currentIndexOfTextSecondImage].textAlign = TextAlign.center;
    update();
  }

  alignRightSecondImage() {
    textListForSecondImage[currentIndexOfTextSecondImage].textAlign = TextAlign.right;
    update();
  }

  boldTextSecondImage() {
    if (textListForSecondImage[currentIndexOfTextSecondImage].fontWeight == FontWeight.bold) {
      textListForSecondImage[currentIndexOfTextSecondImage].fontWeight = FontWeight.normal;
      update();
    } else {
      textListForSecondImage[currentIndexOfTextSecondImage].fontWeight = FontWeight.bold;
      update();
    }

  }

  italicTextSecondImage() {
    if (textListForSecondImage[currentIndexOfTextSecondImage].fontStyle == FontStyle.italic) {
      textListForSecondImage[currentIndexOfTextSecondImage].fontStyle = FontStyle.normal;
      update();
    } else {
      textListForSecondImage[currentIndexOfTextSecondImage].fontStyle = FontStyle.italic;
      update();
    }
  }

  addLinesToTextSecondImage() {
    if (textListForSecondImage[currentIndexOfTextSecondImage].text!.contains('\n')) {
      textListForSecondImage[currentIndexOfTextSecondImage].text =
          textListForSecondImage[currentIndexOfTextSecondImage].text!.replaceAll('\n', ' ');
      update();
    } else {
      textListForSecondImage[currentIndexOfTextSecondImage].text =
          textListForSecondImage[currentIndexOfTextSecondImage].text!.replaceAll(' ', '\n');
      update();
    }

  }

  // ----------------------------=== ===================== ===------------------------
// ----------------------------===      For Sticker Second Image   ===------------------------
// ----------------------------=== ===================== ===------------------------


  List<StickerModel> stickerListSecondImage = [];
  int? selectedIndexOfStickerSecondImage  ;
  String? selectedStickerSecondImage ;

  // --- ===  add Sticker on short from TextField === ---
  addNewStickerSecondImage () {
    stickerListSecondImage.add(StickerModel(sticker: selectedStickerSecondImage, left: 90,top: 75,));
    Get.back();
    update();
  }

  //   ---  == remove text ==  ---
  int? removeStickerIndexSecondImage  = 0;
  removeStickerSecondImage (){
    stickerListSecondImage.removeAt(removeStickerIndexSecondImage !);
    update();
  }


// ----------------------------=== ======================================= ===------------------------
// ----------------------------===    Choose Image From Cam And Gallery Second Image   ===------------------------
// ----------------------------=== ======================================= ===------------------------

  File? imageFromGallerySecondImage;
  String? imageFromGalleryToStringSecondImage;
  //  ---------------- get the image from gallery ---------------------
  void getImageFromGallerySecondImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    imageFromGallerySecondImage = File(img!.path);
    imageFromGalleryToStringSecondImage = basename(imageFromGallerySecondImage!.path);
    update();
  }
  File? imageFromCamSecondImage;
  String? imageFromCamToStringSecondImage;
  //  ---------------- get the image from gallery ---------------------
  void getImageFromCameraSecondImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.camera);
    imageFromCamSecondImage = File(img!.path);
    imageFromCamToStringSecondImage = basename(imageFromCamSecondImage!.path);
    update();
  }

  List<ImageFromGalleryAndCamModel> imageListSecondImage = [];

  // --- ===  add Sticker on short from TextField === ---
  addNewImageSecondImage() {
    imageListSecondImage.add(ImageFromGalleryAndCamModel(image: imageFromGallerySecondImage ?? imageFromCamSecondImage ,left: 80,top: 75,));
    Get.back();
    update();
    imageFromGallerySecondImage = null;
    imageFromCamSecondImage = null;
  }

  //   ---  == remove text ==  ---
  int? removeImageIndexSecondImage = 0;
  removeImageSecondImage(){
    imageListSecondImage.removeAt(removeImageIndexSecondImage!);
    update();
  }

  // ----------------------------=== ===================== ===------------------------
// ----------------------------===    For Shirt Color Second Image  ===------------------------
// ----------------------------=== ===================== ===------------------------

  Color? selectedColorsForShirtSecondImage;
  int? selectIndexColorsForShirtSecondImage = 0;

  giveColorToShirtSecondImage() {

    Get.back();
    update();
  }

//  ---------------------------------------------------------------------------------------------------------------------
//  -=-=---= ======================================================================================================== =---=-=-
//  ============== -------=----------=--=== ==-=-=-== Firebase (DB Queries) ==-=-=-== ===----=------=-------============
//  ---------------------------------------------------------------------------------------------------------------------
//  -=-=---= ======================================================================================================== =---=-=-


// ----------------------------=== ================================= ===------------------------
// ----------------------------===    Save data of new shirt design  ===------------------------
// ----------------------------=== ================================= ===------------------------

  final GlobalKey<FormState> shirtDesignGlobalKey = GlobalKey<FormState>();
  final TextEditingController designNameController = TextEditingController();

  Future saveNewShirtDesign() async {
    User? user =  FirebaseAuth.instance.currentUser;
    final homeController = Get.find<HomeController>();
    successMsg(){
      Get.snackbar(
        "Add Product Notification",
        "Successfully Added the Product",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
    }

    try{

      final addProduct = FirebaseFirestore.instance.collection("NewShirtDesign").doc();
      await addProduct.set({
        "id": addProduct.id,
        "userId": user!.uid.toString(),
        "frontImage": homeController.selectedFrontImage,
        "backImage": homeController.selectedBackImage,
        "firstShirtColor": selectedColorsForShirt ?? "whiteColor",
        "secondShirtColor": selectedColorsForShirtSecondImage ?? "whiteColor",

        "shirtType": homeController.selectedShirtName,
        "designName": designNameController.text.toString(),
        "currentDateTime": DateTime.now(),

        "galleryImagesOfFirstImage": imageList ,
        "galleryImagesOfSecondImage": imageListSecondImage,
        "stickersOfFirstImage": stickerList,
        "stickersOfSecondImage": stickerListSecondImage,
        "textsOfFirstImage": textList,
        "textsOfSecondImage": textList,
      }).then((_) => successMsg()).catchError((onError) => print(onError.toString()));

    }
    catch(e){
      print(e);
    }
  }

}