import 'package:flutter/material.dart';
import '../../data/dummy_movies.dart';
import '../../data/dummy_schedules.dart';
import '../../data/dummy_cinemas.dart';
import '../../model/order_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widget/primary_button.dart';

class MovieDetailScreen extends StatefulWidget {
  final String movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  String? _selectedCinemaId;
  String? _selectedTime;
  String? _selectedFormat;

  @override
  Widget build(BuildContext context) {
    final movie = findMovieById(widget.movieId);
    final schedules = schedulesForMovie(movie.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero: kolase poster + tombol back
                    Stack(
                      children: [
                        ClipRRect(
                          child: Image.asset(
                            movie.posterUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: AppColors.primaryGradient,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 16,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movie.title, style: AppTextStyles.h1),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded,
                                  color: AppColors.star, size: 16),
                              const SizedBox(width: 4),
                              Text('${movie.rating}/5',
                                  style: AppTextStyles.bodyMedium),
                              const SizedBox(width: 10),
                              const Text('·', style: TextStyle(color: AppColors.textSecondary)),
                              const SizedBox(width: 10),
                              const Icon(Icons.access_time,
                                  color: AppColors.textSecondary, size: 15),
                              const SizedBox(width: 4),
                              Text(movie.durationLabel,
                                  style: AppTextStyles.bodyMedium),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            children: movie.genres
                                .map((g) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: AppColors.chipBackground,
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: Text(g,
                                          style: AppTextStyles.bodySmall),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 20),
                          Text('Synopsis', style: AppTextStyles.h3),
                          const SizedBox(height: 8),
                          Text(
                            movie.synopsis,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text('Available Cinemas', style: AppTextStyles.h3),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),

                    // Daftar bioskop + jam tayang
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: schedules.map((schedule) {
                          final cinema = findCinemaById(schedule.cinemaId);
                          final isActiveCinema =
                              _selectedCinemaId == cinema.id;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isActiveCinema
                                    ? AppColors.primary
                                    : Colors.transparent,
                                width: 1.4,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(cinema.name, style: AppTextStyles.h3),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            size: 13,
                                            color: AppColors.textSecondary),
                                        const SizedBox(width: 2),
                                        Text(cinema.distanceLabel,
                                            style: AppTextStyles.caption),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: schedule.times.map((time) {
                                    final isSelected =
                                        isActiveCinema && _selectedTime == time;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedCinemaId = cinema.id;
                                          _selectedTime = time;
                                          _selectedFormat = schedule.format;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColors.primary
                                              : AppColors.chipBackground,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          time,
                                          style: AppTextStyles.bodyMedium
                                              .copyWith(
                                            color: isSelected
                                                ? Colors.white
                                                : AppColors.textPrimary,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _selectedTime == null
          ? null
          : Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: const BoxDecoration(
                color: AppColors.background,
                border: Border(
                  top: BorderSide(color: AppColors.surfaceBorder, width: 0.5),
                ),
              ),
              child: PrimaryButton(
                label: 'Book Tickets',
                onPressed: () {
                  final cinema = findCinemaById(_selectedCinemaId!);
                  final order = OrderModel(
                    movieTitle: movie.title,
                    posterUrl: movie.posterUrl,
                    cinemaName: cinema.name,
                    format: _selectedFormat ?? 'Regular',
                    date: DateTime.now(),
                    time: _selectedTime!,
                    ticketCount: 1,
                    pricePerTicket: 50000,
                  );
                  Navigator.pushNamed(
                    context,
                    '/order-summary',
                    arguments: order,
                  );
                },
              ),
            ),
    );
  }
}
