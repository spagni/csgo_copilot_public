import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static const Color backgroundColor = Color(0xFF23232F);
  static const Color royalBlue = Color(0xFF604FEF);
  static const Color violet = Color(0xFFA74DBC);
}

class Constants {
  static const String appTitle = 'CSGO Copilot';
}

class Themes {
  static ThemeData dark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Styles.backgroundColor,
    primaryColor: Styles.backgroundColor,
    accentColor: Styles.royalBlue,
    // cursorColor: Colors.teal,
    highlightColor: Colors.red,
    focusColor: Colors.red,
    indicatorColor: Colors.red,
    textTheme: _getTextTheme(color: Colors.white),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      centerTitle: true,
    ),
  );

  static TextTheme _getTextTheme({Color color}) {
    return TextTheme(
      headline1: GoogleFonts.poppins(
        fontSize: 93,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
        color: color,
      ),
      headline2: GoogleFonts.poppins(
        fontSize: 58,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
        color: color,
      ),
      headline3: GoogleFonts.poppins(
        fontSize: 46,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      headline4: GoogleFonts.poppins(
        fontSize: 33,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: color,
      ),
      headline5: GoogleFonts.poppins(
        fontSize: 23,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      headline6: GoogleFonts.poppins(
        fontSize: 19,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: color,
      ),
      subtitle1: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: color,
      ),
      subtitle2: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: color,
      ),
      bodyText1: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: color,
      ),
      bodyText2: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: color,
      ),
      button: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        color: color,
      ),
      caption: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: color,
      ),
      overline: GoogleFonts.roboto(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        color: color,
      ),
    );
  }
}
