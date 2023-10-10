import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Color maincolor = Color(0xff214c9b);
Color secondmaincolor = Color(0xff95bbe8);
Color maincolordarker = Color.fromARGB(255, 4, 38, 102);
Color beage = Color.fromARGB(255, 181, 181, 181);

Color maincolorlighter = Color.fromARGB(255, 82, 129, 218);
final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),

      // shadowColor: Colors.transparent,
      elevation: 0,
      backgroundColor: Colors.white,
    ),
    fontFamily: GoogleFonts.lato().fontFamily,
    // Add your light theme properties here
    // For example:
    textTheme: TextTheme(
      titleLarge: TextStyle(
          color: Color.fromARGB(255, 15, 15, 15),
          fontSize: 25,
          fontWeight: FontWeight.w900),
      bodyLarge: GoogleFonts.lato(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w800),
      bodySmall: GoogleFonts.lato(
          color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w700),
      headlineLarge: GoogleFonts.lato(
          color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900),

      titleSmall: GoogleFonts.lato(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w900),
      bodyMedium: GoogleFonts.lato(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w900),
      // Add more properties to customize the TextTheme
    ),
    primaryColor: Colors.blue,
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      accentColor: Colors.black,
    ));

final darkTheme = ThemeData(
    fontFamily: GoogleFonts.lato().fontFamily,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),

      // shadowColor: Colors.transparent,
      elevation: 0,
    ),

    // Add your light theme properties here
    // For example:
    textTheme: const TextTheme(
      bodySmall: TextStyle(
          color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
      headlineLarge: TextStyle(
          color: Colors.black, fontSize: 17, fontWeight: FontWeight.w900),
      titleLarge: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900),

      titleSmall: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900),
      bodyMedium: TextStyle(
          color: Colors.black, fontSize: 12, fontWeight: FontWeight.w700),
      // Add more properties to customize the TextTheme
    ),
    cardColor: const Color.fromARGB(255, 18, 1, 37),
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.indigo,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      accentColor: Colors.white,
    ));

Color green = Color(0xff2F9B7C);

Color pink = Color(0xffFFBE97);

Color white = Colors.white;

Color lightgreen = Color(0xff00C38F);
