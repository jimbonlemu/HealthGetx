import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  late TextEditingController searchController;

  var queryAwal = [].obs;
  var tempSearch = [].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void cariTeman(String data) async {
    print("CARIIN DATA  : ${data}");

    if (data.length == 0) {
      queryAwal.value = [];
      tempSearch.value = [];
    } else {
      var kapital = data.substring(0, 1).toUpperCase() + data.substring(1);
      print(kapital);

      if (queryAwal.length == 0 && data.length == 1) {
        //fungsi yang akan dijalankan pada ketikan pertama
        CollectionReference client = await firestore.collection("client");
        final keyNameResult = await client
            .where("keyName", isEqualTo: data.substring(0, 1).toUpperCase())
            .get();

        print("TOTAL DATA ADA :  ${keyNameResult.docs.length}");
        if (keyNameResult.docs.length > 0) {
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            queryAwal.add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
          print("QUERY RESULT :");
          print(queryAwal);
        } else {
          print("TIDAK ADA DATA QUERY");
        }
      }

      if (queryAwal.length != 0) {
        tempSearch.value = [];
        queryAwal.forEach((element) {
          if (element["nama"].startWith(kapital)) {
            tempSearch.add(element);
          }
        });
      }
    }
    queryAwal.refresh();
    tempSearch.refresh();

  }

  @override
  void onInit() {
    searchController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}


