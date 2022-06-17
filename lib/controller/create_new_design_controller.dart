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
import 'package:ifreshoriginals_userapp/controller/shirt_and _sticker_controller.dart';
import 'package:ifreshoriginals_userapp/model/create_new_design_models.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:widget_to_image/widget_to_image.dart';

class CreateNewDesignController extends GetxController {




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

  String? id = "WgnBHn01s1w09e0SGB4p";
  int? textPrice;
  int? stickerPrice;
  int? imagePrice;


  Future getAllPriceData() async{

    var collection = FirebaseFirestore.instance.collection('price');
    var querySnapshot = await collection.where('id', isEqualTo: id).get();

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      textPrice = data["textPrice"];
      stickerPrice = data["stickerPrice"];
      imagePrice = data["imageOnShirtPrice"];
      update();
    }
  }


  // int? stickerPrice = priceController.stickerPrice;
  // int? textPrice = 1;
  // int? imagePrice = 4;


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

  TextEditingController textController = TextEditingController();
  List<TextModel> textList = [];
  int? color = blackHexColor;
  int? selectedIndexOfColor ;
  bool textSelected = false;
  int currentIndexOfText = 0;
  String? fontFamily = 'Lato';
  int? selectedIndexOfFont ;



  // --- ===  add text on short from TextField === ---
  Future addNewText() async{
    await getAllPriceData();
    try{
      HomeController homeController = Get.find<HomeController>();

      textList.add(TextModel(color: color, top: 84, text: textController.text,
          textAlign: TextAlign.center, fontStyle: FontStyle.normal,
          left: 135,fontSize: 18,fontWeight: FontWeight.normal,  fontFamily: fontFamily , textPrice: textPrice
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
  Future removeText() async{
    await getAllPriceData();
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


  List<StickerModel> stickerList = [];
  int? selectedIndexOfSticker ;
  String? selectedSticker;

  // --- ===  add Sticker on short from TextField === ---
   Future addNewSticker() async{
     await getAllPriceData();
     HomeController homeController = Get.find<HomeController>();

    try{
      stickerList.add(StickerModel(
          sticker: selectedSticker, left: 135,top: 84, title: '', stickerPrice: stickerPrice,
          stickerHeight: 50, stickerWeight: 50
      )
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
  Future removeSticker() async{
    await getAllPriceData();
    stickerList.removeAt(removeStickerIndex!);
    update();

    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! - stickerPrice!;
    homeController.update();
  }
  int currentIndexOfSticker = 0;
  bool stickerSelected = false;
  increaseSizeOfSticker() {
    stickerList[currentIndexOfSticker].stickerHeight =  stickerList[currentIndexOfSticker].stickerHeight! + 5;
    stickerList[currentIndexOfSticker].stickerWeight =    stickerList[currentIndexOfSticker].stickerWeight! + 5;
    update();
  }

  decreaseSizeOfSticker() {
    stickerList[currentIndexOfSticker].stickerHeight =  stickerList[currentIndexOfSticker].stickerHeight! - 5;
    stickerList[currentIndexOfSticker].stickerWeight =    stickerList[currentIndexOfSticker].stickerWeight! - 5;
    update();
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
  Future addNewImage()  async{
    await getAllPriceData();
    imageList.add(ImageFromGalleryAndCamModel(
        image: imageFromGallery ?? imageFromCam ,left: 135,top: 84, imageUrl: '',imagePrice: imagePrice,imageHeight: 70,imageWeight: 70
    ));

    imageFromGallery != null ? addImagesPriceOnFirImage() : imageFromCam != null ? addImagesPriceOnFirImage() : null;

    Get.back();
    update();
    imageFromGallery = null;
    imageFromCam = null;
  }

  int currentIndexOfImage = 0;
  bool imageSelected = false;

  increaseSizeOfImage() {
    imageList[currentIndexOfImage].imageHeight =    imageList[currentIndexOfImage].imageHeight! + 5;
    imageList[currentIndexOfImage].imageWeight =    imageList[currentIndexOfImage].imageWeight! + 5;
    update();
  }

  decreaseSizeOfImage() {
    imageList[currentIndexOfImage].imageHeight =    imageList[currentIndexOfImage].imageHeight! - 5;
    imageList[currentIndexOfImage].imageWeight =    imageList[currentIndexOfImage].imageWeight! - 5;
    update();
  }

  //   ---  == remove text ==  ---
  int? removeImageIndex = 0;
  Future removeImage() async{
    await getAllPriceData();
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
  Future addNewTextSecondImage() async{
    await getAllPriceData();
    textListForSecondImage.add(TextModel(color: colorSecondImage, top: 84, text: textControllerForSecondImage.text,
      textAlign: TextAlign.center, fontStyle: FontStyle.normal, fontFamily: fontFamilySecImage,
      left: 135,fontSize: 18,fontWeight: FontWeight.normal, textPrice: textPrice));
    update();
    HomeController homeController = Get.find<HomeController>();
    textControllerForSecondImage.text.isNotEmpty ? homeController.newDesignPrice = homeController.newDesignPrice! + textPrice!
        : null;
    homeController.update();
    Get.back();
  }

  //   ---  == remove text ==  ---
  int? removeTextIndexSecondImage = 0;
  Future removeTextSecondImage() async{
    await getAllPriceData();
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
  Future addNewStickerSecondImage()  async {
    await getAllPriceData();
    stickerListSecondImage.add(StickerModel(sticker: selectedStickerSecondImage,left: 135,top: 84,title: '',stickerPrice: stickerPrice,
        stickerHeight: 50, stickerWeight: 50
    ));

    update();
    HomeController homeController = Get.find<HomeController>();
    selectedStickerSecondImage != null ? homeController.newDesignPrice = homeController.newDesignPrice! + stickerPrice!
        : null;
    homeController.update();

    Get.back();
  }

  //   ---  == remove text ==  ---
  int? removeStickerIndexSecondImage  = 0;
  Future removeStickerSecondImage() async {
    await getAllPriceData();
    stickerListSecondImage.removeAt(removeStickerIndexSecondImage !);
    update();
    HomeController homeController = Get.find<HomeController>();
    homeController.newDesignPrice = homeController.newDesignPrice! - stickerPrice!;
    homeController.update();
  }

  int currentIndexOfStickerOfSecImage = 0;

  increaseSizeOfStickerSI() {
    stickerListSecondImage[currentIndexOfStickerOfSecImage].stickerHeight =  stickerListSecondImage[currentIndexOfStickerOfSecImage].stickerHeight! + 5;
    stickerListSecondImage[currentIndexOfStickerOfSecImage].stickerWeight =    stickerListSecondImage[currentIndexOfStickerOfSecImage].stickerWeight! + 5;
    update();
  }

  decreaseSizeOfStickerSI() {
    stickerListSecondImage[currentIndexOfStickerOfSecImage].stickerHeight =  stickerListSecondImage[currentIndexOfStickerOfSecImage].stickerHeight! - 5;
    stickerListSecondImage[currentIndexOfStickerOfSecImage].stickerWeight =    stickerListSecondImage[currentIndexOfStickerOfSecImage].stickerWeight! - 5;
    update();
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
  Future addNewImageSecondImage() async{
    await getAllPriceData();
    imageListSecondImage.add(ImageFromGalleryAndCamModel(
      image: imageFromGallerySecondImage ?? imageFromCamSecondImage ,left: 135,top: 84,imageUrl: '',imagePrice: imagePrice,
        imageHeight: 70, imageWeight: 70

    ));

    imageFromGallerySecondImage != null ? addImagesPriceOnSecImage() : imageFromCamSecondImage != null ? addImagesPriceOnSecImage() : null;

    Get.back();
    update();
    imageFromGallerySecondImage = null;
    imageFromCamSecondImage = null;
  }

  int currentIndexOfImageOfSI = 0;

  increaseSizeOfImageSI() {
    imageListSecondImage[currentIndexOfImageOfSI].imageHeight =    imageListSecondImage[currentIndexOfImageOfSI].imageHeight! + 5;
    imageListSecondImage[currentIndexOfImageOfSI].imageWeight =    imageListSecondImage[currentIndexOfImageOfSI].imageWeight! + 5;
    update();
  }

  decreaseSizeOfImageSI() {
    imageListSecondImage[currentIndexOfImageOfSI].imageHeight =    imageListSecondImage[currentIndexOfImageOfSI].imageHeight! - 5;
    imageListSecondImage[currentIndexOfImageOfSI].imageWeight =    imageListSecondImage[currentIndexOfImageOfSI].imageWeight! - 5;
    update();
  }

  //   ---  == remove text ==  ---
  int? removeImageIndexSecondImage = 0;
  Future removeImageSecondImage() async{
    await getAllPriceData();
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

      for (StickerModel stickerData in stickerListSecondImage) {
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
            "imageWeight": textData.imageWeight,
            "imageHeight": textData.imageHeight,
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
            "imageWeight": textData.imageWeight,
            "imageHeight": textData.imageHeight,
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
