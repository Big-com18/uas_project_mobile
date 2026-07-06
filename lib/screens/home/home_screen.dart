import 'package:flutter/material.dart';
import '../../main.dart';
import '../../data/dummy_data.dart';
import '../../widgets/movie/movie_card.dart';
import '../../widgets/cinema/cinema_card.dart';
import '../../widgets/nav/bottom_nav.dart';
import '../movie/movie_list_screen.dart';
import '../cinema/cinema_list_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  late final List<Widget> _pages = [
    _BerandaTab(username: widget.username),
    const MovieListScreen(embedded: true),
    const CinemaListScreen(embedded: true),
    ProfileScreen(username: widget.username),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_navIndex]),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }
}

class _BerandaTab extends StatelessWidget {
  final String username;
  const _BerandaTab({required this.username});

  @override
  Widget build(BuildContext context) {
    final movies = DummyData.movies;
    final cinemas = DummyData.cinemas.take(3).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Halo, selamat datang 👋',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  Text(
                    username.isEmpty ? 'Movie Lover' : username,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.card,
                child: Text(
                  username.isNotEmpty ? username[0].toUpperCase() : 'M',
                  style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, Color(0xFFB3202B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Promo Spesial!',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 6),
                      Text('Diskon 20% untuk pembelian tiket hari ini',
                          style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.local_activity_rounded, color: Colors.white, size: 42),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _sectionHeader(context, 'Film Populer', () {
            Navigator.pushNamed(context, AppRoutes.movieList);
          }),
          const SizedBox(height: 12),
          SizedBox(
            height: 230,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, i) => MovieCard(movie: movies[i]),
            ),
          ),
          const SizedBox(height: 24),
          _sectionHeader(context, 'Bioskop Terdekat', () {
            Navigator.pushNamed(context, AppRoutes.cinemaList);
          }),
          const SizedBox(height: 12),
          ...cinemas.map((c) => CinemaCard(cinema: c)),
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                color: AppColors.textPrimary, fontSize: 17, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text('Lihat Semua',
              style: TextStyle(color: AppColors.accent, fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
