import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Font pakai Poppins karena paling mendekati bentuk huruf di screenshot
/// (geometric sans, agak rounded). Kalau ternyata font aslinya beda
/// (misal Inter / Plus Jakarta Sans / SF Pro), tinggal ganti
/// `GoogleFonts.poppins` jadi `GoogleFonts.<namaFont>` di file ini aja.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _base({
    required double size,
    required FontWeight weight,
    Color color = AppColors.textPrimary,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Headings
  static TextStyle h1 = _base(size: 24, weight: FontWeight.w600);
  static TextStyle h2 = _base(size: 20, weight: FontWeight.w600);
  static TextStyle h3 = _base(size: 17, weight: FontWeight.w600);

  // Body
  static TextStyle bodyLarge = _base(size: 15, weight: FontWeight.w400);
  static TextStyle bodyMedium = _base(size: 13, weight: FontWeight.w400);
  static TextStyle bodySmall = _base(size: 11, weight: FontWeight.w400);

  // Secondary / muted
  static TextStyle caption = _base(
    size: 12,
    weight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
  static TextStyle captionSmall = _base(
    size: 10,
    weight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // Button
  static TextStyle button = _base(
    size: 15,
    weight: FontWeight.w600,
    color: Colors.white,
  );

  // Label kecil semi bold (misal "WELCOME BACK", badge)
  static TextStyle labelSmall = _base(
    size: 10,
    weight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.6,
  );
}
