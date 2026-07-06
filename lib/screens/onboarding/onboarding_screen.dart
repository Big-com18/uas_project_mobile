import 'package:flutter/material.dart';
import '../../main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingItem {
  final String title;
  final String desc;
  _OnboardingItem(this.title, this.desc);
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  final List<_OnboardingItem> _items = [
    _OnboardingItem(
      'Temukan Film Favoritmu',
      'Jelajahi ratusan film terbaru dari berbagai genre, kapan saja dan di mana saja.',
    ),
    _OnboardingItem(
      'Cari Bioskop Terdekat',
      'Lihat daftar bioskop terdekat lengkap dengan jadwal tayang yang tersedia.',
    ),
    _OnboardingItem(
      'Pesan Tiket Mudah',
      'Beli tiket bioskop hanya dengan beberapa ketukan, cepat dan tanpa ribet.',
    ),
  ];

  bool get _isLastPage => _index == _items.length - 1;

  void _goToAuthChoice() {
    Navigator.pushReplacementNamed(context, AppRoutes.authChoice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: _goToAuthChoice,
                  child: const Text(
                    'Lewati',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _items.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) {
                  final item = _items[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          height: 170,
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.card,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.35),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                              ),
                            ],
                          ),
                          // TODO: ganti asset ini dengan logo aplikasi kamu sendiri.
                          // Filenya ada di assets/images/logo.png — tinggal timpa
                          // file itu dengan gambar kamu (ukuran persegi, PNG transparan
                          // lebih bagus), pubspec.yaml sudah otomatis membacanya.
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item.desc,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _index == i ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _index == i ? AppColors.primary : AppColors.card,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: _isLastPage
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _goToAuthChoice,
                        child: const Text('Mulai Sekarang'),
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text('Lanjut'),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
