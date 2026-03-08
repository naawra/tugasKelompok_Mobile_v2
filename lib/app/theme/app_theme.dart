import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  // Core palette
  static const sand = Color(0xFFC1AD92);
  static const navy = Color(0xFF1F2640);
  static const blue = Color(0xFF2275DD);
  static const deepBlue = Color(0xFF254EA0);
  static const charcoal = Color(0xFF444355);
  static const slate = Color(0xFF7793C0);

  // Derived
  static const background = Color(0xFFF5F0EA);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceWarm = Color(0xFFFAF6F1);
  static const divider = Color(0xFFE8DFCF);
  static const textPrimary = Color(0xFF1F2640);
  static const textSub = Color(0xFF7793C0);

  // Gradients
  // static const LinearGradient appBarGradient = LinearGradient(
  //   colors: [navy, deepBlue],
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  // );

  // static const LinearGradient heroGradient = LinearGradient(
  //   colors: [navy, deepBlue, blue],
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   stops: [0.0, 0.55, 1.0],
  // );

  // static const LinearGradient sandGradient = LinearGradient(
  //   colors: [sand, Color(0xFFD4C4AD)],
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  // );

  // static const LinearGradient accentGradient = LinearGradient(
  //   colors: [deepBlue, blue],
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  // );

  // Per-menu accent (start, end)
  static const List<List<Color>> menuColors = [
    [navy, charcoal],
    [deepBlue, blue],
    [blue, slate],
    [charcoal, navy],
    [Color(0xFF1A3A6B), deepBlue],
    [Color(0xFF3A3250), charcoal],
  ];
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.deepBlue,
        brightness: Brightness.light,
        surface: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.deepBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        labelStyle: const TextStyle(color: AppColors.charcoal, fontSize: 14),
        floatingLabelStyle: const TextStyle(
            color: AppColors.deepBlue, fontWeight: FontWeight.w600),
        prefixIconColor: AppColors.slate,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deepBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.divider, width: 1),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5),
      ),
    );
  }
}
