import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeProfileController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController namaController;
  late TextEditingController statusController;

  @override
  void onInit() {
    emailController = TextEditingController(text: "Yohanes Pambudi");
    namaController = TextEditingController(text: "y_pambudi@gmail.com");
    statusController = TextEditingController(text: "God Belongs Us");

    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    namaController.dispose();
    statusController.dispose();
    super.onClose();
  }
}
