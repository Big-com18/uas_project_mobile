import 'package:flutter/material.dart';
import '../../data/session.dart';
import '../../data/dummy_movies.dart';
import '../../model/movie_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Ambil nama user yang lagi login dari Session.
  // Kalau entah kenapa gak ada (misal langsung buka /home tanpa login),
  // fallback ke 'Movie Lover' biar gak nge-crash.
  String _greetingName() {
    final user = Session.currentUser;
    if (user == null || user.name.trim().isEmpty) return 'Movie Lover';
    // biar rapi: huruf awal tiap kata di-kapital ("admin" -> "Admin")
    return user.name
        .trim()
        .split(RegExp(r'\s+'))
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    // FIX: sebelumnya home_screen pakai data dummy Map<String,String> lokal
    // yang gak punya id, jadi kartunya gak bisa di-tap sama sekali (gak ada
    // GestureDetector-nya juga). Sekarang pakai dummyMovies (MovieModel asli,
    // punya `id`) biar bisa navigasi ke MovieDetailScreen yang bener.
    final nowPlaying = dummyMovies.where((m) => m.isNowPlaying).toList();
    final comingSoon = dummyMovies.where((m) => m.isComingSoon).toList();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- HEADER ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WELCOME BACK',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 11,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Hi, ${_greetingName()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1C1C28),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.search, color: Colors.white, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // ---------- NOW PLAYING ----------
            const Text(
              'Now Playing',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 260,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: nowPlaying.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final movie = nowPlaying[index];
                  return _NowPlayingCard(movie: movie);
                },
              ),
            ),
            const SizedBox(height: 28),

            // ---------- COMING SOON ----------
            const Text(
              'Coming Soon',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: comingSoon.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final movie = comingSoon[index];
                  return _ComingSoonCard(movie: movie);
                },
              ),
            ),
            const SizedBox(height: 100), // spasi biar ga ketutup navbar
          ],
        ),
      ),
    );
  }
}

// ---------- WIDGET CARD NOW PLAYING ----------
class _NowPlayingCard extends StatelessWidget {
  final MovieModel movie;

  const _NowPlayingCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/movie-detail',
          arguments: movie.id,
        );
      },
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C28),
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              movie.posterUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _placeholder(),
            ),

            // gradient overlay biar teks kebaca
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.85),
                  ],
                ),
              ),
            ),

            // konten teks
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${movie.rating}',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${movie.genres.join(', ')} • ${movie.durationLabel}',
                    style: TextStyle(color: Colors.grey[300], fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: const Color(0xFF1C1C28),
      alignment: Alignment.center,
      child: const Icon(Icons.movie_creation_outlined,
          color: Colors.white24, size: 42),
    );
  }
}

// ---------- WIDGET CARD COMING SOON ----------
class _ComingSoonCard extends StatelessWidget {
  final MovieModel movie;

  const _ComingSoonCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/movie-detail',
          arguments: movie.id,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 110,
          height: 130,
          color: const Color(0xFF1C1C28),
          child: Image.asset(
            movie.posterUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.movie_creation_outlined,
              color: Colors.white24,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}