import 'package:flutter/material.dart';

/// PENTING:
/// Warna di bawah ini adalah HASIL ESTIMASI dari screenshot yang kamu kasih.
/// Kalau kamu punya file Figma / design system asli, kasih tau hex code
/// pastinya nanti tinggal ganti di sini aja (satu sumber kebenaran / single
/// source of truth), semua screen otomatis ikut berubah.
class AppColors {
  AppColors._();

  // Background utama (hampir hitam, sedikit ke navy)
  static const Color background = Color(0xFF0A0A0F);

  // Card / surface (sedikit lebih terang dari background)
  static const Color surface = Color(0xFF15151C);
  static const Color surfaceLight = Color(0xFF1E1E27);
  static const Color surfaceBorder = Color(0xFF2A2A34);

  // Bottom nav bar
  static const Color navBar = Color(0xFF121218);

  // Accent / primary orange (tombol, highlight, active state)
  static const Color primary = Color(0xFFFF6A1A);
  static const Color primaryDark = Color(0xFFE85A0C);

  // Gradient accent (dipakai di poster placeholder / hero)
  static const List<Color> primaryGradient = [
    Color(0xFFFF8A3D),
    Color(0xFFE0491A),
  ];

  // Text
  static const Color textPrimary = Color(0xFFF5F5F7);
  static const Color textSecondary = Color(0xFF9A9AA6);
  static const Color textMuted = Color(0xFF6B6B76);

  // Status
  static const Color success = Color(0xFF34C759);
  static const Color star = Color(0xFFFFC107);
  static const Color danger = Color(0xFFFF4D4D);

  // Chip / genre tag background
  static const Color chipBackground = Color(0xFF1E1E27);
}
