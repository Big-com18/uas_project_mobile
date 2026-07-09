import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Memberikan jeda waktu 3 detik agar animasi loading bar selesai
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Arahkan ke halaman Onboarding (Sesuaikan route jika Anda menggunakan Get Started)
    Navigator.pushReplacementNamed(context, '/onboarding'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          // Meniru efek glow (pendaran) coklat/oranye gelap di tengah latar belakang
          gradient: RadialGradient(
            colors: [
              Color(0xFF281F1A), // Warna glow hangat di tengah
              AppColors.background, // Warna background gelap di tepi (#0F172A)
            ],
            radius: 1.2,
            center: Alignment.center,
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 5),
            
            // Teks Judul (CINEPHILE ZONE)
            Text(
              'CINEPHILE ZONE',
              style: AppTextStyles.h1.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 26,
                letterSpacing: 6.0, // Jarak antar huruf yang lebar
              ),
            ),
            const SizedBox(height: 16),
            
            // Sub-teks (YOUR CINEMATIC JOURNEY)
            Text(
              'YOUR CINEMATIC JOURNEY',
              style: AppTextStyles.caption.copyWith(
                color: const Color(0xFFA0AAB2), // Warna abu-abu kebiruan
                fontWeight: FontWeight.w600,
                fontSize: 11,
                letterSpacing: 3.0, // Jarak antar huruf
              ),
            ),
            
            const Spacer(flex: 3),
            
            // Animated Progress Bar (Bilah Loading Oranye)
            SizedBox(
              width: 160, // Lebar garis loading
              child: TweenAnimationBuilder<double>(
                // Animasi dari 0 (kosong) ke 1 (penuh)
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(seconds: 3), // Durasi sama dengan Future.delayed
                builder: (context, value, _) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: value,
                      backgroundColor: const Color(0xFF242B38), // Warna trek rel abu-abu gelap
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primary, // Warna indikator oranye
                      ),
                      minHeight: 4,
                    ),
                  );
                },
              ),
            ),
            
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}