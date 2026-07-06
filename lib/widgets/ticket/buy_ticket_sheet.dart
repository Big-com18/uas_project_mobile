import 'package:flutter/material.dart';
import '../../main.dart';
import '../../models/movie.dart';
import '../../models/cinema.dart';
import '../../models/ticket.dart';

const int kTicketPrice = 45000;

Future<void> showBuyTicketSheet({
  required BuildContext context,
  required Movie movie,
  required Cinema cinema,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BuyTicketSheet(movie: movie, cinema: cinema),
  );
}

class BuyTicketSheet extends StatefulWidget {
  final Movie movie;
  final Cinema cinema;
  const BuyTicketSheet({super.key, required this.movie, required this.cinema});

  @override
  State<BuyTicketSheet> createState() => _BuyTicketSheetState();
}

class _BuyTicketSheetState extends State<BuyTicketSheet> {
  final List<String> _dates = ['Hari ini', 'Besok', 'Lusa'];
  final List<String> _times = ['13:00', '15:30', '18:00', '20:30'];
  int _dateIndex = 0;
  int _timeIndex = 0;
  int _seatCount = 1;
  bool _processing = false;

  @override
  Widget build(BuildContext context) {
    final total = kTicketPrice * _seatCount;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.movie.posterUrl,
                    width: 54,
                    height: 74,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                      width: 54,
                      height: 74,
                      color: AppColors.card,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.movie.title,
                          style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(widget.cinema.name,
                          style: const TextStyle(
                              color: AppColors.textSecondary, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Pilih Tanggal',
                style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              children: List.generate(_dates.length, (i) {
                final selected = _dateIndex == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _dateIndex = i),
                    child: Container(
                      margin: EdgeInsets.only(
                          right: i != _dates.length - 1 ? 8 : 0),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _dates[i],
                        style: TextStyle(
                          color: selected
                              ? Colors.white
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            const Text('Pilih Jam Tayang',
                style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(_times.length, (i) {
                final selected = _timeIndex == i;
                return GestureDetector(
                  onTap: () => setState(() => _timeIndex = i),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primary : AppColors.card,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _times[i],
                      style: TextStyle(
                        color: selected ? Colors.white : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Jumlah Kursi',
                    style: TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600)),
                Row(
                  children: [
                    _stepperButton(Icons.remove, () {
                      if (_seatCount > 1) setState(() => _seatCount--);
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('$_seatCount',
                          style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    _stepperButton(Icons.add, () {
                      if (_seatCount < 8) setState(() => _seatCount++);
                    }),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Harga',
                      style: TextStyle(color: AppColors.textSecondary)),
                  Text(
                    'Rp ${_formatRupiah(total)}',
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _processing
                    ? null
                    : () {
                        setState(() => _processing = true);
                        Future.delayed(const Duration(milliseconds: 700), () {
                          if (!mounted) return;
                          TicketStore.addTicket(
                            Ticket(
                              movieTitle: widget.movie.title,
                              cinemaName: widget.cinema.name,
                              posterUrl: widget.movie.posterUrl,
                              date: _dates[_dateIndex],
                              time: _times[_timeIndex],
                              seatCount: _seatCount,
                              totalPrice: total,
                              purchaseDate: DateTime.now(),
                            ),
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Tiket berhasil dibeli! Cek di halaman Riwayat.'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        });
                      },
                child: _processing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Beli Tiket Sekarang'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepperButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: AppColors.textPrimary),
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
