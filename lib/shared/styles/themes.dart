import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:To_Know_Me/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: "myFont",
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      height: 1.5,
    ),
    caption: TextStyle(
      fontSize: 12.0,
    ),
  ),
  primarySwatch: defaultColor,
  appBarTheme: const AppBarTheme(
    titleSpacing: 10,
    // backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFFD6D6D6),
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white70,
    elevation: 5.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: "myFont",
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Color(0xFFEEEEEE),
  ),
  scaffoldBackgroundColor: Colors.white,
);

ThemeData darkTheme = ThemeData(
  fontFamily: "myFont",
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    // backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('343639'),
    elevation: 5.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: HexColor('#292C2E'),
    indicatorColor: Colors.white,
    labelTextStyle: MaterialStateProperty.all(
      TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  scaffoldBackgroundColor: HexColor('#292C2E'),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      height: 1.5,
    ),
    caption: TextStyle(
      fontSize: 12.0,
    ),
  ),
);
