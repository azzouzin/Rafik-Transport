import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/Controller/Services/auth_services.dart';
import 'package:rafik/Controller/Services/tokens_service.dart';

class LoginMiddle extends GetMiddleware {
  final String isOpend;

  LoginMiddle(this.isOpend);

  var auth = FirebaseAuth.instance;
  @override
  RouteSettings? redirect(String? route) {
    // String? isOpend = TokenController().getopend();

    if (isOpend == "no") {
      return null;
    } else {
      if (auth.currentUser == null) {
        print("Current user = null");
      } else {
        print(auth.currentUser!.email);
        AuthServices().getuserdata(auth.currentUser!.uid);

        return RouteSettings(name: "/chose");
      }
    }
    //  return null;
  }
}
