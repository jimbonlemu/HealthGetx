import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../controllers/update_status_controller.dart';

class UpdateStatusView extends GetView<UpdateStatusController> {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
       controller.statusController.text =
        authController.userModelFirestr.value.status ?? "";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        backgroundColor: Colors.teal,
        title: Text('Update Status'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: controller.statusController,
              cursorColor: Colors.teal,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.teal,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                hintText: 'Masukkan status baru',
                hintStyle: TextStyle(color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: Get.width,
              child: ElevatedButton(
                onPressed: () {
                  authController.ubahStatusSaja(controller.statusController.text);
                },
                child: Text(
                  'UPDATE',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
