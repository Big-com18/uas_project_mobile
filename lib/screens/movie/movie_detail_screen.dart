import 'package:flutter/material.dart';
import '../../main.dart';
import '../../models/movie.dart';
import '../../data/dummy_data.dart';
import '../../widgets/cinema/cinema_card.dart';
import '../../widgets/ticket/buy_ticket_sheet.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final cinemas = DummyData.getCinemasForMovie(movie);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 380,
            pinned: true,
            backgroundColor: AppColors.bg,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movie.posterUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(color: AppColors.card),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.bg.withOpacity(0.5),
                            AppColors.bg,
                          ],
                          stops: const [0.3, 0.75, 1.0],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                        color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      _chip(Icons.star_rounded, movie.rating.toString(), AppColors.accent),
                      _chip(Icons.access_time_rounded, movie.duration, AppColors.textSecondary),
                      _chip(Icons.category_outlined, movie.genre, AppColors.textSecondary),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Sinopsis',
                      style: TextStyle(
                          color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    movie.synopsis,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.6),
                  ),
                  const SizedBox(height: 24),
                  const Text('Tersedia di Bioskop',
                      style: TextStyle(
                          color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...cinemas.map((c) => CinemaCard(cinema: c)),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton.icon(
            onPressed: () {
              final cinema = cinemas.isNotEmpty ? cinemas.first : DummyData.cinemas.first;
              showBuyTicketSheet(context: context, movie: movie, cinema: cinema);
            },
            icon: const Icon(Icons.confirmation_number_rounded),
            label: const Text('Beli Tiket'),
          ),
        ),
      ),
    );
  }

  Widget _chip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
