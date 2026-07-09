import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _kBg = Color(0xFF060913);
const _kOrange = Color(0xFFFF6B00);

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 24),

              // ---------- LOGO + BRAND ----------
              SvgPicture.asset(
                'assets/icons/logo.svg',
                width: 28,
                height: 28,
                colorFilter:
                    const ColorFilter.mode(_kOrange, BlendMode.srcIn),
                placeholderBuilder: (context) =>
                    const Icon(Icons.movie_filter, color: _kOrange, size: 28),
              ),
              const SizedBox(height: 10),
              const Text(
                'CINEPHILE ZONE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 4,
                ),
              ),

              const Spacer(flex: 3),

              // ---------- HEADLINE ----------
              const Text(
                'Perjalanan\nSinematik Anda\nDimulai di Sini',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Bergabunglah dengan komunitas utama\npecinta film. Pesan tiket, dapatkan\nhadiah, dan banyak lagi.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 13,
                  height: 1.5,
                ),
              ),

              const Spacer(flex: 2),

              // ---------- BUTTONS ----------
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Buat Akun',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}