import 'package:flutter/material.dart';
import '../model/movie_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Poster card dipakai di Home ("Now Playing") dan Movies list.
/// width diatur oleh parent (biasanya lewat SizedBox / grid).
class MoviePosterCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback? onTap;
  final double posterHeight;

  const MoviePosterCard({
    super.key,
    required this.movie,
    this.onTap,
    this.posterHeight = 170,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  movie.posterUrl,
                  height: posterHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: posterHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: AppColors.primaryGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(Icons.movie_outlined,
                        color: Colors.white70, size: 32),
                  ),
                ),
              ),
              if (movie.rating > 0)
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded,
                            color: AppColors.star, size: 13),
                        const SizedBox(width: 3),
                        Text(
                          movie.rating.toStringAsFixed(1),
                          style: AppTextStyles.bodySmall
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 2),
          Text(
            movie.isComingSoon ? 'Coming Soon' : '${movie.genresLabel} · ${movie.durationLabel}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}
