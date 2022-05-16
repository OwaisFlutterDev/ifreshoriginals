import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FormValidationController extends GetxController{

  //   ----- ========== Global Key ========== -----
  final GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> newPasswordFormKey = GlobalKey<FormState>();


  //   ----- ========== Text Editing Controller ========== -----
  late  TextEditingController usernameController, emailController, passwordController,
      conformPasswordController, newPasswordController, newConformPasswordController;

  String? smsCode;

  // --- ========= bool ======== ---
  bool isChecked = false;
  bool isHidden =  true;
  bool isHiddenForConformPass = true;

  @override
  void onInit() {
    super.onInit();


    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    conformPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    newConformPasswordController = TextEditingController();


  }

  void togglePassword (){
    isHidden = !isHidden;
    update();
  }


  void toggleConformPassword (){
    isHiddenForConformPass = !isHiddenForConformPass;
    update();
  }

  void clearTextField(){
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    conformPasswordController.clear();
    newPasswordController.clear();
    newConformPasswordController.clear();
  }

}