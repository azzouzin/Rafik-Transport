import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/Controller/Services/auth_services.dart';
import 'package:rafik/Controller/usercontoller.dart';
import 'package:rafik/Model/user.dart';
import 'package:rafik/View/Authpages/signuppage.dart';
import 'package:rafik/View/Compenents/theme.dart';
import 'package:rafik/View/HomePages/DriverPages/driverhome.dart';

import '../Model/driver.dart';
import '../View/Authpages/OTP/register.dart';
import '../View/Authpages/chosepage.dart';

class Authcontroller extends GetxController {
  bool isDriver = false;
  bool isloading = false;
  bool photoIsLoading = false;
  AppUser? profile;
  Driver? driverProfile;
  String? vid;
  AuthServices authServices = AuthServices();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController carmodeleEditingController = TextEditingController();

  Future<Driver?> getDriverData(resp) async {
    driverProfile = await authServices.getDriverData(resp);
    print(profile?.image);
    print(profile?.email);
    print(profile?.name);
    print(profile?.phone);
    return driverProfile;
  }

  Future<AppUser?> getUserData(resp) async {
    profile = await authServices.getuserdata(resp);
    print(profile?.image);
    print(profile?.email);
    print(profile?.name);
    print(profile?.phone);
    return profile;
  }

  void setlaodingtrue() {
    isloading = true;
    update();
  }

  void setloadingfalse() {
    isloading = false;
    update();
  }

  Future<void> login(email, password) async {
    isloading = true;
    update();
    String? resp = await authServices.login(email, password);
    print(resp);
    if (resp != null) {
      profile = await authServices.getuserdata(resp);
      print(profile?.image);

      print(profile?.name);
      print(profile?.phone);
      Get.snackbar('Happy to see you ', 'Take your time and chose your ride',
          backgroundColor: green);
      Get.offAllNamed('/homepage');
    } else {
      Get.snackbar('Error', resp ?? 'Unkown Error Please Try Again',
          backgroundColor: pink, colorText: white);
    }

    isloading = false;
    update();
  }

  Future<void> loginDriver(email, password) async {
    print("From Controller $email");
    print(password);
    isloading = true;
    update();
    String? resp = await authServices.login(email, password);
    print(resp);
    if (resp != null) {
      driverProfile = await authServices.getDriverData(resp);
      print(driverProfile!.name);
      print(driverProfile!.carmodele);
      print(driverProfile!.email);
      print(driverProfile!.image);
      print(driverProfile!.rating);
      print(driverProfile!.uid);

      Get.snackbar('Happy to see you ', 'Take your time and chose your ride',
          backgroundColor: green);
      Get.offAllNamed('/driverhome');
    } else {
      Get.snackbar('Error', resp ?? 'Unkown Error Please Try Again',
          backgroundColor: pink, colorText: white);
    }

    isloading = false;
    update();
  }

  Future<String?> sendSms(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        //   print(credential);
        // await FirebaseAuth.instance.signInWithCredential(credential);
        //   Get.toNamed("/homepage");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Faild");
        print(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        print("this is verifaction id $verificationId");
        vid = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return vid;
  }

  Future<void> verifyPhoneNumber(String verificationId, String smsCode) async {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    var car = await FirebaseAuth.instance
      ..signInWithCredential(credential);
    print(car);
  }

  Future<void> signup({password, name, phone, email}) async {
    isloading = true;
    update();

    profile = await authServices.registerUser(
        password: password, name: name, phone: phone, email: email);

    isloading = false;
    update();
  }

  Future<void> logout() async {
    var msg = await authServices.logout();
    msg == 'ok'
        ? Get.offAllNamed('/signup')
        : Get.snackbar('Error', 'Error please try later');
    msg == 'ok' ? Get.offAll(ChosePage()) : null;
  }

  void setAccountTypetoDriver() {
    isDriver = true;
    update();
  }

  void setAccountTypetoUser() {
    isDriver = false;
    update();
  }

  Future<void> signupdriver(
      email, password, name, String phone, carModele) async {
    print("Sign ip driver called");
    log(phone);
    isloading = true;
    update();
    var resp = await authServices.registerDriverWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        carModele: carModele,
        phone: phone);

    isloading = false;
    Get.snackbar("Your Account is Verified ", "Welcome to rafik Community",
        backgroundColor: Colors.green, colorText: Colors.white);
    Get.toNamed("/signup");
    update();
  }

  Future<void> updatephoto(bool isDriver) async {
    photoIsLoading = true;
    update();
    await UserContoller().uploadImage(
        isDriver == true ? driverProfile!.uid! : profile!.uid!, isDriver);

    if (isDriver == true) {
      driverProfile = await authServices.getDriverData(driverProfile!.uid!);
      print(driverProfile!.name);
      print(driverProfile!.carmodele);
      print(driverProfile!.email);
      print(driverProfile!.image);
      print(driverProfile!.rating);
      print(driverProfile!.uid);
    } else {
      profile = await authServices.getuserdata(profile!.uid!);
      print(profile!.name);

      print(profile!.image);
      print(profile!.uid);
    }

    photoIsLoading = false;
    update();
  }
}
