import 'package:flutter/material.dart';
import '../../model/order_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widget/primary_button.dart';
import 'payment_method_screen.dart';

class OrderSummaryScreen extends StatefulWidget {
  final OrderModel order;
  const OrderSummaryScreen({super.key, required this.order});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  late OrderModel _order;

  @override
  void initState() {
    super.initState();
    _order = widget.order;
  }

  void _updateCount(int delta) {
    final newCount = _order.ticketCount + delta;
    if (newCount < 1 || newCount > 10) return;
    setState(() => _order = _order.copyWith(ticketCount: newCount));
  }

  String _formatRupiah(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromRight = s.length - i;
      buffer.write(s[i]);
      if (posFromRight > 1 && posFromRight % 3 == 1) buffer.write('.');
    }
    return 'Rp $buffer';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 20,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ringkasan Pesanan', style: AppTextStyles.h1),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        _order.posterUrl,
                        width: 64,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 64,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                                colors: AppColors.primaryGradient),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _order.movieTitle.toUpperCase(),
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(_order.cinemaName, style: AppTextStyles.bodyMedium),
                          const SizedBox(height: 2),
                          Text(
                            '${_formatDate(_order.date)} • ${_order.time} WIB',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Jumlah Tiket', style: AppTextStyles.bodyLarge),
                  Row(
                    children: [
                      _StepperButton(
                        icon: Icons.remove,
                        onTap: () => _updateCount(-1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '${_order.ticketCount}',
                          style: AppTextStyles.h3,
                        ),
                      ),
                      _StepperButton(
                        icon: Icons.add,
                        isPrimary: true,
                        onTap: () => _updateCount(1),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Harga', style: AppTextStyles.bodyLarge),
                  Text(
                    _formatRupiah(_order.totalPrice),
                    style: AppTextStyles.h2,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'Pilih Pembayaran',
                onPressed: () => showPaymentMethodSheet(context, _order),
              ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];
    final dayName = days[date.weekday - 1];
    return '$dayName, ${date.day} ${months[date.month - 1]}';
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _StepperButton({
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : AppColors.surface,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }
}
