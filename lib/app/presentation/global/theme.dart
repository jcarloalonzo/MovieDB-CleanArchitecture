import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData getTheme(bool darkMode) {
  // return darkMode ? ThemeData.dark() : ThemeData.light();
  if (darkMode) {
    final darkTheme = ThemeData.dark();
    const boldStyle = TextStyle(fontWeight: FontWeight.bold);
    const whiteStyle = TextStyle(color: Colors.white);

    return darkTheme.copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.dark,
          elevation: 0,
        ),
        textTheme:
            GoogleFonts.nunitoSansTextTheme(darkTheme.textTheme).copyWith(
                // titleSmall: lightTheme.textTheme.titleSmall?.copyWith(
                // color: Palette.dark,
                // fontWeight: FontWeight.bold,
                // ),
                titleSmall: darkTheme.textTheme.titleSmall?.merge(boldStyle),
                titleMedium: darkTheme.textTheme.titleMedium?.merge(boldStyle),
                titleLarge: darkTheme.textTheme.titleLarge?.merge(boldStyle),
                bodySmall: darkTheme.textTheme.bodySmall?.merge(whiteStyle)),
        scaffoldBackgroundColor: Palette.darkLight,
        // canvas color es  las listas de opciones en dropdown
        canvasColor: Palette.dark,
        switchTheme: SwitchThemeData(
          trackColor:
              MaterialStatePropertyAll(Colors.lightBlue.withOpacity(0.5)),
          thumbColor: const MaterialStatePropertyAll(Colors.blue),
        ));
  }

  final lightTheme = ThemeData.light();
  const boldStyle = TextStyle(fontWeight: FontWeight.bold, color: Palette.dark);
  const darkStyle = TextStyle(color: Palette.dark);

  return lightTheme.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Palette.dark,
        ),
        titleTextStyle: TextStyle(
          color: Palette.dark,
        ),
      ),
      textTheme: GoogleFonts.nunitoSansTextTheme(
        lightTheme.textTheme.copyWith(
          titleSmall: lightTheme.textTheme.titleSmall?.merge(boldStyle),
          // titleMedium: lightTheme.textTheme.titleMedium?.copyWith(
          //   color: Palette.dark,
          //   fontWeight: FontWeight.bold,
          // ),
          titleMedium: lightTheme.textTheme.titleMedium?.merge(boldStyle),
          titleLarge: lightTheme.textTheme.titleLarge?.merge(boldStyle),
          bodySmall: lightTheme.textTheme.bodySmall?.merge(darkStyle),
        ),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Palette.dark,
      ));
}
