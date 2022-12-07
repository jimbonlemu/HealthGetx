import 'package:chat_apps_kuld/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Berinteraksi dengan mudah",
          body: "Wes menengo ae bojomu nang omah",
          image: Container(
            width: Get.width * 0.6,
            height: Get.height * 0.6,
            child: Center(
              child: Lottie.asset("assets/lottie/main-laptop-duduk.json"),
            ),
          ),
        ),
        PageViewModel(
          title: "Berinteraksi dengan mudah",
          body: "Wes menengo ae bojomu nang omah",
          image: Container(
            width: Get.width * 0.6,
            height: Get.height * 0.6,
            child: Center(
              child: Lottie.asset("assets/lottie/pesawat.json"),
            ),
          ),
        ),
        PageViewModel(
          title: "Berinteraksi dengan mudah",
          body: "Wes menengo ae bojomu nang omah",
          image: Container(
            width: Get.width * 0.6,
            height: Get.height * 0.6,
            child: Center(
              child: Lottie.asset("assets/lottie/payment.json"),
            ),
          ),
        ),
      ],
      onDone: () => Get.offAllNamed(Routes.LOGIN),
      showSkipButton: true,
      skip: Text('Skip'),
      next: Text(
        'Next',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      done: Text(
        "Login",
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
