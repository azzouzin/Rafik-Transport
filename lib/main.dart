import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/Controller/Middleware/middleware.dart';
import 'package:rafik/Controller/Services/tokens_service.dart';
import 'Controller/Bindings/homepagebindings.dart';
import 'View/Authpages/chosepage.dart';
import 'View/Authpages/signuppage.dart';
import 'View/Authpages/terms.dart';
import 'View/Compenents/theme.dart';
import 'View/Authpages/onboarding.dart';
import 'View/HomePages/DriverPages/driverhome.dart';
import 'View/HomePages/UserPages/homepage.dart';
import 'View/HomePages/UserPages/ridespage.dart';

String isOpend = "yes";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = new PostHttpOverrides();
  isOpend = await TokenController().getopend() ?? 'no';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      //  home: Example(title: 'HOHO'),
      home: TermesPage(),
      // initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const OneBoard(), middlewares: [
          LoginMiddle(isOpend),
        ]),
        GetPage(name: '/signup', page: () => const SignupPage()),
        GetPage(name: '/chose', page: () => ChosePage()),
        GetPage(
            name: '/homepage', page: () => HomePage(), binding: Homebindings()),
        GetPage(
            name: '/ridespage',
            page: () => RidesPage(),
            binding: Homebindings()),
        GetPage(
            name: '/driverhome',
            page: () => DriverHomePage(),
            binding: Homebindings()),
      ],
    );
  }
}

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
