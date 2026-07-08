import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../feature/home/home_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 0;

  // Movies, Location, Profile belum dibuat -> pakai placeholder dulu
  final List<Widget> _pages = const [
    HomeScreen(),
    _ComingSoonPage(label: 'Movies'),
    _ComingSoonPage(label: 'Location'),
    _ComingSoonPage(label: 'Profile'),
  ];

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    // ---------- STACK, BUKAN bottomNavigationBar ----------
    // Sengaja pakai Stack supaya konten (list film) tetap bisa
    // discroll sampai benar-benar mentok bawah, dan navbar
    // "ngambang" transparan di atasnya (bukan mendorong konten
    // ke atas seperti bottomNavigationBar bawaan Scaffold).
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D14),
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  // ---------- CUSTOM BOTTOM NAVBAR ----------
  static const List<String> _navIconPaths = [
    'assets/icons/home.svg',
    'assets/icons/film.svg',
    'assets/icons/cinema.svg',
    'assets/icons/profile.svg',
  ];

  Widget _buildBottomNav() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: ClipRRect(
        // radius sama kayak container-nya, wajib biar blur ikut kepotong rapi
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          // efek "kaca buram" -> konten yang discroll di baliknya
          // keliatan samar-samar lewat navbar, bukan solid opaque
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            height: 68,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              // warna SAMA PERSIS kayak scaffoldBackgroundColor home,
              // cuma dikasih opacity 70% biar keliatan transparan
              color: const Color(0xFF0D0D14).withOpacity(0.7),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_navIconPaths.length, (index) {
                final bool isActive = _selectedIndex == index;

                return GestureDetector(
                  onTap: () => _onTabTapped(index),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.orange.withOpacity(0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SvgPicture.asset(
                      _navIconPaths[index],
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        isActive ? Colors.orange : Colors.grey[600]!,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- PLACEHOLDER SEMENTARA ----------
class _ComingSoonPage extends StatelessWidget {
  final String label;
  const _ComingSoonPage({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$label\n(belum dibuat)',
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }
}