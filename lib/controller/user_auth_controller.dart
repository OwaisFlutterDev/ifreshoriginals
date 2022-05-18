import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/controller/form_validation_controller.dart';
import 'package:ifreshoriginals_userapp/controller/user_profile_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/bottom_navigation_bar_screens/bottom_navigation_bar_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/user_auth_screens/welcome_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthController extends GetxController{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  //--- use for sign in with google ---------
  final googleSignIn = GoogleSignIn();
  //
  late Box box1 ;

  @override
  void onInit(){
    super.onInit();

    // userDataList.bindStream(getAllUserData());
    createBox();

  }



  void createBox() async {
    box1 = await Hive.openBox("loginData");
    getData();
  }

  void getData() async {
    FormValidationController formValidationController = Get.put(FormValidationController());
    if(box1.get('email') != null){
       formValidationController.emailController.text = box1.get("email");
       update();
    }
    else {
      print("Null email");
    }
    if(box1.get('password') != null) {
      formValidationController.passwordController.text = box1.get("password");
      update();
    }
    else {
      print("Null password");
    }
  }

  // ==============================================================================
  // -------------- ===========    Sign up through email & password used for (Employee)  ========== --------------
  //         =========================================================================
  bool createAccountBool = false;
  Future createAccount() async {
    createAccountBool = true;
    update();
    final FormValidationController _formValidationController = Get.put(FormValidationController());

    try {
      User? firebaseUser = (await _auth.createUserWithEmailAndPassword(
          email: _formValidationController.emailController.text.trim(), password: _formValidationController.passwordController.text.trim()))
          .user;
      // firebaseUser.sendEmailVerification();

      if (firebaseUser != null) {
        // -- here we add user data to Firestore --
        CollectionReference user = FirebaseFirestore.instance.collection('users');
        user.doc(firebaseUser.uid).set({
          "uid": firebaseUser.uid,
          "email": _formValidationController.emailController.text,
          "username": _formValidationController.usernameController.text,
          "image": "",
          "address": "",
          "phoneNumber": "",
          "cart": []

        }).then((_) => print("Data Of User Is Added to Firestore "))
            .catchError((onError) => print(onError.toString()));

        _formValidationController.clearTextField();
        createAccountBool = false;
        update();
        Get.back();

        Get.snackbar(
          "Create Account:",
          "Your Account is Created Successfully",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
        // return _user;
      } else { createAccountBool = false;
      update();
        Get.snackbar(
          "Create Account:",
          "Account creation field!  please check your email or password",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        createAccountBool = false;
        update();
        Get.snackbar(
          "Create Account Notification",
          "The password provided is too weak.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      } else if (e.code == 'email-already-in-use') {
        createAccountBool = false;
        update();
        Get.snackbar(
          "Create Account Notification",
          "The Account Already Exists For That Email.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      }
    } catch (error) {
      createAccountBool = false;
      update();
      print(error);
      // Get.snackbar(
      //   "Add Employee Notification",
      //   error.toString(),
      //   snackPosition: SnackPosition.TOP,
      //   duration: Duration(seconds: 5),
      // );
      return null;
    }
    createAccountBool = false;
    update();

  }


  // ==============================================================================
// -------------- ===========    Sign In through email and password    ========== --------------
//         =========================================================================
  bool signInBool = false;
  Future signInThroughEmailAndPass() async {
    signInBool = true ;
    update();

    final UserProfileController _userProfileController = Get.put(UserProfileController());
    final FormValidationController _formValidationController = Get.put(FormValidationController());

    try {
      User? _user = (await _auth.signInWithEmailAndPassword(email: _formValidationController.emailController.text.trim(),
                                               password: _formValidationController.passwordController.text.trim())).user;

        // ----- to keep login the user -----
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString("user", _formValidationController.emailController.text.trim());

        // ----- to get user profile data -----
        await _userProfileController.getUserData();

        // --==============================================================--
        // --=====-=-= give value to remember the user credentials --=====-=-=
        // --==============================================================--
        if(_formValidationController.isChecked) {
          box1.put("email", _formValidationController.emailController.text);
          box1.put("password", _formValidationController.passwordController.text);
        }

      // --=================================================================--
      // --=====-=-= clear text field and redirect to home screen --=====-=-=
      // --=================================================================--
        _formValidationController.clearTextField();
        signInBool = false;
        update();
        Get.to(() => BottomNavigationBarScreen());

        Get.snackbar(
          "Sign In:",
          "Welcome...",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        signInBool = false;
        update();
        Get.snackbar(
          "Sign In:",
          "No user found for that Email.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
      } else if (e.code == 'wrong-password') {
        signInBool = false;
        update();
        Get.snackbar(
          "Sign In:",
          "Wrong password provided for that user.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
      }
    } catch (error) {
      signInBool = false;
      update();
      print(error);
      return null;
    }
    signInBool = false;
    update();
  }



// ==============================================================================
  // -------------- ===========    Sign out method   ========== --------------
  //         =========================================================================

  Future logOut() async {

    final SharedPreferences  sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove("user");

    await FirebaseAuth.instance.signOut();
    // googleSignInLoader ? await googleSignIn.disconnect() : print("Not SignIn Through Google");
    await googleSignIn.signOut();
    Get.offAll(() => WelcomeScreen());
  }

  // ==============================================================================
// -------------- ===========    Sign up through Gmail    ========== --------------
//         =========================================================================

  bool googleSignInBool = false;
  Future signInWithGoogle() async {
    final UserProfileController _userProfileController = Get.put(UserProfileController());
    try {
      final user = await googleSignIn.signIn();
      googleSignInBool = true;
      update();
      // ---------
      // // ----- to get user profile data -------
      // await _userProfileController.getUserData();

      UserCredential userCredential = await _auth.signInWithCredential(GoogleAuthProvider.credential(
        idToken: (await user!.authentication).idToken,
        accessToken: (await user.authentication).accessToken,
      ));

      final firebaseUser = userCredential.user;

      // -------------------

      if (firebaseUser != null) {

        await FirebaseFirestore.instance.collection("users").where("email", isEqualTo:user.email ).get().then(
                (value) => value.size > 0 ? print("Already exists") : FirebaseFirestore.instance
                .collection('users')
                .doc(firebaseUser.uid)
                .set({
                  "uid": firebaseUser.uid,
                  "email": firebaseUser.email,
                  "username": firebaseUser.displayName,
                  "image": firebaseUser.photoURL,
                  "address": "",
                  "phoneNumber": "",
                  "cart": []
            })
                .then((_) => print("Data is add to fireStore"))
                .catchError((onError) => print(onError.toString())));

        // ----- to keep login the user -----
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString("user", firebaseUser.email.toString());

        print("yes google signin working fine.........................................");

        // // ----- to get user profile data -------
        await _userProfileController.getUserData();
        googleSignInBool = false;
        update();
        Get.to(() => BottomNavigationBarScreen());
        Get.snackbar("Log In:", "Welcome...",
          duration: Duration(seconds: 3),);

      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        googleSignInBool = false;
        update();
        Get.snackbar("Login Message",
          "The account already exists with a different credential.",
          duration: Duration(seconds: 3),
        );
      } else if (e.code == 'invalid-credential') {
        googleSignInBool = false;
        update();
        Get.snackbar("Login Message",
            "Error occurred while accessing credentials. Try again",
            duration: Duration(seconds: 3),
        );
        // handle the error here
      }
    } catch (error) {
      print(error);
      googleSignInBool = false;
      update();
      // Get.snackbar("Login Message", error.toString(),
      //   duration: Duration(seconds: 3), colorText: Colors.white,);
      return null;
    }
    googleSignInBool = false;
    update();
  }

  // ==============================================================================
// -------------- ===========    Forget Password Method    ========== ----------------------
//         =========================================================================

  Future resetPasswordRequest() async {
    final FormValidationController _formValidationController = Get.put(FormValidationController());

    try {
      await _auth.sendPasswordResetEmail(email: _formValidationController.emailController.text.trim());
      Get.snackbar("Reset Password:",
          "The mail is send to ${_formValidationController.emailController.text.trim()} please reset the Password",
          duration: Duration(seconds: 5));
      _formValidationController.clearTextField();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Reset Password:",
          "No user found for that Email.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      } else {
        return null;
      }
    } catch (error) {
      // Get.snackbar("Reset Password Screen", error.toString(),
      //     duration: Duration(seconds: 5));
      print(error);
    }
  }


  Future signInAnonymously() async {
    try{

      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      // print("signInAnonymously Id ${userCredential.user!.uid.toString()}");

      print( FirebaseAuth.instance.currentUser!.isAnonymous ? 'Yes, Its Anonymous ' : "No, Its Not Anonymous");

      Get.to(() => BottomNavigationBarScreen());
      Get.snackbar("Login Message", "You are successfully Sign In As a Guest",
        duration: Duration(seconds: 3),);

    }
    catch(e) {
      print(e);
    }
  }

}
