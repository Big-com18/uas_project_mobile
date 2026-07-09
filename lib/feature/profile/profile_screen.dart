import 'package:flutter/material.dart';
import '../../data/session.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import 'edit_profile_screen.dart';
import '../../data/auth_shared_prefs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Fungsi untuk memunculkan pop-up konfirmasi
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.surface, // Menggunakan warna background card dari theme Anda
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            'Konfirmasi Keluar',
            style: AppTextStyles.h2,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apakah Anda yakin ingin keluar dari akun ini?',
                style: AppTextStyles.bodyLarge, // Menyesuaikan dengan typography theme
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  // Tombol Batal
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        side: BorderSide(color: AppColors.textPrimary.withOpacity(0.2)),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Batal',
                          style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Tombol Keluar
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.danger,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        Session.logout();
                        await AuthSharedPrefs.clearSession();
                        navigator.pushNamedAndRemoveUntil(
                            '/welcome', (route) => false);
                      },
                      child: Text('Keluar',
                          style: AppTextStyles.bodyLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ],
                ),
        );
      },
    );
  }

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
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                );
                // Jika halaman edit mengembalikan `true`, refresh UI
                if (result == true) setState(() {});
              },
            ),
            _ProfileMenuTile(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            
            // Modifikasi pada tombol Logout untuk memanggil _showLogoutConfirmation
            _ProfileMenuTile(
              icon: Icons.logout_rounded,
              label: 'Logout',
              isDanger: true,
              onTap: () => _showLogoutConfirmation(context), // Memanggil fungsi pop-up di sini
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