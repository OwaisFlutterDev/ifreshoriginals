import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_image_controller.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import 'package:ifreshoriginals_userapp/model/create_new_design_models.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:widget_to_image/widget_to_image.dart';

class CreateNewDesignController extends GetxController {


  // @override
  // void onInit() {
  //   super.onInit();
  //
  // }

  // ----------------------------=== ==================================== ===------------------------
  // ----------------------------===            Price  details            ===------------------------
  // ----------------------------=== ==================================== ===------------------------

  double? stickerPrice = 4;
  double? textPrice = 2;
  double? imagePrice = 7;


  // ----------------------------=== ==================================== ===------------------------
  // ----------------------------===        Text For First Image      ===------------------------
  // ----------------------------=== ==================================== ===------------------------
  List<ColorsModel> colorsList = [
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
  int? color = blackHexColor;
  int? selectedIndexOfColor ;
  bool textSelected = false;
  int currentIndexOfText = 0;
  String? fontFamily = 'Lato';
  int? selectedIndexOfFont ;



  // --- ===  add text on short from TextField === ---
  addNewText() {
    try{
      HomeController homeController = Get.find<HomeController>();

      textList.add(TextModel(color: color, top: 75, text: textController.text,
          textAlign: TextAlign.center, fontStyle: FontStyle.normal,
          left: 78,fontSize: 18,fontWeight: FontWeight.normal,  fontFamily: fontFamily , textPrice: textPrice
      ));

      textController.text.isNotEmpty ? homeController.newDesignPrice = homeController.newDesignPrice! + textPrice!
          : null;
      homeController.update();
      Get.back();
      update();
    } catch(e){
      print(e);
    }

  }
  
  //   ---  == remove text ==  ---
  int? removeTextIndex = 0;
  removeText(){
    textList.removeAt(removeTextIndex!);
    update();

    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! - textPrice!;
    homeController.update();

  }

  changeTextColor(int color) {
    textList[currentIndexOfText].color = color;
    update();
  }

  increaseFontSize() {
    textList[currentIndexOfText].fontSize = textList[currentIndexOfText].fontSize! + 2;
    update();
  }

  decreaseFontSize() {
    textList[currentIndexOfText].fontSize =    textList[currentIndexOfText].fontSize! - 2;
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
      stickerPrice: 4
    ),
    StickerModel(
        sticker: "assets/Asset 58.png",
        title: "Black",
        stickerPrice: 3
    ),
    StickerModel(
      sticker: "assets/Asset 59.png",
      title: "Blue",
        stickerPrice: 6
    ),
    StickerModel(
      sticker: "assets/Asset 60.png",
      title: "Yellow",
        stickerPrice: 4
    ),
    StickerModel(
      sticker: "assets/Asset 61.png",
      title: "Red",
        stickerPrice: 5
    ),
    StickerModel(
      sticker: "assets/Asset 62.png",
      title: "Green",
        stickerPrice: 4
    ),
    StickerModel(
      sticker: "assets/Asset 63.png",
      title: "Pink",
        stickerPrice: 3
    ),
    StickerModel(
      sticker: "assets/Asset 64.png",
      title: "Brown",
        stickerPrice: 2
    ),
  ];


  List<StickerModel> stickerList = [];
  int? selectedIndexOfSticker ;
  String? selectedSticker;

  // --- ===  add Sticker on short from TextField === ---
   addNewSticker() {
     HomeController homeController = Get.find<HomeController>();

    try{
      stickerList.add(StickerModel(
          sticker: selectedSticker, left: 90,top: 75,title: '',stickerPrice: stickerPrice)
      );
      selectedSticker != null ? homeController.newDesignPrice = homeController.newDesignPrice! + stickerPrice!
      : null;
      homeController.update();
      Get.back();
      update();
    } catch(e){ print(e);}

  }

  //   ---  == remove text ==  ---
  int? removeStickerIndex = 0;
  removeSticker(){
    stickerList.removeAt(removeStickerIndex!);
    update();

    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! - stickerPrice!;
    homeController.update();
  }

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

// ----------------------------=== ======================================= ===------------------------
// ----------------------------===    Choose Image From Cam And Gallery    ===------------------------
// ----------------------------=== ======================================= ===------------------------

  File? imageFromGallery;
  String? imageFromGalleryToString;

  addImagesPriceOnFirImage(){
    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! + imagePrice!;
    homeController.update();
  }

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
  addNewImage()  {
    imageList.add(ImageFromGalleryAndCamModel(
        image: imageFromGallery ?? imageFromCam ,left: 80,top: 75, imageUrl: '',imagePrice: imagePrice
    ));

    imageFromGallery != null ? addImagesPriceOnFirImage() : imageFromCam != null ? addImagesPriceOnFirImage() : null;

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

    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! - imagePrice!;
    homeController.update();

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
  int? colorSecondImage = blackHexColor;
  int? selectedIndexOfColorSecondImage ;
  bool textSelectedSecondImage = false;
  int currentIndexOfTextSecondImage = 0;
  String? fontFamilySecImage = 'Lato';
  int? selectedIndexOfFontSecImage ;


  // --- ===  add text on short from TextField === ---
  addNewTextSecondImage() {
    textListForSecondImage.add(TextModel(color: colorSecondImage, top: 75, text: textControllerForSecondImage.text,
      textAlign: TextAlign.center, fontStyle: FontStyle.normal, fontFamily: fontFamilySecImage,
      left: 78,fontSize: 18,fontWeight: FontWeight.normal, textPrice: textPrice));
    update();
    HomeController homeController = Get.find<HomeController>();
    textControllerForSecondImage.text.isNotEmpty ? homeController.newDesignPrice = homeController.newDesignPrice! + textPrice!
        : null;
    homeController.update();
    Get.back();
  }

  //   ---  == remove text ==  ---
  int? removeTextIndexSecondImage = 0;
  removeTextSecondImage(){
    textListForSecondImage.removeAt(removeTextIndexSecondImage!);
    update();
    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! - textPrice!;
    homeController.update();
  }

  changeTextColorSecondImage(int color) {
    textListForSecondImage[currentIndexOfTextSecondImage].color = color;
    update();
  }

  increaseFontSizeSecondImage() {
    textListForSecondImage[currentIndexOfTextSecondImage].fontSize = textListForSecondImage[currentIndexOfTextSecondImage].fontSize! + 2;
    update();
  }

  decreaseFontSizeSecondImage() {
    textListForSecondImage[currentIndexOfTextSecondImage].fontSize = textListForSecondImage[currentIndexOfTextSecondImage].fontSize! - 2;
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
    stickerListSecondImage.add(StickerModel(sticker: selectedStickerSecondImage, left: 90,top: 75,title: '',stickerPrice: stickerPrice));

    update();
    HomeController homeController = Get.find<HomeController>();
    selectedStickerSecondImage != null ? homeController.newDesignPrice = homeController.newDesignPrice! + stickerPrice!
        : null;
    homeController.update();

    Get.back();
  }

  //   ---  == remove text ==  ---
  int? removeStickerIndexSecondImage  = 0;
  removeStickerSecondImage (){
    stickerListSecondImage.removeAt(removeStickerIndexSecondImage !);
    update();
    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! - stickerPrice!;
    homeController.update();
  }


// ----------------------------=== ======================================= ===------------------------
// ----------------------------===    Choose Image From Cam And Gallery Second Image   ===------------------------
// ----------------------------=== ======================================= ===------------------------

  File? imageFromGallerySecondImage;
  String? imageFromGalleryToStringSecondImage;
  addImagesPriceOnSecImage(){
    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! + imagePrice!;
    update();
  }
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
    imageListSecondImage.add(ImageFromGalleryAndCamModel(
      image: imageFromGallerySecondImage ?? imageFromCamSecondImage ,left: 80,top: 75,imageUrl: '',imagePrice: imagePrice));

    imageFromGallerySecondImage != null ? addImagesPriceOnSecImage() : imageFromCamSecondImage != null ? addImagesPriceOnSecImage() : null;

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
    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! - imagePrice!;
    homeController.update();
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

//  ---------------------------------------------------------------------------------------------------------------------
//  -=-=---= ======================================================================================================== =---=-=-
//  ============== -------=----------=--=== ==-=-=-== Firebase (DB Queries) ==-=-=-== ===----=------=-------============
//  ---------------------------------------------------------------------------------------------------------------------
//  -=-=---= ======================================================================================================== =---=-=-


// ----------------------------=== ================================= ===------------------------
// ----------------------------===    Save data of new shirt design  ===------------------------
// ----------------------------=== ================================= ===------------------------

  // Future saveNewShirtDesignn() async{
  //   List _imageListOfFirstImage = [];
  //
  //   for (ImageFromGalleryAndCamModel textData in imageList) {
  //
  //       print(textData.image);
  //   }
  // }

  final GlobalKey<FormState> shirtDesignGlobalKey = GlobalKey<FormState>();
  final TextEditingController designNameController = TextEditingController();
  bool saveNewDesignShirtBool = false;

  Future saveNewShirtDesign() async {

    saveNewDesignShirtBool = true;
    update();

    User? user =  FirebaseAuth.instance.currentUser;
    final homeController = Get.find<HomeController>();

    successMsg(){
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

      // ------ == -- == ---==========  Save Front Image Design In FireStorage  =========----- == -- == -------
      final funcOnImageController = Get.find<FunctionalityOnImageController>();
      String? frontImageDesignUrl;
      ByteData? frontByteImage;

      funcOnImageController.flipCarController.state!.isFront ? print("Its Front") :
      await funcOnImageController.flipCarController.flipcard();

      ByteData frontImage = await WidgetToImage.repaintBoundaryToImage(funcOnImageController.frontGlobalKey!);

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

      for (StickerModel stickerData in stickerList) {
        _stickerOfFirstImage.add({
          "sticker": stickerData.sticker,
          "left": stickerData.left,
          "top": stickerData.top,
          "title" : stickerData.title,
          "stickerPrice" : stickerData.stickerPrice
        });
      }

      List _stickerListSecondImage = [];

      for (StickerModel stickerData in stickerListSecondImage) {
        _stickerListSecondImage.add({
          "sticker": stickerData.sticker,
          "left": stickerData.left,
          "top": stickerData.top,
          "title" : stickerData.title,
          "stickerPrice" : stickerData.stickerPrice
        });
      }

      List _textListOfFirstImage = [];

      for (TextModel textData in textList) {
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
         "textPrice" : textData.textPrice
        });
      }

      List _textListOfSecondImage = [];

      for (TextModel textData in textListForSecondImage) {
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

      for (ImageFromGalleryAndCamModel textData in imageList) {
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
            "imageUrl": imageUrl,
            "imagePrice" : textData.imagePrice
          });
        }

      }

      List _imageListOfSecondImage = [];

      for (ImageFromGalleryAndCamModel textData in imageListSecondImage) {
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
            "imageUrl": imageUrl,
            "imagePrice" : textData.imagePrice
          });
        }

      }



      final addProduct = FirebaseFirestore.instance.collection("NewShirtDesign").doc();
      await addProduct.set({
        "id": addProduct.id,
        "userId": user.uid.toString(),

        "totalPrice": homeController.newDesignPrice,

        "frontImage": homeController.selectedFrontImage,
        "backImage": homeController.selectedBackImage,
        "firstShirtColor": selectedColorsForShirt ?? whiteHexColor.toInt(),
        "secondShirtColor": selectedColorsForShirtSecondImage ?? whiteHexColor.toInt(),

        "shirtType": homeController.selectedDesignType,
        "designName": designNameController.text.toString(),

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
      }).then((_) => successMsg()).catchError((onError) => print(onError.toString()));

    }
    catch(e){
      saveNewDesignShirtBool = false;
      update();
      print(e);
    }
  }

}


//----------------------------------------------------------------------------------------------------------

// if(funcOnImageController.flipCarController.state!.isFront  ) {
//
//   // ------ == -- == ---==========  Save Front Image Design In FireStorage  =========----- == -- == -------
//   ByteData? frontByteImage;
//   ByteData frontImage = await WidgetToImage.repaintBoundaryToImage(funcOnImageController.frontGlobalKey!);
//
//   frontByteImage =  frontImage;
//
//   final tempDir = await getTemporaryDirectory();
//   File frontImageFile = await File('${tempDir.path}/${frontByteImage.elementSizeInBytes}.png').create();
//   frontImageFile.writeAsBytesSync(frontByteImage.buffer.asUint8List());
//
//   String filePath = basename(frontImageFile.path);
//
//   Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
//       'shirt_design_images/$filePath');
//   UploadTask uploadTask = firebaseStorageRef.putFile(frontImageFile);
//
//   await uploadTask.whenComplete(() =>
//       () {
//     print("Front Image Upload SuccessFully");
//   });
//
//   frontImageDesignUrl = await firebaseStorageRef.getDownloadURL();
//
//   await funcOnImageController.flipCarController.flipcard();
//
//   // ------ == -- == ---==========  Save back Image Design In FireStorage  =========----- == -- == -------
//
//   ByteData? backByteImage;
//   ByteData backImage = await WidgetToImage.repaintBoundaryToImage(funcOnImageController.backGlobalKey!);
//
//   backByteImage =  backImage;
//
//   final tempDire = await getTemporaryDirectory();
//   File backImageFile = await File('${tempDire.path}/$backByteImage.png').create();
//   backImageFile.writeAsBytesSync(backByteImage.buffer.asUint8List());
//
//   String filePaths = basename(backImageFile.path);
//
//   Reference firebaseStorageRefe = FirebaseStorage.instance.ref().child(
//       'shirt_design_images/$filePaths');
//   UploadTask uploadTasks = firebaseStorageRefe.putFile(backImageFile);
//
//   await uploadTasks.whenComplete(() =>
//       () {
//     print("Front Image Upload SuccessFully");
//   });
//
//   backImageDesignUrl = await firebaseStorageRefe.getDownloadURL();
//
//
//
// }
// else {
//
//   // ------ == -- == ---==========  Save back Image Design In FireStorage  =========----- == -- == -------
//
//   ByteData? backByteImage;
//   ByteData backImage = await WidgetToImage.repaintBoundaryToImage(funcOnImageController.backGlobalKey!);
//
//   backByteImage =  backImage;
//
//   final tempDire = await getTemporaryDirectory();
//   File backImageFile = await File('${tempDire.path}/$backByteImage.png').create();
//   backImageFile.writeAsBytesSync(backByteImage.buffer.asUint8List());
//
//   String filePaths = basename(backImageFile.path);
//
//   Reference firebaseStorageRefe = FirebaseStorage.instance.ref().child(
//       'shirt_design_images/$filePaths');
//   UploadTask uploadTasks = firebaseStorageRefe.putFile(backImageFile);
//
//   await uploadTasks.whenComplete(() =>
//       () {
//     print("Front Image Upload SuccessFully");
//   });
//
//   backImageDesignUrl = await firebaseStorageRefe.getDownloadURL();
//
//   await funcOnImageController.flipCarController.flipcard();
//
//   // ------ == -- == ---==========  Save Front Image Design In FireStorage  =========----- == -- == -------
//   ByteData? frontByteImage;
//   ByteData frontImage = await WidgetToImage.repaintBoundaryToImage(funcOnImageController.frontGlobalKey!);
//
//   frontByteImage =  frontImage;
//
//   final tempDir = await getTemporaryDirectory();
//   File frontImageFile = await File('${tempDir.path}/$frontByteImage.png').create();
//   frontImageFile.writeAsBytesSync(frontByteImage.buffer.asUint8List());
//
//   String filePath = basename(frontImageFile.path);
//
//   Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
//       'shirt_design_images/$filePath');
//   UploadTask uploadTask = firebaseStorageRef.putFile(frontImageFile);
//
//   await uploadTask.whenComplete(() =>
//       () {
//     print("Front Image Upload SuccessFully");
//   });
//
//   frontImageDesignUrl = await firebaseStorageRef.getDownloadURL();
//
//
// }



// ------ == -- == ---==========   =========----- == -- == -------