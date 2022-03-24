import 'package:get/get.dart';

import '../model/create_new_design_models.dart';


class HomeController extends GetxController {



  // ----------------------------=== ================================================== ===------------------------
  // ----------------------------===         Create New Design Data And Functions       ===------------------------
  // ----------------------------=== ================================================== ===------------------------
  String? selectedFrontImage;

  String? selectedBackImage;

  String? selectedShirtName;

  List<CreateNewDesignModel> createNewDesignList = [
    CreateNewDesignModel(
        frontImage: "assets/t_shirt.png",
        backImage: "assets/t_shirt.png",
        title: "T-Shirt For Man"
    ),
    // CreateNewDesignModel(
    //     frontImage: "assets/Hoodie.png",
    //     backImage: "assets/Hoodie.png",
    //     title: "Hoodie"
    // ),
    CreateNewDesignModel(
        frontImage: "assets/Crewneck.png",
        backImage: "assets/Crewneck.png",
        title: "Crewneck"
    ),
    CreateNewDesignModel(
        frontImage: "assets/Long-Sleeve.png",
        backImage: "assets/Long-Sleeve.png",
        title: "Adult Long-Sleeve"
    ),
    CreateNewDesignModel(
        frontImage: "assets/Women's-Tee.png",
        backImage: "assets/Women's-Tee.png",
        title: "T-Shirt For Women"
    ),
  ];

}