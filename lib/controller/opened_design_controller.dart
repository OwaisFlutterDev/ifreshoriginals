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

  HomeController homeController = Get.find<HomeController>();


  // --- ===  add Sticker on short from TextField === ---
  addNewStickerOfOD() {
    stickerListFirstImageOfOD.add(StickerModel(sticker: selectedStickerOfOD, left: 90,top: 75,title: ''));
    Get.back();
    update();
  }

  //   ---  == remove text ==  ---
  int? removeStickerIndexOfOD = 0;
  removeStickerOfOD(){
    stickerListFirstImageOfOD.removeAt(removeStickerIndexOfOD!);
    update();
  }

  List<StickerModel> giveStickerData(stickerList) {
    return  stickerListFirstImageOfOD = stickerList;
  }

  // ----------------------------=== ======================================= ===------------------------
// ----------------------------===    Choose Image From Cam And Gallery    ===------------------------
// ----------------------------=== ======================================= ===------------------------

  File? imageFromGalleryOfOd;
  String? imageFromGalleryToStringOfOd;
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
  addNewImageOfOd() {
    imageListOfOd.add(ImageFromGalleryAndCamModel(image: imageFromGalleryOfOd ?? imageFromCamOfOd ,left: 80,top: 75, imageUrl: null));
    Get.back();
    update();
    imageFromGalleryOfOd= null;
    imageFromCamOfOd = null;
  }

  //   ---  == remove text ==  ---
  int? removeImageIndexOfOd = 0;
  removeImageOfOd(){
    imageListOfOd.removeAt(removeImageIndexOfOd!);
    update();
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
  addNewTextOfOd() {
    textListOfOd.add(TextModel(color: colorOfOd, top: 75, text: textControllerOfOd.text,
      textAlign: TextAlign.center, fontStyle: FontStyle.normal,
      left: 78,fontSize: 18,fontWeight: FontWeight.normal,  fontFamily: fontFamilyOfOd ,
    ));
    Get.back();
    update();
  }

  //   ---  == remove text ==  ---
  int? removeTextIndexOfOd = 0;
  removeTextOfOd(){
    textListOfOd.removeAt(removeTextIndexOfOd!);
    update();
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
  addNewTextSecondImageOfOd() {
    textListForSecondImageOfOd.add(TextModel(color: colorSecondImageOfOd, top: 75, text: textControllerForSecondImageOfOd.text,
      textAlign: TextAlign.center, fontStyle: FontStyle.normal, fontFamily: fontFamilySecImageOfOd,
      left: 78,fontSize: 18,fontWeight: FontWeight.normal,));
    Get.back();
    update();
  }

  //   ---  == remove text ==  ---
  int? removeTextIndexSecondImageOfOd = 0;
  removeTextSecondImageOfOd(){
    textListForSecondImageOfOd.removeAt(removeTextIndexSecondImageOfOd!);
    update();
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
  addNewStickerSecondImageOfOD () {
    stickerListSecondImageOfOD.add(StickerModel(sticker: selectedStickerSecondImageOfOD, left: 90,top: 75,title: ''));
    Get.back();
    update();
  }

  //   ---  == remove text ==  ---
  int? removeStickerIndexSecondImageOfOD  = 0;
  removeStickerSecondImageOfOD (){
    stickerListSecondImageOfOD.removeAt(removeStickerIndexSecondImageOfOD !);
    update();
  }

  // ----------------------------=== ======================================= ===------------------------
// ----------------------------===    Choose Image From Cam And Gallery Second Image   ===------------------------
// ----------------------------=== ======================================= ===------------------------

  File? imageFromGallerySecondImageOfOd;
  String? imageFromGalleryToStringSecondImageOfOd;
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
  addNewImageSecondImageOfOd() {
    imageListSecondImageOfOd.add(ImageFromGalleryAndCamModel(
        image: imageFromGallerySecondImageOfOd ?? imageFromCamSecondImageOfOd ,left: 80,top: 75,imageUrl: null));
    Get.back();
    update();
    imageFromGallerySecondImageOfOd = null;
    imageFromCamSecondImageOfOd= null;
  }

  //   ---  == remove text ==  ---
  int? removeImageIndexSecondImageOfOd = 0;
  removeImageSecondImageOfOd(){
    imageListSecondImageOfOd.removeAt(removeImageIndexSecondImageOfOd!);
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
        "Update Design Notification",
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
        "Saved Design Notification",
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
          "sticker": stickerData.sticker,
          "left": stickerData.left,
          "top": stickerData.top,
          "title" : stickerData.title,
        });
      }

      List _stickerListSecondImage = [];

      for (StickerModel stickerData in stickerListSecondImageOfOD) {
        _stickerListSecondImage.add({
          "sticker": stickerData.sticker,
          "left": stickerData.left,
          "top": stickerData.top,
          "title" : stickerData.title,
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
            "left": textData.left,
            "top": textData.top,
            "image": "",
            "imageUrl": textData.imageUrl ?? imageUrl,
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
            "left": textData.left,
            "top": textData.top,
            "image": "",
            "imageUrl":  textData.imageUrl ?? imageUrl,
          });
        }
      }

      if (userID == user.uid) {
        // ------=-=-=-=======-==== update data ====-=======-=-=-=-=------

        await FirebaseFirestore.instance.collection("NewShirtDesign").doc(docID).update({
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
        }).then((_) => savedDesign()).catchError((onError) => print(onError.toString()));

      }
      else
        {
          // ------=-=-=-=======-==== update data ====-=======-=-=-=-=------

          final addProduct = FirebaseFirestore.instance.collection("NewShirtDesign").doc();
          await addProduct.set({
            "id": addProduct.id,
            "userId": user.uid.toString(),
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
          }).then((_) => updateDesign()).catchError((onError) => print(onError.toString()));
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