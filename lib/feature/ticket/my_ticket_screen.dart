import 'package:flutter/material.dart';
import '../../data/dummy_tickets.dart';
import '../../model/ticket_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class MyTicketScreen extends StatefulWidget {
  const MyTicketScreen({super.key});

  @override
  State<MyTicketScreen> createState() => _MyTicketScreenState();
}

class _MyTicketScreenState extends State<MyTicketScreen> {
  bool _showActive = true;

  @override
  Widget build(BuildContext context) {
    final tickets = _showActive ? activeTickets : doneTickets;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const BackButton(),
        title: Text('Tiket Saya', style: AppTextStyles.h3),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    _TabButton(
                      label: 'Aktif',
                      isActive: _showActive,
                      onTap: () => setState(() => _showActive = true),
                    ),
                    _TabButton(
                      label: 'Selesai',
                      isActive: !_showActive,
                      onTap: () => setState(() => _showActive = false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: tickets.isEmpty
                  ? Center(
                child: Text('Belum ada tiket',
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textSecondary)),
              )
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                itemCount: tickets.length,
                itemBuilder: (context, index) =>
                    _TicketTile(ticket: tickets[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(26),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isActive ? Colors.white : AppColors.textSecondary,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _TicketTile extends StatelessWidget {
  final TicketModel ticket;
  const _TicketTile({required this.ticket});

  // Width reserved on the right side of the tile for the torn-stub
  // (dashed line + notches) visual.
  static const double _stubWidth = 40;

  String _formatDate(DateTime date) {
    const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];
    return '${days[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final isDone = ticket.status == TicketStatus.done;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/e-ticket',
        arguments: ticket,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              padding:
              const EdgeInsets.fromLTRB(12, 12, 12 + _stubWidth, 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      ticket.posterUrl,
                      width: 56,
                      height: 72,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: 56,
                        height: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                        Text(
                          ticket.movieTitle.toUpperCase(),
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: isDone
                                ? AppColors.textSecondary
                                : AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(ticket.cinemaName, style: AppTextStyles.bodyMedium),
                        const SizedBox(height: 4),
                        Text(
                          '${_formatDate(ticket.date)} • ${ticket.time} WIB',
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Jumlah: ${ticket.ticketCount} Tiket',
                          style: AppTextStyles.captionSmall
                              .copyWith(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Dashed perforation line marking the ticket stub.
            Positioned(
              top: 12,
              bottom: 12,
              right: _stubWidth / 2,
              child: CustomPaint(
                size: const Size(1, double.infinity),
                painter: _DashedLinePainter(
                  horizontal: false,
                  color: AppColors.background,
                ),
              ),
            ),
            // Format chip sits within the stub area, above the notch line.
            Positioned(
              top: 12,
              right: (_stubWidth / 2) - 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.chipBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(ticket.format, style: AppTextStyles.captionSmall),
              ),
            ),
            // Top & bottom punch-hole notches, aligned with the dashed line.
            Positioned(
              top: -8,
              right: (_stubWidth / 2) - 8,
              child: const _Notch(),
            ),
            Positioned(
              bottom: -8,
              right: (_stubWidth / 2) - 8,
              child: const _Notch(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small circle used to create the "punched hole" look of a ticket stub.
/// Uses the page background color so it reads as a cutout against the tile.
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

  static const double _dashHeight = 5;
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
          Offset(distance + _dashHeight, y),
          paint,
        );
        distance += _dashHeight + _dashSpace;
      }
    } else {
      final x = size.width / 2;
      while (distance < size.height) {
        canvas.drawLine(
          Offset(x, distance),
          Offset(x, distance + _dashHeight),
          paint,
        );
        distance += _dashHeight + _dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.horizontal != horizontal;
  }
}