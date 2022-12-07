import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125),
        child: AppBar(
          title: Text('Search'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          flexibleSpace: Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextFormField(
                onChanged: (value) => controller.cariTeman(value),
                controller: controller.searchController,
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  hintText: 'Cari Dokter disini..',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  suffixIcon: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {},
                    child: Icon(
                      Icons.search_sharp,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.tempSearch.length == 0
            ? Center(
                child: Container(
                  width: Get.width * 0.7,
                  height: Get.width * 0.7,
                  child: Lottie.asset('assets/lottie/empty.json'),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.tempSearch.length,
                itemBuilder: (context, index) => ListTile(
                  // onTap: () => Get.toNamed(Routes.CHAT_ROOM),
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                    child: Image.asset('assets/logo/noimage.png'),
                  ),
                  title: Text(
                    '${controller.tempSearch[index]["nama"]}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    '${controller.tempSearch[index]["email"]}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  trailing: InkWell(
                    onTap: () => Get.toNamed(Routes.CHAT_ROOM),
                    child: Chip(
                      label: Text('Kirim Pesan'),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
