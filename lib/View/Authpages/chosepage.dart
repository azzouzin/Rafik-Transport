import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/Controller/authcontroller.dart';
import 'package:rafik/View/Authpages/onboarding.dart';
import 'package:rafik/View/Authpages/signuppage.dart';
import 'package:rafik/View/Compenents/theme.dart';

class ChosePage extends StatefulWidget {
  ChosePage({super.key});

  @override
  State<ChosePage> createState() => _ChosePageState();
}

class _ChosePageState extends State<ChosePage> {
  Authcontroller authcontroller = Get.put(Authcontroller(), permanent: true);
  List<Color> _color = [Colors.white, Colors.white];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: Get.size.height * 0.02,
                    left: Get.size.width * 0.2,
                    right: Get.size.width * 0.2),
                child: Text(
                  'Join Our Helthcare Network',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: lightgreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Get.size.height * 0.02,
                    left: Get.size.width * 0.05,
                    right: Get.size.width * 0.05),
                child: Text(
                  'Register as a driver and make extra incom with us or as user and go whenever you want whetever you want ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.lightGreen,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: Get.size.height * 0.04,
                ),
                child: myButton(
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: Image.asset('assets/taxi.png')),
                        Text(
                          "Driver",
                          style: TextStyle(
                              color: _color[0] == lightgreen
                                  ? Colors.white
                                  : lightgreen,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ],
                    ),
                    color: _color[0],
                    height: Get.height * 0.8,
                    onprsd: () {
                      setState(() {
                        _color[0] =
                            _color[0] == lightgreen ? Colors.white : lightgreen;
                        _color[1] = Colors.white;
                      });
                    },
                    witdh: Get.width),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: Get.size.height * 0.04,
                ),
                child: myButton(
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: Image.asset('assets/taxi.png')),
                        Text(
                          "User",
                          style: TextStyle(
                              color: _color[1] == lightgreen
                                  ? Colors.white
                                  : lightgreen,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ],
                    ),
                    color: _color[1],
                    height: Get.height * 0.8,
                    onprsd: () {
                      print("clicked");
                      setState(() {
                        _color[1] =
                            _color[1] == lightgreen ? Colors.white : lightgreen;
                        _color[0] = Colors.white;
                      });
                    },
                    witdh: Get.width),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Get.size.height * 0.04,
                    bottom: Get.size.height * 0.04),
                child: myButton(
                    center: Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    color: lightgreen,
                    height: Get.height * 0.2,
                    onprsd: () {
                      if (_color[1] == lightgreen) {
                        authcontroller.setAccountTypetoUser();
                      } else {
                        authcontroller.setAccountTypetoDriver();
                      }
                      Get.to(SignupPage());
                    },
                    witdh: Get.width),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myButton(
      {required double height,
      required double witdh,
      required Function onprsd,
      required Color color,
      required Widget center}) {
    return InkWell(
      onTap: () {
        onprsd();
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: witdh * 0.8,
          height: height * 0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: color,
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 10),
              ]),
          child: Center(child: center)),
    );
  }
}
