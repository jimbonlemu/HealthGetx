import 'package:avatar_glow/avatar_glow.dart';
import '/app/controllers/auth_controller.dart';
import '/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {
                authController.logOut();
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                  AvatarGlow(
                    duration: Duration(seconds: 3),
                    endRadius: 120,
                    glowColor: Colors.black,
                    child: Container(
                      width: 175,
                      height: 175,
                      child: ClipRRect(
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
                      ),
                    ),
                  ),
                  Obx(() => Text(
                        '${authController.userModelFirestr.value.nama!}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  Text(
                    '${authController.userModelFirestr.value.email!}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    ListTile(
                      onTap: () => Get.toNamed(Routes.UPDATE_STATUS),
                      leading: Icon(Icons.note_add_outlined),
                      title: Text(
                        'Perbarui Status',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_right),
                    ),
                    ListTile(
                      onTap: () => Get.toNamed(Routes.CHANGE_PROFILE),
                      leading: Icon(Icons.note_add_outlined),
                      title: Text(
                        'Cek Profil',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_right),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.color_lens),
                      title: Text(
                        'Ganti Tema',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      trailing: Text('Terang'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: context.mediaQueryPadding.bottom + 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Health Care',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                  Text(
                    'v 0.1',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
