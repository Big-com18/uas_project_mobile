import 'package:flutter/material.dart';

import '../../data/dummy_cinemas.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widget/cinema_card.dart';

class CinemaListScreen extends StatelessWidget {
  const CinemaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nearby Cinemas', style: AppTextStyles.h1),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Icon(Icons.location_on, size: 14, color: AppColors.primary),
                    SizedBox(width: 4),
                    Text(
                      'Jakarta, ID',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                itemCount: dummyCinemas.length,
                itemBuilder: (context, index) {
                  final cinema = dummyCinemas[index];
                  return CinemaCard(
                    cinema: cinema,
                    onViewSchedule: () => Navigator.pushNamed(
                      context,
                      '/cinema-detail',
                      arguments: cinema.id,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
