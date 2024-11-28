import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/styles/colors.dart';

ThemeData lightTheme = ThemeData(

  primarySwatch: defultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      titleSpacing: 20,
      iconTheme: IconThemeData(
          color: Colors.black,
          size: 30
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),




  ),
  textTheme:  const TextTheme(
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black
      )
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defultColor
  ),

);
ThemeData darkTheme = ThemeData(
  textTheme:  const TextTheme(
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        fontFamily: 'Aas'
      )
  ),
  primarySwatch: defultColor,
  scaffoldBackgroundColor: Colors.grey[800],
  appBarTheme:  AppBarTheme(
      titleSpacing: 20,
      iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30
      ),
      backgroundColor: Colors.grey[800],
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black12,
          statusBarIconBrightness: Brightness.light
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      )



  ),

  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.grey[800]
  ),

);