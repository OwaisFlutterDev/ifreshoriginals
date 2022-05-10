import 'dart:io';
import 'dart:typed_data';
import 'package:ifreshoriginals_userapp/controller/functionality_on_opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/model/user_profile_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_image_controller.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import 'package:ifreshoriginals_userapp/controller/shipping_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/bottom_navigation_bar_screens/cart_screen.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController{
   bool isChecked = false;

   FirebaseAuth auth = FirebaseAuth.instance;
   final currentUser = FirebaseAuth.instance.currentUser;
   late Rx<User> firebaseUser;
   Rx<UserProfileModel> cartList = UserProfileModel().obs;

   @override
   void onInit(){
      super.onInit();
      cartList.bindStream(listenToUser());
   }

   // @override
   // void onReady() {
   //    super.onReady();
   //    firebaseUser = Rx<User>(auth.currentUser!);
   //    // firebaseUser.bindStream(auth.userChanges());
   //    ever(firebaseUser, _setInitialScreen);
   //    print("Cart Controller is Ready");
   // }
   //
   // _setInitialScreen(User user) {
   //
   //    if (user == null) {
   //       // Get.off(() => LoginScreen());
   //    } else {
   //       cartList.bindStream(listenToUser());
   //
   //       // Get.off(() => BottomNavigationBarScreen());
   //    }
   // }

   bool addToCartBool = false;
   Future addCartData() async {
      addToCartBool = true;
      update();
      ShippingController shippingController = Get.put(ShippingController());
      HomeController homeController = Get.find<HomeController>();
      FunctionalityOnImageController funcOnImageController = Get.put(FunctionalityOnImageController());
      FunctionalityOnOpenedDesignController funcOnOpenedDesignController = Get.put(FunctionalityOnOpenedDesignController());
      final user =  FirebaseAuth.instance.currentUser;


      try{

         Uuid itemId = Uuid();
         print(itemId.v1());

         // ------ == -- == ---==========  Save Front Image Design In FireStorage  =========----- == -- == -------
         String? frontImageDesignUrl;
         ByteData? frontByteImage;

         String? backImageDesignUrl;
         ByteData? backByteImage;

         frontByteImage =  funcOnImageController.frontByteImage;
         backByteImage = funcOnImageController.backByteImage;

         // ------------ saving first image -----------------

         final tempDir = await getTemporaryDirectory();
         File frontImageFile = await File('${tempDir.path}/${user!.uid + DateTime.now().toString()}.png').create();
         frontImageFile.writeAsBytesSync(frontByteImage!.buffer.asUint8List());

         String filePath = basename(frontImageFile.path);

         Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
             'shirt_design_images/$filePath');
         UploadTask uploadTask = firebaseStorageRef.putFile(frontImageFile);
         await uploadTask.whenComplete(() =>
             () {
           print("Front Image Upload SuccessFully");
         });

         frontImageDesignUrl = await firebaseStorageRef.getDownloadURL();

         // ------------ saving second image -----------------

         final tempDire = await getTemporaryDirectory();
         File backImageFile = await File('${tempDire.path}/${user.uid + "h" + DateTime.now().toString()}.png').create();
         backImageFile.writeAsBytesSync(backByteImage!.buffer.asUint8List());

         String filePathBI = basename(backImageFile.path);

         Reference firebaseStorageRefBI = FirebaseStorage.instance.ref().child(
             'shirt_design_images/$filePathBI');
         UploadTask uploadTaskBI = firebaseStorageRefBI.putFile(backImageFile);

         await uploadTaskBI.whenComplete(() =>
             () {
           print("Front Image Upload SuccessFully");
         });

         backImageDesignUrl = await firebaseStorageRefBI.getDownloadURL();

         // --=-=-=-============= add data to Firestore ==============-=-=-=-=--

         await FirebaseFirestore.instance.collection("users").doc(user.uid).update({

            "cart": FieldValue.arrayUnion([
               {
                     "id": itemId.v1(),
                     "frontImage": frontImageDesignUrl,
                     "backImage": backImageDesignUrl,
                     "designType": homeController.selectedDesignType,
                     "selectedSizedIndex": shippingController.selectedSizedIndex,
                     "selectedQuantity": shippingController.selectedQuantity,
                     "selectedSize": shippingController.selectedSize,
                     "discountNo":  shippingController.discount,
                     "perShirtPrice": homeController.newDesignPrice ?? 0,
                     "subTotal": shippingController.subTotal,
                     "currentDate": DateTime.now(),

                     "totalDiscount": shippingController.discountPer,
                     "totalPrice": shippingController.totalPrice,
               }
             ])
         }).then((_) => {
             print("Cart Data Added"),
             addToCartBool = false,
             update(),
            Get.to(() => CartScreen())
         }).catchError((onError) => print(onError.toString()));
         addToCartBool = false;
         makeSum();
         update();

      } catch(e){
         addToCartBool = false;
         update();
         print(e);
      }
   }

   // ------==== =-=-=-=-===============----==   add to cart of open design data   =----==================---=-=-=-=-======-----
   Future addCartDataOfOD() async {
     addToCartBool = true;
     update();
     ShippingController shippingController = Get.put(ShippingController());
     HomeController homeController = Get.find<HomeController>();
     FunctionalityOnOpenedDesignController funcOnOpenedDesignController = Get.put(FunctionalityOnOpenedDesignController());
     final user =  FirebaseAuth.instance.currentUser;


     try{

       Uuid itemId = Uuid();
       print(itemId.v1());

       // ------ == -- == ---==========  Save Front Image Design In FireStorage  =========----- == -- == -------
       String? frontImageDesignUrl;
       ByteData? frontByteImage;

       String? backImageDesignUrl;
       ByteData? backByteImage;

       frontByteImage =  funcOnOpenedDesignController.frontByteImageOfOD;
       backByteImage = funcOnOpenedDesignController.backByteImageOfOD;

       // ------------ saving first image -----------------

       final tempDir = await getTemporaryDirectory();
       File frontImageFile = await File('${tempDir.path}/${user!.uid + DateTime.now().toString()}.png').create();
       frontImageFile.writeAsBytesSync(frontByteImage!.buffer.asUint8List());

       String filePath = basename(frontImageFile.path);

       Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
           'shirt_design_images/$filePath');
       UploadTask uploadTask = firebaseStorageRef.putFile(frontImageFile);
       await uploadTask.whenComplete(() =>
           () {
         print("Front Image Upload SuccessFully");
       });

       frontImageDesignUrl = await firebaseStorageRef.getDownloadURL();

       // ------------ saving second image -----------------

       final tempDire = await getTemporaryDirectory();
       File backImageFile = await File('${tempDire.path}/${user.uid + "h" + DateTime.now().toString()}.png').create();
       backImageFile.writeAsBytesSync(backByteImage!.buffer.asUint8List());

       String filePathBI = basename(backImageFile.path);

       Reference firebaseStorageRefBI = FirebaseStorage.instance.ref().child(
           'shirt_design_images/$filePathBI');
       UploadTask uploadTaskBI = firebaseStorageRefBI.putFile(backImageFile);

       await uploadTaskBI.whenComplete(() =>
           () {
         print("Front Image Upload SuccessFully");
       });

       backImageDesignUrl = await firebaseStorageRefBI.getDownloadURL();

       // --=-=-=-============= add data to Firestore ==============-=-=-=-=--

       await FirebaseFirestore.instance.collection("users").doc(user.uid).update({

         "cart": FieldValue.arrayUnion([
           {
             "id": itemId.v1(),
             "frontImage": frontImageDesignUrl,
             "backImage": backImageDesignUrl,
             "designType": homeController.selectedShirtTypeOfOpenedDesign,
             "selectedSizedIndex": shippingController.selectedSizedIndex,
             "selectedQuantity": shippingController.selectedQuantity,
             "selectedSize": shippingController.selectedSize,
             "discountNo":  shippingController.discount,
             "perShirtPrice": homeController.newDesignPrice ?? 0,
             "subTotal": shippingController.subTotal,
             "currentDate": DateTime.now(),

             "totalDiscount": shippingController.discountPer,
             "totalPrice": shippingController.totalPrice,
           }
         ])
       }).then((_) => {
         print("Cart Data Added"),
         addToCartBool = false,
         update(),
         Get.to(() => CartScreen())
       }).catchError((onError) => print(onError.toString()));
       addToCartBool = false;
       makeSum();
       update();

     } catch(e){
       addToCartBool = false;
       update();
       print(e);
     }
   }

   // ----------------------------------------------------------------------------------------------------
   // -----------============ ----==========   delete cart item  ===========----- ==============--------------
   // ----------------------------------------------------------------------------------------------------

   Future deleteItemFromCart(CartModel cartData) async {

     final user =  FirebaseAuth.instance.currentUser;

     try{

       // --=-=-=-============= Delete Item From Cart Firestore ==============-=-=-=-=--

       await FirebaseFirestore.instance.collection("users").doc(user!.uid).update({

         "cart": FieldValue.arrayRemove([cartData.toJson()])
       }).then((_) => {
         print("Cart Item Data Deleted"),
       update()
       });
       makeSum();
       update();
     } catch(e){
       print(e);
     }
   }

   // ----------------------------------------------------------------------------------------------------
   // -----------============ ----==========   update cart item  ===========----- ==============--------------
   // ----------------------------------------------------------------------------------------------------

   int? selectedSizedIndexCart = 0 ;
   String? selectedSizeCart = "S" ;

   int? selectedQuantityIndexCart = 0;
   num? selectedQuantityCart = 1;
   num? discountCart = 0;

   String? frontImage;
   String? backImage;
   String? id;
   String? designType;
   num? perShirtPrice;

   num? subTotalCart = 0;
   num? discountPerCart = 0;
   num? totalPriceCart = 0;

   Future updateItemFromCart(CartModel cartData) async {

     final user =  FirebaseAuth.instance.currentUser;

     try{
       subTotalCart = perShirtPrice! * selectedQuantityCart!;
       discountPerCart = subTotalCart! / 100 * discountCart! ;
       totalPriceCart = subTotalCart! - discountPerCart!;

       // --=-=-=-============= Delete Item From Cart Firestore ==============-=-=-=-=--

       await FirebaseFirestore.instance.collection("users").doc(user!.uid).update({

         "cart": FieldValue.arrayRemove([cartData.toJson()])
       }).then((_) => {
         print("Cart Item Data Deleted"),
         update()
       });

       // --=-=-=-============= add Item to Cart Firestore ==============-=-=-=-=--
       await FirebaseFirestore.instance.collection("users").doc(user.uid).update({

         "cart": FieldValue.arrayUnion([
           {
             "id": id,
             "frontImage": frontImage,
             "backImage": backImage,
             "designType": designType,
             "selectedSizedIndex": selectedSizedIndexCart,
             "selectedQuantity": selectedQuantityCart,
             "selectedSize": selectedSizeCart,
             "discountNo":  discountCart,
             "perShirtPrice": perShirtPrice,
             "subTotal": subTotalCart,
             "currentDate": DateTime.now(),
             "totalDiscount": discountPerCart,
             "totalPrice": totalPriceCart,
           }
         ])
       }).then((_) => {
         print("Cart Data Updated"),
         Get.back()
       }).catchError((onError) => print(onError.toString()));
       makeSum();
       update();
     } catch(e){

       print(e);
     }

   }


// ==============================================================================
// -------------- ===========    Get User Data method   ========== --------------
//         =========================================================================

   User? user =  FirebaseAuth.instance.currentUser;
   Stream<UserProfileModel> listenToUser() => FirebaseFirestore.instance
       .collection("users")
       .doc(user!.uid)
       .snapshots()
       .map((snapshot) => UserProfileModel.fromDocumentSnapshot(snapshot));

// ==============================================================================
// -------------- ===========    Make sum of total sub total and discount   ========== --------------
//    =========================================================================

   num? sumOfSubTotal = 0;
   num? sumOfDiscount = 0;
   num? sumOfTotal = 0;

   makeSum() {

     sumOfSubTotal = 0;
     sumOfDiscount = 0;
     sumOfTotal = 0;

     for (var element in cartList.value.cart!) {
       sumOfSubTotal = sumOfSubTotal! +  element.subTotal!;
       print("sumOfSubTotal $sumOfSubTotal");
       update();
     }
     print("sumOfSubTotal $sumOfSubTotal");

     for (var element in cartList.value.cart!) {
       sumOfDiscount = sumOfDiscount! +  element.totalDiscount!;
       print("sumOfDiscount $sumOfDiscount");
       update();
     }
     print("sumOfSubTotal $sumOfDiscount");

     for (var element in cartList.value.cart!) {
       sumOfTotal = sumOfTotal! +  element.totalPrice!;
       print("sumOfDiscount $sumOfTotal");
       update();
     }
     print("sumOfSubTotal $sumOfTotal");
   }


}