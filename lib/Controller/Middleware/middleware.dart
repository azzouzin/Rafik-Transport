import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/Controller/Services/tokens_service.dart';

class LoginMiddle extends GetMiddleware {
  final String isOpend;

  LoginMiddle(this.isOpend);
  @override
  RouteSettings? redirect(String? string) {
    // String? isOpend = TokenController().getopend();
    if (isOpend == "no") {
      return null;
    } else {
      return RouteSettings(name: "/chose");
    }
    //  return null;
  }
}
