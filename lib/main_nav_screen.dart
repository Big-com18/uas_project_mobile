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
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D14),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ---------- CUSTOM BOTTOM NAVBAR ----------
  // Tiap tab pakai 1 file svg yang sama, warnanya di-tint pakai
  // ColorFilter (orange kalau aktif, abu-abu kalau tidak).
  static const List<String> _navIconPaths = [
    'assets/icons/home.svg',
    'assets/icons/film.svg',
    'assets/icons/cinema.svg',
    'assets/icons/profile.svg',
  ];

  Widget _buildBottomNav() {
    return Container(
      height: 68,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF15151F),
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
