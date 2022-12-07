import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdateStatusController extends GetxController {
  late TextEditingController statusController;

  @override
  void onInit() {
    statusController = TextEditingController(text: "God Belongs Us");
    super.onInit();
  }

  @override
  void onClose() {
    statusController.dispose();
    super.onClose();
  }
}
