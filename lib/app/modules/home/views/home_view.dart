import '/app/controllers/auth_controller.dart';
import '/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final auhtController = Get.find<AuthController>();

  final List<Widget> myChato = List.generate(
    20,
    (index) => ListTile(
      onTap: () => Get.toNamed(Routes.CHAT_ROOM),
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 30,
        child: Image.asset('assets/logo/noimage.png'),
      ),
      title: Text(
        'Orang ke ${index + 1}',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        'Status Orang ke ${index + 1}',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      trailing: Chip(label: Text('${index + 1}')),
    ),
  ).reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Material(
            elevation: 5,
            child: Container(
              margin: EdgeInsets.only(top: context.mediaQuery.padding.top),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
              padding: EdgeInsets.fromLTRB(7, 3, 10, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chat Doktermu",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.blue,
                    child: InkWell(
                      // borderRadius: BorderRadius.circular(50),
                      onTap: () => Get.toNamed(Routes.PROFILE),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: myChato.length,
                itemBuilder: (context, index) => myChato[index]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.SEARCH),
        child: Icon(
          Icons.message_outlined,
        ),
      ),
    );
  }
}
