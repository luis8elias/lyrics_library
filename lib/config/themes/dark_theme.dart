import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '/utils/utils.dart';


final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: _darkColorScheme.inverseSurface.withOpacity(0.5),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: _darkColorScheme.onSurface,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    textTheme: GoogleFonts.openSansTextTheme(
      TextTheme(
        titleMedium: TextStyle(
          fontSize: 22,
          color: _darkColorScheme.onBackground,
          fontWeight: FontWeight.bold
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          color: _darkColorScheme.onBackground,
          fontWeight: FontWeight.bold
        ),
        displaySmall: TextStyle(
          fontSize: 16,
          color: _darkColorScheme.onBackground,
          fontWeight: FontWeight.normal
        ),
        bodyMedium: TextStyle(
          color: _darkColorScheme.onSecondary,
          fontSize: 14
        ),
        bodySmall: TextStyle(
          color: _darkColorScheme.onSecondary,
          fontSize: 10
        ),
        displayMedium: TextStyle(
          fontSize: 20,
          color: _darkColorScheme.onPrimary,
          fontWeight: FontWeight.w700
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          color: _darkColorScheme.primary,
          fontWeight: FontWeight.w500
        ),
        
        // bodySmall: TextStyle(color: _darkColorScheme.onBackground),
        // bodyLarge: TextStyle(color: _darkColorScheme.onBackground),
        // bodyMedium: TextStyle(
        //   color: _darkColorScheme.onBackground),
        // displayLarge: TextStyle(color: _darkColorScheme.onBackground),
        // displayMedium: TextStyle(color: _darkColorScheme.onBackground),
        // displaySmall: TextStyle(
        //   color: _darkColorScheme.onSurface,
        //   fontSize: 24,
        //   fontWeight: FontWeight.w700,
        // ),
        // labelLarge: TextStyle(color: _darkColorScheme.onBackground),
        // labelMedium: TextStyle(color: _darkColorScheme.onBackground),
        // labelSmall: TextStyle(color: _darkColorScheme.onBackground),
        // titleSmall: TextStyle(color: _darkColorScheme.onBackground),
        // titleLarge: TextStyle(
        //   color: _darkColorScheme.onSurface,
        //   fontSize: 18,
        // ),
        // titleMedium: TextStyle(
        //   fontSize: 18,
        //   color: _darkColorScheme.onSurface,
        //   fontWeight: FontWeight.bold,
        // ),
      )
    ),
    primaryColor: _darkColorScheme.primary,
    hintColor: _darkColorScheme.onBackground,
    scaffoldBackgroundColor: _darkColorScheme.background,
    dividerColor: _darkColorScheme.onBackground,
    colorScheme: _darkColorScheme,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      //fillColor: DarkTheme.surface1Color,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.kBorderRadius),
        borderSide: BorderSide(color: _darkColorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.kBorderRadius),
        borderSide:  BorderSide(color: _darkColorScheme.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.kBorderRadius),
        borderSide:  BorderSide(color: _darkColorScheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.kBorderRadius),
        borderSide:  BorderSide(color: _darkColorScheme.error),
      ),
    ),
  );

 final _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: const Color(0xFFa2f263),
  primaryContainer: const Color(0xFFa2f263).withOpacity(0.15),
  onPrimary: const Color(0xff060708),
  secondary: const Color(0xFF636366),
  onSecondary: const Color(0xFFEBEBF5).withOpacity(0.60),
  tertiary: const Color(0xFFff8862),
  error: const Color.fromARGB(255, 255, 103, 95),
  onError: const Color(0xFFFFFFFF),
  outline: const Color(0xFF8B9198),
  background: const Color(0xff1e2528),
  onBackground: const Color(0xFFFFFFFF),
  surface: const Color.fromARGB(255, 40, 49, 53),
  onSurface: const Color(0xFFF9F9F9),
  surfaceVariant: const Color(0xFF1D2427),
  onSurfaceVariant: const Color(0xFFC1C7CE),
  inverseSurface: const Color.fromARGB(255, 48, 59, 64),
);