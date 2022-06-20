import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_opened_design_controller.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import 'package:ifreshoriginals_userapp/model/create_new_design_models.dart';
import 'package:image_picker/image_picker.dart';
import 'package:widget_to_image/widget_to_image.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class OpenedDesignController extends GetxController{




  RxList<StickerDataModel> stickersDataList = RxList<StickerDataModel>([]);
  // RxList<ShirtImageModel> shirtImageList = RxList<ShirtImageModel>([]);

  CollectionReference collectionReferenceOfPrice = FirebaseFirestore.instance.collection("stickers");

  @override
  void onInit() {
    super.onInit();
    stickersDataList.bindStream(getShirtImagesData());
  }

  //           ===============================================================================
  // -------------- ==========    Get featured design of current user data from Firestore    ========== --------------
  //           ===============================================================================

  Stream<List<StickerDataModel>> getShirtImagesData() =>
      collectionReferenceOfPrice.snapshots().map((query) =>
          query.docs.map((item) =>
              StickerDataModel.fromDocumentSnapshot(item)).toList());

  // ----------------------------=== ==================================== ===------------------------
  // ----------------------------===            Price  details            ===------------------------
  // ----------------------------=== ==================================== ===------------------------

  int? stickerPriceForOD = 4;
  int? textPriceForOD = 2;
  int? imagePriceForOD = 7;
  String? id = "WgnBHn01s1w09e0SGB4p";
  Future getAllPriceData() async{

    var collection = FirebaseFirestore.instance.collection('price');
    var querySnapshot = await collection.where('id', isEqualTo: id).get();

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      textPriceForOD = data["textPrice"];
      stickerPriceForOD = data["stickerPrice"];
      imagePriceForOD = data["imageOnShirtPrice"];
      update();
    }
  }

  List<ColorsModel> colorsListOfOd = [
    ColorsModel(
        image: "assets/Asset 47.png",
        color: 0xffffffff,
        name: "White"
    ),
    ColorsModel(
        image: "assets/Asset 48.png",
        color: 0xff000000,
        name: "Black"
    ),
    ColorsModel(
        image: "assets/Asset 49.png",
        color: 0xff58bbe4,
        name: "Blue"
    ),
    ColorsModel(
        image: "assets/Asset 50.png",
        color: 0xffF90408,
        name: "Red"
    ),
    ColorsModel(
        image: "assets/Asset 51.png",
        color: 0xff04f90d,
        name: "Green"
    ),
    ColorsModel(
        image: "assets/Asset 52.png",
        color: 0xffF904d2,
        name: "Purple"
    ),
    ColorsModel(
        image: "assets/Asset 53.png",
        color: 0xff964B00,
        name: "Brown"
    ),
    ColorsModel(
        image: "assets/Asset 54.png",
        color: 0xffFFFF00,
        name: "Yellow"
    ),
  ];

  // ----------------------------=== ===================== ===------------------------
// ----------------------------===    For Shirt Color    ===------------------------
// ----------------------------=== ===================== ===------------------------

  int? selectedColorsForShirt;
  int? selectIndexColorsForShirt = 0;
  Color? convertedColorForShirt;

  Color hexToColor() {
    return  convertedColorForShirt = Color(int.parse(selectedColorsForShirt.toString()));
  }

  giveColorToShirt() {

    Get.back();
    update();
  }


  // --------------------------=== ================================ ===------------------------
// ----------------------------===      Sticker  For First Image    ===------------------------
// ----------------------------=== ================================ ===------------------------

  List<StickerModel> stickerAssetListOfOd = [
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

  List<StickerModel> stickerListFirstImageOfOD = [];
  int? selectedIndexOfStickerOfOD ;
  String? selectedStickerOfOD;

  // --- ===  add Sticker on short from TextField === ---
  Future addNewStickerOfOD() async {
    await getAllPriceData();
    stickerListFirstImageOfOD.add(StickerModel(sticker: selectedStickerOfOD, left: 135,top: 84,title: '',
    stickerHeight: 50, stickerWeight: 50,
    ));
    Get.back();
    update();

    HomeController homeController = Get.find<HomeController>();
    selectedStickerOfOD != null ? homeController.newDesignPrice = homeController.newDesignPrice! + stickerPriceForOD!
        : null;
    homeController.update();
  }

  int currentIndexOfSticker = 0;
  bool stickerSelected = false;
  increaseSizeOfSticker() {
    stickerListFirstImageOfOD[currentIndexOfSticker].stickerHeight =  stickerListFirstImageOfOD[currentIndexOfSticker].stickerHeight! + 5;
    stickerListFirstImageOfOD[currentIndexOfSticker].stickerWeight =    stickerListFirstImageOfOD[currentIndexOfSticker].stickerWeight! + 5;
    update();
  }

  decreaseSizeOfSticker() {
    stickerListFirstImageOfOD[currentIndexOfSticker].stickerHeight =  stickerListFirstImageOfOD[currentIndexOfSticker].stickerHeight! - 5;
    stickerListFirstImageOfOD[currentIndexOfSticker].stickerWeight =    stickerListFirstImageOfOD[currentIndexOfSticker].stickerWeight! - 5;
    update();
  }

  //   ---  == remove text ==  ---
  int? removeStickerIndexOfOD = 0;
  Future removeStickerOfOD() async{
    await getAllPriceData();
    stickerListFirstImageOfOD.removeAt(removeStickerIndexOfOD!);
    update();

    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! - stickerPriceForOD!;
    homeController.update();

  }

  List<StickerModel> giveStickerData(stickerList) {
    return  stickerListFirstImageOfOD = stickerList;
  }

  // ----------------------------=== ======================================= ===------------------------
// ----------------------------===    Choose Image From Cam And Gallery    ===------------------------
// ----------------------------=== ======================================= ===------------------------

  File? imageFromGalleryOfOd;
  String? imageFromGalleryToStringOfOd;

   addImagesPriceOnFirImage() {

    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! + imagePriceForOD!;
    homeController.update();
  }

  //  ---------------- get the image from gallery ---------------------
  void getImageFromGalleryOfOd() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    imageFromGalleryOfOd = File(img!.path);
    imageFromGalleryToStringOfOd = basename(imageFromGalleryOfOd!.path);
    update();
  }
  File? imageFromCamOfOd;
  String? imageFromCamToStringOfOd;
  //  ---------------- get the image from gallery ---------------------
  void getImageFromCameraOfOd() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.camera);
    imageFromCamOfOd = File(img!.path);
    imageFromCamToStringOfOd = basename(imageFromCamOfOd!.path);
    update();
  }

  List<ImageFromGalleryAndCamModel> imageListOfOd = [];

  // --- ===  add Sticker on short from TextField === ---
  Future addNewImageOfOd() async{
    await getAllPriceData();
    imageListOfOd.add(ImageFromGalleryAndCamModel(
        image: imageFromGalleryOfOd ?? imageFromCamOfOd ,left: 135,top: 84, imageUrl: null,imageWeight: 60,imageHeight: 70));

    imageFromGalleryOfOd != null ? addImagesPriceOnFirImage() : imageFromCamOfOd != null ? addImagesPriceOnFirImage() : null;

    Get.back();
    update();
    imageFromGalleryOfOd= null;
    imageFromCamOfOd = null;
  }

  int currentIndexOfImage = 0;
  bool imageSelected = false;

  increaseSizeOfImage() {
    imageListOfOd[currentIndexOfImage].imageHeight =    imageListOfOd[currentIndexOfImage].imageHeight! + 5;
    imageListOfOd[currentIndexOfImage].imageWeight =    imageListOfOd[currentIndexOfImage].imageWeight! + 3;
    update();
  }

  decreaseSizeOfImage() {
    imageListOfOd[currentIndexOfImage].imageHeight =    imageListOfOd[currentIndexOfImage].imageHeight! - 5;
    imageListOfOd[currentIndexOfImage].imageWeight =    imageListOfOd[currentIndexOfImage].imageWeight! - 3;
    update();
  }

  //   ---  == remove text ==  ---
  int? removeImageIndexOfOd = 0;
  Future removeImageOfOd() async{
    await getAllPriceData();
    imageListOfOd.removeAt(removeImageIndexOfOd!);
    update();

    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! - imagePriceForOD!;
    homeController.update();

  }

  // ----------------------------=== ==================================== ===------------------------
  // ----------------------------===        Text For First Image      ===------------------------
  // ----------------------------=== ==================================== ===------------------------

  List<FontFamilyModel> fontFamilyListOfOD = [
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
    FontFamilyModel(
      name: "Nanum Gothic",
    ),
    FontFamilyModel(
      name: "PT Serif",
    ),
    FontFamilyModel(
      name: "Open Sans",
    ),
    FontFamilyModel(
      name: "Oswald",
    ),
    FontFamilyModel(
      name: "Noto Sans",
    ),
    FontFamilyModel(
      name: "Noto Serif",
    ),
    FontFamilyModel(
      name: "Nanum Gothic",
    ),
    FontFamilyModel(
      name: "Lora",
    ),
    FontFamilyModel(
      name: "Asul",
    ),
    FontFamilyModel(
      name: "Architects Daughter",
    ),
    FontFamilyModel(
      name: "Azeret Mono",
    ),
    FontFamilyModel(
      name: "Almarai",
    ),
    FontFamilyModel(
      name: "Bahianita",
    ),
    FontFamilyModel(
      name: "Barriecito",
    ),
    FontFamilyModel(
      name: "Cabin",
    ),
    FontFamilyModel(
      name: "Carme",
    ),
    FontFamilyModel(
      name: "Days One",
    ),
    FontFamilyModel(
      name: "Junge",
    ),
    FontFamilyModel(
      name: "Archivo",
    ),
    FontFamilyModel(
      name: "Jaldi",
    ),
    FontFamilyModel(
      name: "Xanh Mono",
    ),
    FontFamilyModel(
      name: "Caudex",
    ),
    FontFamilyModel(
      name: "Vampiro One",
    ),
    FontFamilyModel(
      name: "Varela Round",
    ),
    FontFamilyModel(
      name: "Kurale",
    ),
    FontFamilyModel(
      name: "Lacquer",
    ),

  ];


  TextEditingController textControllerOfOd = TextEditingController();
  List<TextModel> textListOfOd = [];
  int? colorOfOd = blackHexColor;
  int? selectedIndexOfColorOfOd ;
  bool textSelectedOfOd = false;
  int currentIndexOfTextOfOd = 0;
  String? fontFamilyOfOd = 'Lato';
  int? selectedIndexOfFontOfOd ;



  // --- ===  add text on short from TextField === ---
  Future addNewTextOfOd() async{
    await getAllPriceData();
    textListOfOd.add(TextModel(color: colorOfOd, top: 84, text: textControllerOfOd.text,
      textAlign: TextAlign.center, fontStyle: FontStyle.normal,
      left: 135,fontSize: 18,fontWeight: FontWeight.normal,  fontFamily: fontFamilyOfOd ,
    ));

    HomeController homeController = Get.find<HomeController>();
    textControllerOfOd.text.isNotEmpty ? homeController.newDesignPrice = homeController.newDesignPrice! + textPriceForOD!
        : null;
    homeController.update();

    Get.back();
    update();
  }

  //   ---  == remove text ==  ---
  int? removeTextIndexOfOd = 0;
  Future removeTextOfOd() async{
    await getAllPriceData();
    textListOfOd.removeAt(removeTextIndexOfOd!);
    update();

    HomeController homeController = Get.find<HomeController>();
     homeController.newDesignPrice = homeController.newDesignPrice! - textPriceForOD!;
    homeController.update();
  }

  changeTextColorOfOd(int color) {
    textListOfOd[currentIndexOfTextOfOd].color = color;
    update();
  }

  increaseFontSizeOfOd() {
    textListOfOd[currentIndexOfTextOfOd].fontSize = textListOfOd[currentIndexOfTextOfOd].fontSize! + 2;
    update();
  }

  decreaseFontSizeOfOd() {
    textListOfOd[currentIndexOfTextOfOd].fontSize =    textListOfOd[currentIndexOfTextOfOd].fontSize! - 2;
    update();
  }

  alignLeftOfOd() {
    textListOfOd[currentIndexOfTextOfOd].textAlign = TextAlign.left;
    update();
  }

  alignCenterOfOd() {
    textListOfOd[currentIndexOfTextOfOd].textAlign = TextAlign.center;
    update();
  }

  alignRightOfOd() {
    textListOfOd[currentIndexOfTextOfOd].textAlign = TextAlign.right;
    update();
  }

  boldTextOfOd() {
    if (textListOfOd[currentIndexOfTextOfOd].fontWeight == FontWeight.bold) {
      textListOfOd[currentIndexOfTextOfOd].fontWeight = FontWeight.normal;
      update();
    } else {
      textListOfOd[currentIndexOfTextOfOd].fontWeight = FontWeight.bold;
      update();
    }

  }

  italicTextOfOd() {
    if (textListOfOd[currentIndexOfTextOfOd].fontStyle == FontStyle.italic) {
      textListOfOd[currentIndexOfTextOfOd].fontStyle = FontStyle.normal;
      update();
    } else {
      textListOfOd[currentIndexOfTextOfOd].fontStyle = FontStyle.italic;
      update();
    }
  }

  addLinesToTextOfOd() {
    if (textListOfOd[currentIndexOfTextOfOd].text!.contains('\n')) {
      textListOfOd[currentIndexOfTextOfOd].text =
          textListOfOd[currentIndexOfTextOfOd].text!.replaceAll('\n', ' ');
      update();
    } else {
      textListOfOd[currentIndexOfTextOfOd].text =
          textListOfOd[currentIndexOfTextOfOd].text!.replaceAll(' ', '\n');
      update();
    }

  }


//  ---------------------------------------------------------------------------------------------------------------------
//  -=-=---= ======================================================================================================== =---=-=-
//  ============== -------=----------=--=== ==-=-=-== Second Image Functions ==-=-=-== ===----=------=-------============
//  ---------------------------------------------------------------------------------------------------------------------
//  -=-=---= ======================================================================================================== =---=-=-

  // ----------------------------=== ==================================== ===------------------------
  // ----------------------------===        For Text For Second Image      ===------------------------
  // ----------------------------=== ==================================== ===------------------------

  TextEditingController textControllerForSecondImageOfOd = TextEditingController();
  List<TextModel> textListForSecondImageOfOd = [];
  int? colorSecondImageOfOd = blackHexColor;
  int? selectedIndexOfColorSecondImageOfOd ;
  bool textSelectedSecondImageOfOd = false;
  int currentIndexOfTextSecondImageOfOd = 0;
  String? fontFamilySecImageOfOd = 'Lato';
  int? selectedIndexOfFontSecImageOfOd ;


  // --- ===  add text on short from TextField === ---
  Future addNewTextSecondImageOfOd() async{
    await getAllPriceData();
    textListForSecondImageOfOd.add(TextModel(color: colorSecondImageOfOd, top: 84, text: textControllerForSecondImageOfOd.text,
      textAlign: TextAlign.center, fontStyle: FontStyle.normal, fontFamily: fontFamilySecImageOfOd,
      left: 135,fontSize: 18,fontWeight: FontWeight.normal,));

    HomeController homeController = Get.find<HomeController>();
    textControllerForSecondImageOfOd.text.isNotEmpty ? homeController.newDesignPrice = homeController.newDesignPrice! + textPriceForOD!
        : null;
    homeController.update();

    Get.back();
    update();
  }

  //   ---  == remove text ==  ---
  int? removeTextIndexSecondImageOfOd = 0;
  Future removeTextSecondImageOfOd() async{
    await getAllPriceData();
    textListForSecondImageOfOd.removeAt(removeTextIndexSecondImageOfOd!);
    update();

    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! - textPriceForOD!;
    homeController.update();
  }

  changeTextColorSecondImageOfOd(int color) {
    textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].color = color;
    update();
  }

  increaseFontSizeSecondImageOfOd() {
    textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].fontSize = textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].fontSize! + 2;
    update();
  }

  decreaseFontSizeSecondImageOfOd() {
    textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].fontSize = textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].fontSize! - 2;
    update();
  }

  alignLeftSecondImageOfOd() {
    textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].textAlign = TextAlign.left;
    update();
  }

  alignCenterSecondImageOfOd() {
    textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].textAlign = TextAlign.center;
    update();
  }

  alignRightSecondImageOfOd() {
    textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].textAlign = TextAlign.right;
    update();
  }

  boldTextSecondImageOfOd() {
    if (textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].fontWeight == FontWeight.bold) {
      textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].fontWeight = FontWeight.normal;
      update();
    } else {
      textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].fontWeight = FontWeight.bold;
      update();
    }

  }

  italicTextSecondImageOfOd() {
    if (textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].fontStyle == FontStyle.italic) {
      textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].fontStyle = FontStyle.normal;
      update();
    } else {
      textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].fontStyle = FontStyle.italic;
      update();
    }
  }

  addLinesToTextSecondImageOfOd() {
    if (textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].text!.contains('\n')) {
      textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].text =
          textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].text!.replaceAll('\n', ' ');
      update();
    } else {
      textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].text =
          textListForSecondImageOfOd[currentIndexOfTextSecondImageOfOd].text!.replaceAll(' ', '\n');
      update();
    }

  }

// ----------------------------=== ===================== ===------------------------
// ----------------------------===    For Shirt Color Second Image  ===------------------------
// ----------------------------=== ===================== ===------------------------

  int? selectedColorsForShirtSecondImage;
  int? selectIndexColorsForShirtSecondImage = 0;

  Color? convertedColorForSecondShirt;

  Color hexToColorForSecondShort() {
    return  convertedColorForSecondShirt = Color(int.parse(selectedColorsForShirtSecondImage.toString()));
  }

  giveColorToShirtSecondImage() {

    Get.back();
    update();
  }

  // ----------------------------=== ===================== ===------------------------
// ----------------------------===      For Sticker Second Image   ===------------------------
// ----------------------------=== ===================== ===------------------------


  List<StickerModel> stickerListSecondImageOfOD = [];
  int? selectedIndexOfStickerSecondImageOfOD  ;
  String? selectedStickerSecondImageOfOD ;

  // --- ===  add Sticker on short from TextField === ---
  Future addNewStickerSecondImageOfOD () async{
    await getAllPriceData();
    stickerListSecondImageOfOD.add(StickerModel(
        sticker: selectedStickerSecondImageOfOD,  left: 135,top: 84,title: '',
        stickerWeight: 60,stickerHeight: 70,
    ));

    HomeController homeController = Get.find<HomeController>();
    selectedStickerSecondImageOfOD != null ? homeController.newDesignPrice = homeController.newDesignPrice! + stickerPriceForOD!
        : null;
    homeController.update();

    Get.back();
    update();
  }

  int currentIndexOfStickerOfSecImage = 0;

   increaseSizeOfStickerSI() {

    stickerListSecondImageOfOD[currentIndexOfStickerOfSecImage].stickerHeight =  stickerListSecondImageOfOD[currentIndexOfStickerOfSecImage].stickerHeight! + 5;
    stickerListSecondImageOfOD[currentIndexOfStickerOfSecImage].stickerWeight =    stickerListSecondImageOfOD[currentIndexOfStickerOfSecImage].stickerWeight! + 3;
    update();
  }

  decreaseSizeOfStickerSI() {
    stickerListSecondImageOfOD[currentIndexOfStickerOfSecImage].stickerHeight =  stickerListSecondImageOfOD[currentIndexOfStickerOfSecImage].stickerHeight! - 5;
    stickerListSecondImageOfOD[currentIndexOfStickerOfSecImage].stickerWeight =    stickerListSecondImageOfOD[currentIndexOfStickerOfSecImage].stickerWeight! - 3;
    update();
  }

  //   ---  == remove text ==  ---
  int? removeStickerIndexSecondImageOfOD  = 0;
  // double? subStickerPrice = 0;
  Future removeStickerSecondImageOfOD () async{
    await getAllPriceData();
    stickerListSecondImageOfOD.removeAt(removeStickerIndexSecondImageOfOD !);
    update();

    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! -  stickerPriceForOD!;
    homeController.update();

  }

  // ----------------------------=== ======================================= ===------------------------
// ----------------------------===    Choose Image From Cam And Gallery Second Image   ===------------------------
// ----------------------------=== ======================================= ===------------------------

  File? imageFromGallerySecondImageOfOd;
  String? imageFromGalleryToStringSecondImageOfOd;

  addImagesPriceOnSecImage(){
    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! + imagePriceForOD!;
    homeController.update();
  }

  //  ---------------- get the image from gallery ---------------------
  void getImageFromGallerySecondImageOfOd() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    imageFromGallerySecondImageOfOd = File(img!.path);
    imageFromGalleryToStringSecondImageOfOd= basename(imageFromGallerySecondImageOfOd!.path);
    update();
  }
  File? imageFromCamSecondImageOfOd;
  String? imageFromCamToStringSecondImageOfOd;
  //  ---------------- get the image from gallery ---------------------
  void getImageFromCameraSecondImageOfOd() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.camera);
    imageFromCamSecondImageOfOd = File(img!.path);
    imageFromCamToStringSecondImageOfOd = basename(imageFromCamSecondImageOfOd!.path);
    update();
  }

  List<ImageFromGalleryAndCamModel> imageListSecondImageOfOd = [];

  // --- ===  add Sticker on short from TextField === ---
  Future addNewImageSecondImageOfOd() async {
    await getAllPriceData();
    imageListSecondImageOfOd.add(ImageFromGalleryAndCamModel(
        image: imageFromGallerySecondImageOfOd ?? imageFromCamSecondImageOfOd ,
        imageHeight: 70, imageWeight: 60,
        left: 135,top: 84,imageUrl: null));

    imageFromGallerySecondImageOfOd != null ? addImagesPriceOnSecImage() : imageFromCamSecondImageOfOd != null ? addImagesPriceOnSecImage() : null;

    Get.back();
    update();
    imageFromGallerySecondImageOfOd = null;
    imageFromCamSecondImageOfOd= null;
  }

  int currentIndexOfImageOfSI = 0;

  increaseSizeOfImageSI() {
    imageListSecondImageOfOd[currentIndexOfImageOfSI].imageHeight =    imageListSecondImageOfOd[currentIndexOfImageOfSI].imageHeight! + 5;
    imageListSecondImageOfOd[currentIndexOfImageOfSI].imageWeight =    imageListSecondImageOfOd[currentIndexOfImageOfSI].imageWeight! + 3;
    update();
  }

  decreaseSizeOfImageSI() {
    imageListSecondImageOfOd[currentIndexOfImageOfSI].imageHeight =    imageListSecondImageOfOd[currentIndexOfImageOfSI].imageHeight! - 5;
    imageListSecondImageOfOd[currentIndexOfImageOfSI].imageWeight =    imageListSecondImageOfOd[currentIndexOfImageOfSI].imageWeight! - 3;
    update();
  }

  //   ---  == remove text ==  ---
  int? removeImageIndexSecondImageOfOd = 0;
  Future removeImageSecondImageOfOd() async{
    await getAllPriceData();
    imageListSecondImageOfOd.removeAt(removeImageIndexSecondImageOfOd!);
    update();

    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! - imagePriceForOD!;
    homeController.update();
  }

//  ---------------------------------------------------------------------------------------------------------------------
//  -=-=---= ======================================================================================================== =---=-=-
//  ============== -------=----------=--=== ==-=-=-== Firebase (DB Queries) ==-=-=-== ===----=------=-------============
//  ---------------------------------------------------------------------------------------------------------------------
//  -=-=---= ======================================================================================================== =---=-=-



  // ----------------------------=== ================================= ===------------------------
// ----------------------------===    Save data of new shirt design  ===------------------------
// ----------------------------=== ================================= ===------------------------



  final GlobalKey<FormState> shirtDesignGlobalKeyOfOd = GlobalKey<FormState>();
  final TextEditingController designNameControllerOfOd = TextEditingController();

  String? docID ;
  String? userID ;

  bool saveNewDesignShirtBool = false;
  User? currentUser =  FirebaseAuth.instance.currentUser;

  Future updateOrSaveShirtDesignOfOd() async {

    saveNewDesignShirtBool = true;
    update();

    User? user =  FirebaseAuth.instance.currentUser;
    final homeController = Get.find<HomeController>();

    updateDesign(){
      saveNewDesignShirtBool = false;
      update();
      Get.back();
      Get.snackbar(
        "Update Design Notification:",
        "Design Is Updated...",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
    }

    savedDesign(){
      saveNewDesignShirtBool = false;
      update();
      Get.back();
      Get.snackbar(
        "Saved Design Notification:",
        "Design Is Saved...",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
    }

    try{


      // String? backImageDesignUrl;

      // ------ == -- == ---==========  Save Front Image Design In FireStorage  =========----- == -- == -------
      final funcOnImageController = Get.find<FunctionalityOnOpenedDesignController>();
      String? frontImageDesignUrl;
      ByteData? frontByteImage;

      funcOnImageController.flipCarControllerOfOD.state!.isFront ? print("Its Front") :
      await funcOnImageController.flipCarControllerOfOD.flipcard();

      ByteData frontImage = await WidgetToImage.repaintBoundaryToImage(funcOnImageController.frontGlobalKeyOfOD!);

      frontByteImage =  frontImage;

      final tempDir = await getTemporaryDirectory();
      File frontImageFile = await File('${tempDir.path}/${user!.uid + DateTime.now().toString()}.png').create();
      frontImageFile.writeAsBytesSync(frontByteImage.buffer.asUint8List());

      String filePath = basename(frontImageFile.path);

      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
          'shirt_design_images/$filePath');
      UploadTask uploadTask = firebaseStorageRef.putFile(frontImageFile);

      await uploadTask.whenComplete(() =>
          () {
        print("Front Image Upload SuccessFully");
      });

      frontImageDesignUrl = await firebaseStorageRef.getDownloadURL();

      // ------ == -- == ---==========   =========----- == -- == -------

      List _stickerOfFirstImage = [];

      for (StickerModel stickerData in stickerListFirstImageOfOD) {
        _stickerOfFirstImage.add({
          "stickerWeight": stickerData.stickerWeight,
          "stickerHeight": stickerData.stickerHeight,
          "sticker": stickerData.sticker,
          "left": stickerData.left,
          "top": stickerData.top,
          "title" : stickerData.title,
          "stickerPrice" : stickerData.stickerPrice
        });
      }

      List _stickerListSecondImage = [];

      for (StickerModel stickerData in stickerListSecondImageOfOD) {
        _stickerListSecondImage.add({
          "stickerWeight": stickerData.stickerWeight,
          "stickerHeight": stickerData.stickerHeight,
          "sticker": stickerData.sticker,
          "left": stickerData.left,
          "top": stickerData.top,
          "title" : stickerData.title,
          "stickerPrice" : stickerData.stickerPrice
        });
      }

      List _textListOfFirstImage = [];

      for (TextModel textData in textListOfOd) {
        _textListOfFirstImage.add({
          "text": textData.text,
          "left": textData.left,
          "top": textData.top,
          "color": textData.color,
          "fontWeight": textData.fontWeight.toString(),
          "fontStyle": textData.fontStyle.toString(),
          "fontSize": textData.fontSize,
          "textAlign": textData.textAlign.toString(),
          "fontFamily": textData.fontFamily,
          "textPrice" : textData.textPrice,
        });
      }

      List _textListOfSecondImage = [];

      for (TextModel textData in textListForSecondImageOfOd) {
        _textListOfSecondImage.add({
          "text": textData.text,
          "left": textData.left,
          "top": textData.top,
          "color": textData.color,
          "fontWeight": textData.fontWeight.toString(),
          "fontStyle": textData.fontStyle.toString(),
          "fontSize": textData.fontSize,
          "textAlign": textData.textAlign.toString(),
          "fontFamily": textData.fontFamily,
          "textPrice" : textData.textPrice
        });
      }

      List _imageListOfFirstImage = [];

      for (ImageFromGalleryAndCamModel textData in imageListOfOd) {
        if (textData.image != null) {
          String imageUrl;
          String? fileName;
          fileName = basename(textData.image!.path);
          Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
              'images_on_shirt/$fileName');
          UploadTask uploadTask = firebaseStorageRef.putFile(textData.image!);

          await uploadTask.whenComplete(() =>
              () {
            print("Upload Complete");
          });

          imageUrl = await firebaseStorageRef.getDownloadURL();

          _imageListOfFirstImage.add({
            "imageWeight": textData.imageWeight,
            "imageHeight": textData.imageHeight,
            "left": textData.left,
            "top": textData.top,
            "image": "",
            "imageUrl": textData.imageUrl ?? imageUrl,
            "imagePrice" : textData.imagePrice
          });
        }

      }

      List _imageListOfSecondImage = [];

      for (ImageFromGalleryAndCamModel textData in imageListSecondImageOfOd) {
        if (textData.image != null) {
          String imageUrl;
          String? fileName;
          fileName = basename(textData.image!.path);
          Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
              'images_on_shirt/$fileName');
          UploadTask uploadTask = firebaseStorageRef.putFile(textData.image!);

          await uploadTask.whenComplete(() =>
              () {
            print("Upload Complete");
          });

          imageUrl = await firebaseStorageRef.getDownloadURL();

          _imageListOfSecondImage.add({
            "imageWeight": textData.imageWeight,
            "imageHeight": textData.imageHeight,
            "left": textData.left,
            "top": textData.top,
            "image": "",
            "imageUrl":  textData.imageUrl ?? imageUrl,
            "imagePrice" : textData.imagePrice
          });
        }
      }

      if (userID == user.uid) {
        // ------=-=-=-=======-==== update data ====-=======-=-=-=-=------

        await FirebaseFirestore.instance.collection("NewShirtDesign").doc(docID).update({

          "totalPrice": homeController.newDesignPrice,

          "frontImage": homeController.selectedFrontImageOfOpenedDesign,
          "backImage": homeController.selectedBackImageOfOpenedDesign,
          "firstShirtColor": selectedColorsForShirt ?? whiteHexColor.toInt(),
          "secondShirtColor": selectedColorsForShirtSecondImage ?? whiteHexColor.toInt(),

          // "shirtType": homeController.selectedShirtName,
          "designName": designNameControllerOfOd.text.toString(),

          "currentDateTime": DateTime.now(),

          "frontImageOfDesign": frontImageDesignUrl,
          // "backImageOfDesign": backImageDesignUrl,

          "galleryImagesOfFirstImage": _imageListOfFirstImage,
          "galleryImagesOfSecondImage": _imageListOfSecondImage,

          "stickersOfFirstImage": _stickerOfFirstImage,
          "stickersOfSecondImage": _stickerListSecondImage,
          "textsOfFirstImage": _textListOfFirstImage,
          "textsOfSecondImage": _textListOfSecondImage,
        }).then((_) => updateDesign()).catchError((onError) => print(onError.toString()));

      }
      else
        {
          // ------=-=-=-=======-==== update data ====-=======-=-=-=-=------

          final addProduct = FirebaseFirestore.instance.collection("NewShirtDesign").doc();
          await addProduct.set({
            "id": addProduct.id,
            "userId": user.uid.toString(),

            "totalPrice": homeController.newDesignPrice,

            "frontImage": homeController.selectedFrontImageOfOpenedDesign,
            "backImage": homeController.selectedBackImageOfOpenedDesign,
            "firstShirtColor": selectedColorsForShirt ?? whiteHexColor.toInt(),
            "secondShirtColor": selectedColorsForShirtSecondImage ?? whiteHexColor.toInt(),

            "shirtType": homeController.selectedShirtNameOfOpenedDesign,
            "designName": designNameControllerOfOd.text.toString(),

            "currentDateTime": DateTime.now(),

            "frontImageOfDesign": frontImageDesignUrl,
            // "backImageOfDesign": backImageDesignUrl,

            "galleryImagesOfFirstImage": _imageListOfFirstImage,
            "galleryImagesOfSecondImage": _imageListOfSecondImage,

            "stickersOfFirstImage": _stickerOfFirstImage,
            "stickersOfSecondImage": _stickerListSecondImage,
            "textsOfFirstImage": _textListOfFirstImage,
            "textsOfSecondImage": _textListOfSecondImage,
            "popularityCount": 1,
          }).then((_) => savedDesign()).catchError((onError) => print(onError.toString()));
          print("the doc not belong to that user");
        }

    }
    catch(e){
      saveNewDesignShirtBool = false;
      update();
      print(e);
    }
  }

}