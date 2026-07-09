import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  late final AnimationController _animationController;
  late final Animation<double> _floatAnimation;

  final List<_OnboardingStep> _steps = const [
    _OnboardingStep(
      title: 'Jelajahi Film',
      description:
          'Telusuri rilis baru dan baca ulasan dengan antarmuka tanpa gangguan.',
      svgAsset: 'assets/images/Onboarding Step 1.svg',
      svgHeight: 192,
    ),
    _OnboardingStep(
      title: 'Pilih Kursi',
      description:
          'Amankan kursi pilihan Anda dalam hitungan detik. Cepat dan presisi.',
      svgAsset: 'assets/images/Onboarding Step 2.svg',
      svgHeight: 154,
    ),
    _OnboardingStep(
      title: 'Akses Eksklusif',
      description:
          'Kumpulkan poin dan nikmati pengalaman sinema premium khusus anggota.',
      svgAsset: 'assets/images/Onboarding Step 3.svg',
      svgHeight: 180,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Tombol "LEWATI" -> langsung diarahkan ke halaman Register
  void _onSkipTap() {
    Navigator.pushReplacementNamed(context, '/welcome');
  }

  // Tombol "Lanjut" / "Mulai Sekarang" -> di halaman terakhir diarahkan ke Register
  void _onNextTap() {
    if (_currentPageIndex < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentPageIndex == _steps.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D14),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerRight,
              child: AnimatedOpacity(
                opacity: isLastPage ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: IgnorePointer(
                  ignoring: isLastPage,
                  child: TextButton(
                    onPressed: _onSkipTap,
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF71717B),
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(60, 44),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'LEWATI',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _steps.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final step = _steps[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 0),
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _floatAnimation.value),
                            child: child,
                          );
                        },
                        child: SizedBox(
                          height: 200,
                          child: Center(
                            child: SvgPicture.asset(
                              step.svgAsset,
                              height: step.svgHeight,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      Column(
                        children: [
                          // Title Text
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              step.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Description Text
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              step.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF71717B),
                                fontSize: 14,
                                height: 1.5,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_steps.length, (index) {
                  final bool isActive = _currentPageIndex == index;
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.only(
                        left: index == 0 ? 0 : 4,
                        right: index == _steps.length - 1 ? 0 : 4,
                      ),
                      height: 2,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFFFF6900) // Active vibrant orange
                            : const Color(0xFF27272A), // Inactive dark grey
                        borderRadius: BorderRadius.circular(1.5),
                      ),
                    ),
                  );
                }),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onNextTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isLastPage
                        ? const Color(0xFFFF6900) // Highlight Orange
                        : const Color(0xFF18181B), // Dark Grey
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isLastPage ? 'Mulai Sekarang' : 'Lanjut',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isLastPage
                              ? FontWeight.bold
                              : FontWeight.w600,
                        ),
                      ),
                      if (!isLastPage) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: Colors.white,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingStep {
  final String title;
  final String description;
  final String svgAsset;
  final double? svgHeight;

  const _OnboardingStep({
    required this.title,
    required this.description,
    required this.svgAsset,
    this.svgHeight,
  });
}