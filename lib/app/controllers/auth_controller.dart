import 'package:chat_apps_kuld/app/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  UserCredential? userCredential;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var userModelFirestr = UserModelFirestore().obs;

  Future<void> firstInitialize() async {
    await autoLogin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });
    await skipIntro().then((value) {
      if (value) {
        isSkipIntro.value = true;
      }
    });
    //kita akan mengubah isSkipIntro => true
  }

  Future<bool> skipIntro() async {
    final box = GetStorage();
    if (box.read("skipIntro") != null || box.read("skipIntro") == true) {
      return true;
    }
    return false;
  }

  Future<bool> autoLogin() async {
    try {
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        await _googleSignIn
            .signInSilently()
            .then((value) => _currentUser = value);
        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        print("USER CREDENTIAL:");
        print("INI USER CREDENTIAL  ${userCredential}");
        // masukkan data ke firebase
        CollectionReference users = firestore.collection('users');

        users.doc(_currentUser!.email).update({
          "lastSignIN":
              userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
        });

        final curUser = await users.doc(_currentUser!.email).get();
        final curData = curUser.data() as Map<String, dynamic>;

        userModelFirestr(UserModelFirestore(
          uID: curData["UID"],
          nama: curData["nama"],
          email: curData["email"],
          photoUrl: curData["photoUrl"],
          status: curData["status"],
          creationTime: curData["creationTime"],
          lastSignIN: curData["lastSignIN"],
          updatedTime: curData["updatedTime"],
        ));

        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  Future<void> login() async {
    try {
      //ini untuk handle kebocoran data user sebelum login
      await _googleSignIn
          .signOut()
          .then((value) => print(" handle kebocoran data ${value}"));

      //ini digunakan untuk mendapatkan google account
      await _googleSignIn.signIn().then((value) => _currentUser = value);

      // ini untuk mengecek kondisi status login user
      final isSignIn = await _googleSignIn.isSignedIn();

      //jika user tidak login maka suruh login
      if (isSignIn) {
        //kondisi login berhasil
        print("TAHNIAH YOU CONNECTED TO LOGIN");
        print(" INI CURRENT USER! ${_currentUser}");

        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        print("USER CREDENTIAL:");
        print("INI USER CREDENTIAL  ${userCredential}");

        // simpan status user yang sudah pernah login dan tidak akan menampilkan introduction kembali:
        final box = GetStorage();
        if (box.read("skipIntro") != null) {
          box.remove("skipIntro");
        }
        box.write("skipIntro", true);

        // masukkan data ke firebase
        CollectionReference users = firestore.collection('users');

        final cekPengguna = await users.doc(_currentUser!.email).get();

        if (cekPengguna.data() == null) {
          users.doc(_currentUser!.email).set({
            "UID": userCredential!.user!.uid,
            "nama": _currentUser!.displayName,
            "email": _currentUser!.email,
            "photoUrl": _currentUser!.photoUrl ?? "noimage",
            "status": "",
            "creationTime":
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "lastSignIN": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "updatedTime": DateTime.now().toIso8601String(),
          });
        } else {
          users.doc(_currentUser!.email).update({
            "lastSignIN": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
          });
        }

        final curUser = await users.doc(_currentUser!.email).get();
        final curData = curUser.data() as Map<String, dynamic>;

        userModelFirestr(UserModelFirestore(
          uID: curData["UID"],
          nama: curData["nama"],
          email: curData["email"],
          photoUrl: curData["photoUrl"],
          status: curData["status"],
          creationTime: curData["creationTime"],
          lastSignIN: curData["lastSignIN"],
          updatedTime: curData["updatedTime"],
        ));

        isAuth.value = true;
        Get.offAllNamed(Routes.HOME,
            arguments: _currentUser!.displayName.toString());
      } else {
        print("Tidak berhasil login");
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> logOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  //PROFIL

  void ubahProfil(String nama, String status) {
    String date = DateTime.now().toIso8601String();

    //update firebase
    CollectionReference users = firestore.collection('users');

    users.doc(_currentUser!.email).update({
      "nama": nama,
      "status": status,
      "lastSignIN":
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      "updatedTime": date,
    });

    //update model
    userModelFirestr.update(
      (userModelFirestr) {
        userModelFirestr!.nama = nama;
        userModelFirestr.status = status;
        userModelFirestr.lastSignIN =
            userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
        userModelFirestr.updatedTime = date;
      },
    );

    // userModelFirestr(UserModelFirestore(
    //   nama: nama,
    //   status: status,
    //   lastSignIN:
    //       userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
    //   updatedTime: date,
    // ));

    refresh();
    Get.defaultDialog(
      title: "Notifikasi",
      middleText: "Perubahan profil berhasil terunggah",
    ).then((value) => Get.back());
  }

  void ubahStatusSaja(String status) {
    String date = DateTime.now().toIso8601String();

    //update firebase
    CollectionReference users = firestore.collection('users');
    users.doc(_currentUser!.email).update({
      "status": status,
      "lastSignIN":
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      "updatedTime": date,
    });

    userModelFirestr.update(
      (userModelFirestr) {
        userModelFirestr!.status = status;
        userModelFirestr.lastSignIN =
            userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
        userModelFirestr.updatedTime = date;
      },
    );
    refresh();
    Get.defaultDialog(
      title: "Notifikasi",
      middleText: "Status baru berhasil terunggah",
    ).then((value) => Get.back());
  }
}
