import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ---------- DUMMY DATA ----------
  // Pakai file dummy1.jpg - dummy5.jpg dari assets/images/
  // Ganti title/genre/rating sesuai film aslinya nanti.
  static const List<Map<String, String>> _nowPlaying = [
    {
      'title': 'Dune: Part Two',
      'genre': 'Sci-Fi',
      'duration': '2h 46m',
      'rating': '4.8',
      'imageAsset': 'assets/images/dummy1.jpg',
    },
    {
      'title': 'Dune: Part One',
      'genre': 'Sci-Fi',
      'duration': '2h 46m',
      'rating': '4.8',
      'imageAsset': 'assets/images/dummy2.jpg',
    },
  ];

  static const List<Map<String, String>> _comingSoon = [
    {'title': 'Interstellar', 'imageAsset': 'assets/images/dummy3.jpg'},
    {'title': 'Spectre', 'imageAsset': 'assets/images/dummy4.jpg'},
    {'title': 'Mad Max', 'imageAsset': 'assets/images/dummy5.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
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
                    const Text(
                      'Hi, Movie Lover',
                      style: TextStyle(
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
                itemCount: _nowPlaying.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final movie = _nowPlaying[index];
                  return _NowPlayingCard(
                    title: movie['title']!,
                    genre: movie['genre']!,
                    duration: movie['duration']!,
                    rating: movie['rating']!,
                    imageAsset: movie['imageAsset']!,
                  );
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
                itemCount: _comingSoon.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final movie = _comingSoon[index];
                  return _ComingSoonCard(
                    title: movie['title']!,
                    imageAsset: movie['imageAsset']!,
                  );
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
  final String title;
  final String genre;
  final String duration;
  final String rating;
  final String imageAsset;

  const _NowPlayingCard({
    required this.title,
    required this.genre,
    required this.duration,
    required this.rating,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            imageAsset,
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
                      rating,
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
                  title,
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
                  '$genre • $duration',
                  style: TextStyle(color: Colors.grey[300], fontSize: 11),
                ),
              ],
            ),
          ),
        ],
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
  final String title;
  final String imageAsset;

  const _ComingSoonCard({required this.title, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 110,
        height: 130,
        color: const Color(0xFF1C1C28),
        child: Image.asset(
          imageAsset,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.movie_creation_outlined,
            color: Colors.white24,
            size: 32,
          ),
        ),
      ),
    );
  }
}
