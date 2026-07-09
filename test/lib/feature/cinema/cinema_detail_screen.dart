import 'package:flutter/material.dart';
import '../../data/dummy_cinemas.dart';
import '../../data/dummy_movies.dart';
import '../../data/dummy_schedules.dart';
import '../../model/order_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widget/primary_button.dart';

class CinemaDetailScreen extends StatefulWidget {
  final String cinemaId;
  const CinemaDetailScreen({super.key, required this.cinemaId});

  @override
  State<CinemaDetailScreen> createState() => _CinemaDetailScreenState();
}

class _CinemaDetailScreenState extends State<CinemaDetailScreen> {
  String? _selectedMovieId;
  String? _selectedTime;
  String? _selectedFormat;

  final Map<IconData, String> _facilityIcons = {
    Icons.crop_free: 'IMAX',
    Icons.headphones: 'DOLBY',
    Icons.local_cafe: 'SNACK BAR',
    Icons.local_parking: 'PARKING',
    Icons.wifi: 'WIFI',
  };

  @override
  Widget build(BuildContext context) {
    final cinema = findCinemaById(widget.cinemaId);
    final schedules = schedulesForCinema(cinema.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    child: Image.network(
                      cinema.heroImageUrl ??
                          'https://picsum.photos/seed/${cinema.id}/800/500',
                      height: 190,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 190,
                        decoration: const BoxDecoration(
                          gradient:
                              LinearGradient(colors: AppColors.primaryGradient),
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
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(cinema.name, style: AppTextStyles.h1),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                color: AppColors.star, size: 16),
                            const SizedBox(width: 3),
                            Text(cinema.rating.toString(),
                                style: AppTextStyles.bodyMedium),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(cinema.address,
                              style: AppTextStyles.caption),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.chipBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('${cinema.distanceLabel} away',
                          style: AppTextStyles.captionSmall
                              .copyWith(color: AppColors.primary)),
                    ),
                    const SizedBox(height: 18),

                    // Facility icons row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _facilityIcons.entries.map((entry) {
                        return Column(
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: const BoxDecoration(
                                color: AppColors.surface,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(entry.key,
                                  size: 18, color: AppColors.textPrimary),
                            ),
                            const SizedBox(height: 6),
                            Text(entry.value, style: AppTextStyles.captionSmall),
                          ],
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Now Playing Here', style: AppTextStyles.h3),
                        Text('See all',
                            style: AppTextStyles.bodyMedium
                                .copyWith(color: AppColors.primary)),
                      ],
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: schedules.map((schedule) {
                    final movie = findMovieById(schedule.movieId);
                    final isActiveMovie = _selectedMovieId == movie.id;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              movie.posterUrl,
                              width: 60,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 60,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: const LinearGradient(
                                      colors: AppColors.primaryGradient),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(movie.title, style: AppTextStyles.h3),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    const Icon(Icons.star_rounded,
                                        color: AppColors.star, size: 13),
                                    const SizedBox(width: 3),
                                    Text(movie.rating.toString(),
                                        style: AppTextStyles.caption),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Wrap(
                                  spacing: 6,
                                  children: movie.genres
                                      .map((g) => Container(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 8, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: AppColors.chipBackground,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(g,
                                                style:
                                                    AppTextStyles.captionSmall),
                                          ))
                                      .toList(),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: schedule.times.map((time) {
                                    final isSelected = isActiveMovie &&
                                        _selectedTime == time;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedMovieId = movie.id;
                                          _selectedTime = time;
                                          _selectedFormat = schedule.format;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 7),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColors.primary
                                              : AppColors.chipBackground,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          time,
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                            color: isSelected
                                                ? Colors.white
                                                : AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
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
                label: 'Continue to Seat Selection',
                onPressed: () {
                  final movie = findMovieById(_selectedMovieId!);
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
