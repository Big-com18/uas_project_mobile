import 'package:flutter/material.dart';
import '../../model/order_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widget/primary_button.dart';

enum _PaymentOption { qris, eWallet, virtualAccount }

/// Dipanggil dari OrderSummaryScreen buat munculin popup metode pembayaran
/// di atas layar (bottom sheet), PERSIS kayak di desain (MobileFrame-2):
/// rounded top corner, drag handle di atas, nggak full page / nggak ada
/// AppBar penuh.
Future<void> showPaymentMethodSheet(BuildContext context, OrderModel order) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _PaymentMethodSheet(order: order),
  );
}

class _PaymentMethodSheet extends StatefulWidget {
  final OrderModel order;
  const _PaymentMethodSheet({required this.order});

  @override
  State<_PaymentMethodSheet> createState() => _PaymentMethodSheetState();
}

class _PaymentMethodSheetState extends State<_PaymentMethodSheet> {
  _PaymentOption _selected = _PaymentOption.eWallet;

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
    return Padding(
      // biar sheet naik pas keyboard muncul (walau di sini gak ada text field)
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceBorder,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              // Header: back + title
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.chevron_left,
                      color: AppColors.textPrimary,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('Metode Pembayaran', style: AppTextStyles.h3),
                ],
              ),
              const SizedBox(height: 20),

              _PaymentOptionTile(
                icon: Icons.qr_code_rounded,
                label: 'QRIS',
                isSelected: _selected == _PaymentOption.qris,
                onTap: () => setState(() => _selected = _PaymentOption.qris),
              ),
              const SizedBox(height: 12),
              _PaymentOptionTile(
                icon: Icons.account_balance_wallet_rounded,
                label: 'E-Wallet (Gopay, OVO)',
                isSelected: _selected == _PaymentOption.eWallet,
                onTap: () =>
                    setState(() => _selected = _PaymentOption.eWallet),
              ),
              const SizedBox(height: 12),
              _PaymentOptionTile(
                icon: Icons.account_balance_rounded,
                label: 'Virtual Account',
                isSelected: _selected == _PaymentOption.virtualAccount,
                onTap: () =>
                    setState(() => _selected = _PaymentOption.virtualAccount),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Harga', style: AppTextStyles.bodyLarge),
                  Text(
                    _formatRupiah(widget.order.totalPrice),
                    style: AppTextStyles.h2,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'Bayar Sekarang',
                onPressed: () {
                  // Tutup sheet dulu, baru pindah ke halaman sukses (full page,
                  // sesuai desain MobileFrame-3).
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/payment-success',
                    arguments: widget.order,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentOptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentOptionTile({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 1.4,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 17,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodyLarge.copyWith(
                  color:
                      isSelected ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
