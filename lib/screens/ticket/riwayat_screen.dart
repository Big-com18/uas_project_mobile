import 'package:flutter/material.dart';
import '../../main.dart';
import '../../models/ticket.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tickets = TicketStore.tickets;
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Pembelian Tiket')),
      body: tickets.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.confirmation_number_outlined,
                      size: 64, color: AppColors.textSecondary),
                  SizedBox(height: 12),
                  Text('Belum ada tiket yang dibeli',
                      style: TextStyle(color: AppColors.textSecondary)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: tickets.length,
              itemBuilder: (context, i) {
                final t = tickets[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          t.posterUrl,
                          width: 56,
                          height: 78,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(
                            width: 56,
                            height: 78,
                            color: AppColors.surface,
                            child: const Icon(Icons.movie_outlined,
                                color: AppColors.textSecondary),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t.movieTitle,
                                style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                            const SizedBox(height: 4),
                            Text(t.cinemaName,
                                style: const TextStyle(
                                    color: AppColors.textSecondary, fontSize: 12)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today_rounded,
                                    size: 12, color: AppColors.textSecondary),
                                const SizedBox(width: 4),
                                Text('${t.date} • ${t.time}',
                                    style: const TextStyle(
                                        color: AppColors.textSecondary, fontSize: 11)),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.event_seat_rounded,
                                    size: 12, color: AppColors.textSecondary),
                                const SizedBox(width: 4),
                                Text('${t.seatCount} kursi',
                                    style: const TextStyle(
                                        color: AppColors.textSecondary, fontSize: 11)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Rp ${_formatRupiah(t.totalPrice)}',
                        style: const TextStyle(
                            color: AppColors.accent,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

String _formatRupiah(int value) {
  final str = value.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < str.length; i++) {
    final posFromRight = str.length - i;
    buffer.write(str[i]);
    if (posFromRight > 1 && posFromRight % 3 == 1) buffer.write('.');
  }
  return buffer.toString();
}
