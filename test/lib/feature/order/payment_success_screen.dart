import 'package:flutter/material.dart';
import '../../data/dummy_tickets.dart';
import '../../model/order_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widget/primary_button.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final OrderModel order;
  const PaymentSuccessScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded,
                    color: AppColors.success, size: 44),
              ),
              const SizedBox(height: 24),
              Text('Pembayaran Berhasil!',
                  style: AppTextStyles.h1, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                'Tiket Anda telah diterbitkan.',
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // demo: pakai tiket dummy pertama sebagai contoh e-tiket
                    Navigator.pushNamed(
                      context,
                      '/e-ticket',
                      arguments: dummyTickets.first,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.surfaceBorder),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.confirmation_number_outlined,
                      color: AppColors.textPrimary, size: 18),
                  label: Text('Lihat Tiket',
                      style: AppTextStyles.button
                          .copyWith(color: AppColors.textPrimary)),
                ),
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: 'Kembali ke Beranda',
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
