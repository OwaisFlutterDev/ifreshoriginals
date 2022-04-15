import 'dart:io';
import 'dart:typed_data';
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
import 'package:widget_to_image/widget_to_image.dart';

class CartController extends GetxController{
   bool isChecked = false;

   // FirebaseAuth auth = FirebaseAuth.instance;
   // final currentUser = FirebaseAuth.instance.currentUser;
   // late Rx<User> firebaseUser;
   // // Rx<UserProfileModel> userModel = UserProfileModel().obs;
   // RxList<UserProfileModel> cartList = RxList<UserProfileModel>([]);
   //
   // @override
   // void onInit() {
   //    super.onInit();
   //
   //    // userModel.bindStream(listenToUser());
   // }
   //
   // @override
   // void onReady() {
   //    super.onReady();
   //    firebaseUser = Rx<User>(auth.currentUser);
   //    firebaseUser.bindStream(auth.userChanges());
   //    ever(firebaseUser, _setInitialScreen);
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


   Future addCartData() async {
      ShippingController shippingController = Get.put(ShippingController());
      HomeController homeController = Get.find<HomeController>();


      try{
         String itemId = Uuid().toString();
         print(itemId);
         User? user =  FirebaseAuth.instance.currentUser;

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

         // --=-=-=-============= Calculation ==============-=-=-=-=--

         double? quantity = double.parse(shippingController.selectedQuantity.toString() );
         double? discountAmount = double.parse(shippingController.discount.toString());

         double? subPrice = homeController.newDesignPrice! * quantity;

         double? discountPer = subPrice / 100 * discountAmount ;
         double? totalPrice = subPrice - discountPer;

         // --=-=-=-============= add data to Firestore ==============-=-=-=-=--

         await FirebaseFirestore.instance.collection("users").doc(user.uid).update({

            "cart": FieldValue.arrayUnion([
               {
                     "id": itemId,
                     "frontImage": frontImageDesignUrl,

                     "selectedQuantity": shippingController.selectedQuantity,
                     "selectedSize": shippingController.selectedSize,
                     "discountNo":  discountAmount,

                     "currentDate": DateTime.now(),
                     "totalDiscount": discountPer,
                     "totalPrice": totalPrice,
               }
             ])
         }).then((_) => {
            print("Cart Data Added"),
            Get.to(() => CartScreen())
         }).catchError((onError) => print(onError.toString()));

         Get.to(() => CartScreen());

      } catch(e){
         print(e);
      }
   }

// ==============================================================================
// -------------- ===========    Get User Data method   ========== --------------
//         =========================================================================
//    User? user =  FirebaseAuth.instance.currentUser;
//    Stream<List<UserProfileModel>> listenToUser() => FirebaseFirestore.instance
//        .collection("users")
//        .doc(user!.uid)
//        .snapshots()
//        .map((snapshot) => UserProfileModel.fromDocumentSnapshot(snapshot));
// }

}