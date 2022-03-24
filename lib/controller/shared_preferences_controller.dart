import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController extends GetxController{

  String? checkUser;

  Future getUserData() async {
    final SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
    var getUser = sharedPreferences.getString("user");
    checkUser = getUser;
    update();
  }



}