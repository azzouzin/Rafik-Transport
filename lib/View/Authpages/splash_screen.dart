import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rafik/Controller/Services/auth_services.dart';
import 'package:rafik/Controller/authcontroller.dart';
import 'package:rafik/Model/driver.dart';
import 'package:rafik/Model/user.dart';
import 'package:rafik/View/Authpages/onboarding.dart';
import 'package:rafik/View/Compenents/theme.dart';
import 'package:rafik/View/HomePages/UserPages/homepage.dart';
import 'package:rive/rive.dart';

import '../../Helpers/translate_helper.dart';
import '../Compenents/components.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Authcontroller authcontroller = Get.put(Authcontroller());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialasiang();
  }

  String language = "ar";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset("assets/logo.png"),
          ListTile(
            onTap: () {},
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Icon(Iconsax.language_circle, color: Colors.grey),
            ),
            title: Text(getStatment("Language"),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.apply(color: Colors.white)),
            trailing: DropdownButton<String>(
                elevation: 10,
                value: language,
                items: const [
                  DropdownMenuItem<String>(value: "ar", child: Text("العربية")),
                  DropdownMenuItem(
                    child: Text("Francais"),
                    value: "fr",
                  ),
                  DropdownMenuItem(
                    child: Text("English"),
                    value: "en",
                  )
                ],
                onChanged: (value) {
                  print(value);
                  setState(() {
                    language = value!;
                  });
                  changeLanguage(language);

                  print(language);
                }),
          ),
          Loader(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(Get.width * 0.95, Get.height * 0.075),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                Get.to(OneBoard());
              },
              child: Text("!start",
                  style:
                      Get.theme.textTheme.titleLarge!.copyWith(color: white)))
        ],
      )),
    );
  }

  void initialasiang() async {
    if (FirebaseAuth.instance.currentUser != null) {
      Driver? driver = await authcontroller
          .getDriverData(FirebaseAuth.instance.currentUser!.uid);
      if (driver == null) {
        AppUser? appUser = await authcontroller
            .getUserData(FirebaseAuth.instance.currentUser!.uid);
        if (appUser!.isDriver == false) {
          Get.toNamed("/homepage");
        } else {
          Get.toNamed("/driverhome");
        }
      } else {
        if (driver!.isDriver == true) {
          Get.toNamed("/driverhome");
        } else {
          Get.toNamed("/homepage");
        }
      }
    } else {
      Future.delayed(Duration(seconds: 3));
      //  Get.to(OneBoard());
    }
  }
}
