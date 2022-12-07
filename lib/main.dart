import '/app/controllers/auth_controller.dart';
import '/app/utils/splash_screen.dart';
import 'package:get_storage/get_storage.dart ';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(
    AuthController(),
    permanent: true,
  );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(
            () => GetMaterialApp(
              title: "Health Care Mobile",
              initialRoute: authC.isSkipIntro.isTrue
                  ? authC.isAuth.isTrue
                      ? Routes.HOME
                      : Routes.LOGIN
                  : Routes.INTRODUCTION,
              getPages: AppPages.routes,
            ),
          );
        }
        return FutureBuilder(
          future: authC.firstInitialize(),
          builder: (context, snapshot) => SplashScreen(),
        );
      },
    );

    // FutureBuilder(
    //   future: _initialization,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) {
    //       print(snapshot);
    //       return ErrorScreen();
    //     }

    // if (snapshot.connectionState == ConnectionState.done) {
    // return GetMaterialApp(
    //   title: 'HealthCare Mobile',
    //   initialRoute: Routes.CHAT_ROOM,
    //   getPages: AppPages.routes,
    // );

    // return Obx(
    //   () => GetMaterialApp(
    //     title: "Health Care",
    //     initialRoute: authC.isAuth.isTrue ? Routes.HOME : Routes.LOGIN,
    //     getPages: AppPages.routes,
    //   ),
    // );

    // }
    // return LoadingScreen();
  }
}
