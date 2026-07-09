import 'package:flutter/material.dart';
import '../model/cinema_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CinemaCard extends StatelessWidget {
  final CinemaModel cinema;
  final VoidCallback onViewSchedule;

  const CinemaCard({
    super.key,
    required this.cinema,
    required this.onViewSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(cinema.name, style: AppTextStyles.h3),
              ),
              Text(cinema.distanceLabel, style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            cinema.facilities.join(', '),
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: OutlinedButton(
              onPressed: onViewSchedule,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.surfaceBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('View Schedule',
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.textPrimary)),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_right,
                      size: 16, color: AppColors.textPrimary),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
