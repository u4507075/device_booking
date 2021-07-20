import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const headingTextSize = 26.0;
const largeTextSize = 22.0;
const mediumTextSize = 18.0;
const smallTextSize = 14.0;
// const fontFamily1 = 'roboto';

final appBarTextStyle = GoogleFonts.prompt(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: mediumTextSize,
        color: Colors.white));

final h1TextStyle = GoogleFonts.prompt(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: headingTextSize,
        color: Colors.black));

final h2TextStyle = GoogleFonts.prompt(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: largeTextSize,
        color: Colors.black));

final h3TextStyle = GoogleFonts.prompt(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: mediumTextSize,
        color: Colors.black));

final b1TextStyle = GoogleFonts.prompt(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: mediumTextSize,
        color: Colors.black));

final b2TextStyle = GoogleFonts.prompt(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: smallTextSize,
        color: Colors.black));

// TextStyle? headline1,
//     TextStyle? headline2,
//     TextStyle? headline3,
//     TextStyle? headline4,
//     TextStyle? headline5,
//     TextStyle? headline6,
//     TextStyle? subtitle1,
//     TextStyle? subtitle2,
//     TextStyle? bodyText1,
//     TextStyle? bodyText2,
