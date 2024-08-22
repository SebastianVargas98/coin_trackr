import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _FontSizes {
  static double scale = 1;

  static double get overLine => 10 * scale;
  static double get caption => 12 * scale;
  static double get bodyText2 => 14 * scale;
  static double get bodyText1 => 16 * scale;
  static double get subtitle2 => 18 * scale;
  static double get headline6 => 20 * scale;
  static double get headline55 => 22 * scale;
  static double get headline5 => 24 * scale;
  static double get headline4 => 34 * scale;
  static double get headline3 => 48 * scale;
  static double get headline2 => 60 * scale;
  static double get headline1 => 96 * scale;
}

Color? staticColor(Color? color) => color;

class TextStyles {
  static TextStyle get pOverLine =>
      GoogleFonts.poppins(fontSize: _FontSizes.overLine);
  static TextStyle get pCaption =>
      GoogleFonts.poppins(fontSize: _FontSizes.caption);
  static TextStyle get pBody2 =>
      GoogleFonts.poppins(fontSize: _FontSizes.bodyText2);
  static TextStyle get pBody1 =>
      GoogleFonts.poppins(fontSize: _FontSizes.bodyText1);
  static TextStyle get pSubtitle2 =>
      GoogleFonts.poppins(fontSize: _FontSizes.subtitle2);
  static TextStyle get pHeadline6 =>
      GoogleFonts.poppins(fontSize: _FontSizes.headline6);
  static TextStyle get pHeadline55 =>
      GoogleFonts.poppins(fontSize: _FontSizes.headline55);
  static TextStyle get pHeadline5 =>
      GoogleFonts.poppins(fontSize: _FontSizes.headline5);
  static TextStyle get pHeadline4 =>
      GoogleFonts.poppins(fontSize: _FontSizes.headline4);
  static TextStyle get pHeadline3 =>
      GoogleFonts.poppins(fontSize: _FontSizes.headline3);
  static TextStyle get pHeadline2 =>
      GoogleFonts.poppins(fontSize: _FontSizes.headline2);
  static TextStyle get pHeadline1 =>
      GoogleFonts.poppins(fontSize: _FontSizes.headline1);

  static TextStyle get wOverLine =>
      GoogleFonts.workSans(fontSize: _FontSizes.overLine);
  static TextStyle get wCaption =>
      GoogleFonts.workSans(fontSize: _FontSizes.caption);
  static TextStyle get wBody2 =>
      GoogleFonts.workSans(fontSize: _FontSizes.bodyText2);
  static TextStyle get wBody1 =>
      GoogleFonts.workSans(fontSize: _FontSizes.bodyText1);
  static TextStyle get wSubtitle2 =>
      GoogleFonts.workSans(fontSize: _FontSizes.subtitle2);
  static TextStyle get wHeadline6 =>
      GoogleFonts.workSans(fontSize: _FontSizes.headline6);
  static TextStyle get wHeadline55 =>
      GoogleFonts.workSans(fontSize: _FontSizes.headline55);
  static TextStyle get wHeadline5 =>
      GoogleFonts.workSans(fontSize: _FontSizes.headline5);
  static TextStyle get wHeadline4 =>
      GoogleFonts.workSans(fontSize: _FontSizes.headline4);
  static TextStyle get wHeadline3 =>
      GoogleFonts.workSans(fontSize: _FontSizes.headline3);
  static TextStyle get wHeadline2 =>
      GoogleFonts.workSans(fontSize: _FontSizes.headline2);
  static TextStyle get wHeadline1 =>
      GoogleFonts.workSans(fontSize: _FontSizes.headline1);

  static TextStyle get qHeadline4 =>
      GoogleFonts.quantico(fontSize: _FontSizes.headline4);
}

extension TextStyleHelpers on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle staticColor(Color staticColor) => copyWith(color: staticColor);

  TextStyle fontHeight(double height) => copyWith(height: height);

  TextStyle letterSpace(double letterSpacing) =>
      copyWith(letterSpacing: letterSpacing);
}
