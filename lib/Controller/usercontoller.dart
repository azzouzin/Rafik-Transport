import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/messege.dart';
import '../Model/user.dart';

class UserContoller extends GetxController {
  List<Messege> messegelist = [];
  bool isloading = false;

  RxList appusers = [].obs;

  File? selectedImage;

  void getallusers() {
    isloading = true;
    update();

    FirebaseFirestore.instance.collection('users').get().then((value) async {
      for (var element in value.docs) {
        appusers.add(AppUser.fromMap(element.data()));
      }

      print('The Users ${appusers}');
      isloading = false;
      update();
    }).onError((error, stackTrace) {
      print(error.toString());
      Get.showSnackbar(GetSnackBar(
          message: error.toString(),
          icon: const Icon(
            Iconsax.warning_2,
          )));
      isloading = false;
      update();
    });
  }

  void sendMessege({
    required String senderid,
    required String recieverid,
    required String date,
    required String text,
  }) async {
    isloading = true;
    update();
    var messege = Messege(
      senderid: senderid,
      date: date,
      recieverid: recieverid,
      text: text,
    );
    // imgurl = null;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(senderid)
        .collection('chats')
        .doc(recieverid)
        .collection('messeges')
        .add(messege.toMap())
        .then((value) {
      print(value.toString());
      isloading = false;
      update();
    }).catchError((e) {});

    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(recieverid)
        .collection('chats')
        .doc(senderid)
        .collection('messeges')
        .add(messege.toMap())
        .then((value) {
      print(value.toString());
      isloading = false;
    }).catchError((e) {});
  }

  void sendDriverMessege({
    required String senderid,
    required String recieverid,
    required String date,
    required String text,
  }) async {
    isloading = true;
    update();
    var messege = Messege(
      senderid: senderid,
      date: date,
      recieverid: recieverid,
      text: text,
    );

    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(senderid)
        .collection('chats')
        .doc(recieverid)
        .collection('messeges')
        .add(messege.toMap())
        .then((value) {
      print(value.toString());
      isloading = false;
      update();
    }).catchError((e) {});

    await FirebaseFirestore.instance
        .collection('users')
        .doc(recieverid)
        .collection('chats')
        .doc(senderid)
        .collection('messeges')
        .add(messege.toMap())
        .then((value) {
      print(value.toString());
      isloading = false;
    }).catchError((e) {});
  }

  Future<String?> uploadImage(String id, bool isDriver) async {
    String? msg;
    await pickImage();

    final ref = FirebaseStorage.instance
        .ref()
        .child('images/${Uri.file(selectedImage!.path).pathSegments.last}');
    await ref.putFile(selectedImage!);
    String url = await ref.getDownloadURL();
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(isDriver == true ? 'drivers' : 'users')
        .doc(id);

    await docRef.update({'image': url}).then((value) {
      print('Your Image is Ready Driver $url');
      msg = url;
    }).catchError((e) {
      print('Error Occures Driver $e');
    });

    return msg;
  }

  Future<File?> pickImage() async {
    try {
      final ImagePicker _imagePicker = ImagePicker();
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.camera);

      if (image != null) {
        print("THIS IS IMAGE Path${image.path}");
        selectedImage = File(image.path);
        print(selectedImage!.path);
      } else {
        print('You didnt pick any image');
      }
    } on Exception catch (e) {
      print(e);
    }
    return selectedImage;
  }

  void getMessege(String recieverid, String senderid) {
    print('get messege called');
    isloading = true;
    messegelist.clear();
    update();
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderid)
        .collection('chats')
        .doc(recieverid)
        .collection('messeges')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      if (event.docs.isEmpty) {
        print("Events docs is empty");
      } else {
        print("Events docs is not empty");
      }
      messegelist.clear();
      event.docs.forEach((element) async {
        var messege = Messege.fromMap(element.data());
        messegelist.add(messege);
        print(element.data());

        update();
      });
    });
    print(messegelist.length);
    isloading = false;

    update();
  }

  /* void getDriverMessege(String recieverid, String senderid) async {
    print('get Driver messege called');
    isloading = true;
    update();
    messegelist = [];
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(senderid)
        .collection('chats')
        .doc(recieverid)
        .collection('messeges')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) async {
        var messege = Messege.fromMap(element.data());
        messegelist.add(messege);
        print(element.data());
        print("This is messege List $messege");

        update();
      });
    });
    isloading = false;

    update();
  }
*/
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getallusers();
  }
}
