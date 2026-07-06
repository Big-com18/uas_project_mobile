import 'package:flutter/material.dart';
import '../../main.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  const ProfileScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Profil',
              style: TextStyle(
                  color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: AppColors.card,
                  child: Text(
                    username.isNotEmpty ? username[0].toUpperCase() : 'M',
                    style: const TextStyle(
                        color: AppColors.primary, fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  username.isEmpty ? 'Movie Lover' : username,
                  style: const TextStyle(
                      color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$username@email.com',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          _menuTile(
            context,
            icon: Icons.confirmation_number_outlined,
            title: 'Riwayat Pembelian Tiket',
            onTap: () => Navigator.pushNamed(context, AppRoutes.riwayat),
          ),
          _menuTile(context, icon: Icons.favorite_border_rounded, title: 'Film Favorit', onTap: () {}),
          _menuTile(context, icon: Icons.notifications_none_rounded, title: 'Notifikasi', onTap: () {}),
          _menuTile(context, icon: Icons.settings_outlined, title: 'Pengaturan', onTap: () {}),
          _menuTile(context, icon: Icons.help_outline_rounded, title: 'Bantuan', onTap: () {}),
          const SizedBox(height: 12),
          _menuTile(
            context,
            icon: Icons.logout_rounded,
            title: 'Keluar',
            danger: true,
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool danger = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(icon, color: danger ? AppColors.primary : AppColors.textSecondary),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: danger ? AppColors.primary : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (!danger)
                  const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
