import 'package:flutter/material.dart';
import '../../data/session.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Session.currentUser;
    final displayName = (user == null || user.name.trim().isEmpty)
        ? 'Guest'
        : user.name;
    final displayEmail = user?.email ?? '-';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 88,
              height: 88,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: AppColors.primaryGradient),
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 14),
            Text(displayName, style: AppTextStyles.h2),
            const SizedBox(height: 4),
            Text(displayEmail, style: AppTextStyles.caption),
            const SizedBox(height: 28),

            _ProfileMenuTile(
              icon: Icons.confirmation_number_outlined,
              label: 'Ticket History',
              onTap: () => Navigator.pushNamed(context, '/my-ticket'),
            ),
            _ProfileMenuTile(
              icon: Icons.edit_outlined,
              label: 'Edit Profile',
              onTap: () {},
            ),
            _ProfileMenuTile(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _ProfileMenuTile(
              icon: Icons.logout_rounded,
              label: 'Logout',
              isDanger: true,
              onTap: () {
                Session.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDanger;

  const _ProfileMenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDanger ? AppColors.danger : AppColors.textPrimary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isDanger
                      ? AppColors.danger.withOpacity(0.12)
                      : AppColors.surfaceLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 17, color: color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(label,
                    style: AppTextStyles.bodyLarge.copyWith(color: color)),
              ),
              if (!isDanger)
                const Icon(Icons.chevron_right,
                    color: AppColors.textMuted, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}