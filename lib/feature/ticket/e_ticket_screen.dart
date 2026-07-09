import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../model/ticket_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class ETicketScreen extends StatelessWidget {
  final TicketModel ticket;
  const ETicketScreen({super.key, required this.ticket});

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              child: Column(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              ticket.posterUrl,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                height: 160,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: AppColors.primaryGradient,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              top: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(ticket.format,
                                    style: AppTextStyles.captionSmall
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              bottom: 12,
                              right: 16,
                              child: Text(
                                ticket.movieTitle.toUpperCase(),
                                style: AppTextStyles.h2.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              _InfoRow(
                                icon: Icons.location_on_outlined,
                                title: ticket.cinemaName,
                                subtitle: '${ticket.studio}, Kursi ${ticket.seat}',
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Expanded(
                                    child: _InfoRow(
                                      icon: Icons.calendar_today_outlined,
                                      title: 'Tanggal',
                                      subtitle: _formatDate(ticket.date),
                                    ),
                                  ),
                                  Expanded(
                                    child: _InfoRow(
                                      icon: Icons.access_time,
                                      title: 'Waktu',
                                      subtitle: '${ticket.time} WIB',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: QrImageView(
                                  data: ticket.id,
                                  version: QrVersions.auto,
                                  size: 160,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(ticket.id, style: AppTextStyles.bodyMedium),
                              const SizedBox(height: 4),
                              Text(
                                'Pindai kode ini di pintu masuk',
                                style: AppTextStyles.caption
                                    .copyWith(color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.bodyMedium),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTextStyles.caption),
            ],
          ),
        ),
      ],
    );
  }
}
