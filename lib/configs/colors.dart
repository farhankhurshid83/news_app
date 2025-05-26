import 'package:flutter/material.dart';

// Light Theme Colors
const lightBgColor = Color(0xffFFFFFF);
const lightFontColor = Color(0xff191B28);
const lightDivColor = Color(0xffF5F6FA);
const lightPrimaryColor = Color(0xff0057FF);
const lightLabelColor = Color(0xff8E8E8E);

// Dark Theme Colors
const darkBgColor = Color(0xff191B28);
const darkFontColor = Color(0xffFFFFFF);
const darkDivColor = Color(0xff34374B);
const darkPrimaryColor = Color(0xffFF9900);
const darkLabelColor = Color(0xff9E9E9E);

const String fontFamily = 'Poppins'; // Define the font name

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightPrimaryColor,
  scaffoldBackgroundColor: lightBgColor,
  fontFamily: fontFamily, // Apply the font globally
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 18, color: lightFontColor, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 16, color: lightFontColor),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: lightFontColor),
    titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: lightFontColor),
  ),
  dividerColor: lightDivColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: lightBgColor,
    iconTheme: IconThemeData(color: lightFontColor),
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: lightFontColor, fontFamily: fontFamily),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: darkPrimaryColor,
  scaffoldBackgroundColor: darkBgColor,
  fontFamily: fontFamily, // Apply the font globally
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 18, color: darkFontColor, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 16, color: darkLabelColor),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: darkFontColor),
    titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: darkFontColor),
  ),
  dividerColor: darkDivColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: darkBgColor,
    iconTheme: IconThemeData(color: darkFontColor),
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkFontColor, fontFamily: fontFamily),
  ),
);
