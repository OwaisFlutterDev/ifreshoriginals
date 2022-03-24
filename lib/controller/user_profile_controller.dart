import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/model/user_profile_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';

class UserProfileController extends GetxController {

  //   ----- ========== Global Key ========== -----
  final GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changeProfileFormKey = GlobalKey<FormState>();

  //   ----- ========== Text Editing Controller ========== -----

  // --- ===  use in change Edit profile screen === -----
  TextEditingController usernameProfileController =  TextEditingController();
  TextEditingController phoneNumberProfileController = TextEditingController();
  TextEditingController addressProfileController = TextEditingController();

  // --- ===  use in change password screen === -----
  TextEditingController currentPasswordProfileController =  TextEditingController();
  TextEditingController newPasswordProfileController =  TextEditingController();
  TextEditingController conformPasswordProfileController = TextEditingController();

  UserProfileModel userProfileModel = UserProfileModel();


  File? imageFile;
  String? fileName;

  // ------- to get user data -------
  Future getUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    try {
      DocumentSnapshot _doc = await FirebaseFirestore.instance.collection(
          'users').doc(currentUser!.uid).get();
      // ------ ===== condition to check the data is get  or not =====  ------
      _doc != null ? print("Get Data from firebase") : print("Get null Data from firebase");


      userProfileModel = UserProfileModel.fromDocumentSnapshot(_doc);
      usernameProfileController.text = userProfileModel.username!;
      phoneNumberProfileController.text = userProfileModel.phoneNumber!;
      addressProfileController.text = userProfileModel.address!;
      update();
    }
    catch (error) {
      print(error);
    }
  }

  void clearTextField(){
    currentPasswordProfileController.clear();
    newPasswordProfileController.clear();
    conformPasswordProfileController.clear();

  }



  //  ---------------- get the image from gallery ---------------------
  void getImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    imageFile = File(img!.path);
    update();
  }

  //  ---------------- function to update data with image ---------------------
  bool updateDataBool = false;
  Future updateDataOfProfile() async {
    updateDataBool = true;
    update();

    if (imageFile != null) {
      String imageUrl;
      fileName = basename(imageFile!.path);
      final currentUser = FirebaseAuth.instance.currentUser;
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
          'user_images/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);

      // ignore: unused_local_variable

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() =>
          () {
        print("Upload Complete");
      });

      imageUrl = await firebaseStorageRef.getDownloadURL();
      String? fireStoreUserImage = userProfileModel.image;

      await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid)
          .update(
          {
            "phoneNumber": phoneNumberProfileController.text,
            "username": usernameProfileController.text,
            "address": addressProfileController.text,
            "image": imageUrl != null ? imageUrl : fireStoreUserImage,
          }
      )
          .then((_) => print("Data Updated"))
          .catchError((onError) => print(onError.toString()));
      await getUserData();
      updateDataBool = false;
      update();
      Get.back();
      Get.snackbar("Profile Screen", "Profile Updated Successfully",duration: Duration(seconds: 3), );
    }
    else {
      final currentUser = FirebaseAuth.instance.currentUser;
      String? fireStoreUserImage = userProfileModel.image;
      FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).update(
          {
            "image": fireStoreUserImage,
            "phoneNumber": phoneNumberProfileController.text,
            "username": usernameProfileController.text,
            "address": addressProfileController.text,
          }
      )
          .then((_) => print("Data Updated"))
          .catchError((onError) => print(onError.toString()));
      await getUserData();
      updateDataBool = false;
      update();
      Get.back();
      Get.snackbar("Profile Screen", "Profile Updated Successfully",duration: Duration(seconds: 3));
    }
    updateDataBool = false;
    update();
  }

  void changePassword() async {
    final User? currentUser =  FirebaseAuth.instance.currentUser;
    try{
      var authCredential = EmailAuthProvider.credential(
          email: userProfileModel.email!, password: currentPasswordProfileController.text);

      var authResult = await currentUser!.reauthenticateWithCredential(authCredential);

      if(authResult != null) {
         currentUser.updatePassword(newPasswordProfileController.text);
         clearTextField();
         Get.snackbar(
           "Change Password Notification",
           "Your password is changed Successfully",
           snackPosition: SnackPosition.TOP,
           duration: Duration(seconds: 5),
         );
       }
    }
    catch(e){
      Get.snackbar(
        "Change Password Notification",
        "The password is invalid or the user does not have a password.",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
      print(e);
    }
  }


}