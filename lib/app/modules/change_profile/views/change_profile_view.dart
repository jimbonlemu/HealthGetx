import 'package:avatar_glow/avatar_glow.dart';
import 'package:chat_apps_kuld/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    controller.emailController.text =
        authController.userModelFirestr.value.email!;
    controller.namaController.text =
        authController.userModelFirestr.value.nama!;
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
        title: Text('Change Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save_rounded),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AvatarGlow(
                duration: Duration(seconds: 3),
                endRadius: 75,
                glowColor: Colors.black,
                child: Container(
                  width: 120,
                  height: 120,
                  child: Obx(() => ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: authController.userModelFirestr.value.photoUrl ==
                                "noimage"
                            ? Image.asset(
                                'assets/logo/noimage.png',
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                authController.userModelFirestr.value.photoUrl!,
                                fit: BoxFit.cover,
                              ),
                      )),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                enabled: false,
                controller: controller.emailController,
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                  labelText: 'Email',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  hintText: 'loremipsum@gmail.com',
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
              TextFormField(
                controller: controller.namaController,
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  hintText: 'Lorem Ipsum',
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
              TextFormField(
                controller: controller.statusController,
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                  labelText: 'Status',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  hintText: 'Masukkan status',
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
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('tidak ada gambar'),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Terpilih',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () => authController.ubahProfil(
                    controller.namaController.text,
                    controller.statusController.text,
                  ),
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
      ),
    );
  }
}
