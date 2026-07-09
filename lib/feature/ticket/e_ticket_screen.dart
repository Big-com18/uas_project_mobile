import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../model/ticket_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class ETicketScreen extends StatelessWidget {
  final TicketModel ticket;
  const ETicketScreen({super.key, required this.ticket});

  static const double _posterHeight = 160;
  static const double _perforationHeight = 24;

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
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 58,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
        title: Text('E-Ticket', style: AppTextStyles.h3),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: _buildTicketCard(),
        ),
      ),
    );
  }

  /// The ticket card: poster header, perforated divider, details, and QR.
  /// Wrapped in a Stack so the punch-hole notches can sit on top of
  /// (and slightly outside) the card edges.
  Widget _buildTicketCard() {
    return Stack(
      clipBehavior: Clip.none,
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
                    height: _posterHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      height: _posterHeight,
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
                      child: Text(
                        ticket.format,
                        style: AppTextStyles.captionSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
              // Perforated divider between the poster and the ticket
              // details, mimicking a torn ticket stub.
              SizedBox(
                height: _perforationHeight,
                width: double.infinity,
                child: CustomPaint(
                  painter: _DashedLinePainter(
                    horizontal: true,
                    color: AppColors.textSecondary.withValues(alpha: 0.35),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
        // Left & right punch-hole notches aligned with the perforation line.
        Positioned(
          top: _posterHeight + (_perforationHeight / 2) - 8,
          left: -8,
          child: const _Notch(),
        ),
        Positioned(
          top: _posterHeight + (_perforationHeight / 2) - 8,
          right: -8,
          child: const _Notch(),
        ),
      ],
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

/// Small circle used to create the "punched hole" look of a ticket stub.
/// Uses the page background color so it reads as a cutout against the card.
class _Notch extends StatelessWidget {
  const _Notch();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: const BoxDecoration(
        color: AppColors.background,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Paints a dashed line, either horizontal or vertical, filling the
/// available size given by its parent.
class _DashedLinePainter extends CustomPainter {
  final bool horizontal;
  final Color color;

  static const double _dashWidth = 5;
  static const double _dashSpace = 4;
  static const double _strokeWidth = 1.4;

  const _DashedLinePainter({
    required this.horizontal,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = _strokeWidth;

    double distance = 0;
    if (horizontal) {
      final y = size.height / 2;
      while (distance < size.width) {
        canvas.drawLine(
          Offset(distance, y),
          Offset(distance + _dashWidth, y),
          paint,
        );
        distance += _dashWidth + _dashSpace;
      }
    } else {
      final x = size.width / 2;
      while (distance < size.height) {
        canvas.drawLine(
          Offset(x, distance),
          Offset(x, distance + _dashWidth),
          paint,
        );
        distance += _dashWidth + _dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.horizontal != horizontal;
  }
}