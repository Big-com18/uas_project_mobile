import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/session.dart';
import '../../model/user.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widget/primary_button.dart';

/// Halaman untuk mengubah data profil pengguna (nama dan nomor telepon).
/// Email tidak dapat diubah.
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // Ambil data pengguna saat ini dari sesi
  final UserModel? _user = Session.currentUser;

  /// Cek apakah pengguna sedang mencoba mengubah kata sandi.
  bool get _isAttemptingPasswordChange =>
      _currentPasswordController.text.isNotEmpty ||
      _newPasswordController.text.isNotEmpty ||
      _confirmPasswordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data pengguna yang ada
    _nameController = TextEditingController(text: _user?.name ?? '');
    _phoneController = TextEditingController(text: _user?.phone ?? '');
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Fungsi yang dipanggil saat tombol "Save Changes" ditekan.
  void _handleSaveChanges() {
    // Validasi form terlebih dahulu
    if (_formKey.currentState!.validate()) {
      Session.updateUser(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        // Hanya teruskan kata sandi jika sedang diubah dan valid
        password: _isAttemptingPasswordChange ? _newPasswordController.text : null,
      );

      if (!mounted) return;

      // Tampilkan notifikasi sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile updated successfully!'),
          backgroundColor: AppColors.success, // Asumsi ada warna ini di theme
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(20),
        ),
      );
      // Kembali ke halaman Profile dan kirim `true` untuk menandakan ada perubahan
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Edit Profile', style: AppTextStyles.h2),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            // Email (read-only)
            Text('Email Address', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted)),
            const SizedBox(height: 8),
            _buildReadOnlyField(_user?.email ?? 'No email available'),
            const SizedBox(height: 24),

            // Full Name
            Text('Full Name', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted)),
            const SizedBox(height: 8),
            _buildTextFormField(
              controller: _nameController,
              hint: 'Enter your full name',
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Full name cannot be empty.';
                }
                if (value.trim().length < 3) {
                  return 'Full name must be at least 3 characters.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Phone Number
            Text('Phone Number', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted)),
            const SizedBox(height: 8),
            _buildTextFormField(
              controller: _phoneController,
              hint: 'Enter your phone number',
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Phone number cannot be empty.';
                }
                if (value.trim().length < 10) {
                  return 'Phone number seems too short.';
                }
                return null;
              },
            ),
            const SizedBox(height: 28),

            // --- Bagian Ganti Password ---
            Text('Change Password', style: AppTextStyles.h3),
            const SizedBox(height: 4),
            Text(
              'Leave all fields blank to keep your current password.',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: 16),

            // Current Password
            _buildTextFormField(
              controller: _currentPasswordController,
              hint: 'Current Password',
              obscureText: _obscureCurrentPassword,
              validator: (value) {
                if (!_isAttemptingPasswordChange) return null;
                if (value == null || value.isEmpty) {
                  return 'Current password is required to change it.';
                }
                if (value != _user?.password) {
                  return 'Incorrect current password.';
                }
                return null;
              },
              suffixIcon: _buildVisibilityToggle(
                () => setState(() => _obscureCurrentPassword = !_obscureCurrentPassword),
                _obscureCurrentPassword,
              ),
            ),
            const SizedBox(height: 16),

            // New Password
            _buildTextFormField(
              controller: _newPasswordController,
              hint: 'New Password',
              obscureText: _obscureNewPassword,
              validator: (value) {
                if (!_isAttemptingPasswordChange) return null;
                if (value == null || value.isEmpty) {
                  return 'New password cannot be empty.';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters.';
                }
                return null;
              },
              suffixIcon: _buildVisibilityToggle(
                () => setState(() => _obscureNewPassword = !_obscureNewPassword),
                _obscureNewPassword,
              ),
            ),
            const SizedBox(height: 16),

            // Confirm New Password
            _buildTextFormField(
              controller: _confirmPasswordController,
              hint: 'Confirm New Password',
              obscureText: _obscureConfirmPassword,
              validator: (value) {
                if (!_isAttemptingPasswordChange) return null;
                if (value != _newPasswordController.text) {
                  return 'The new passwords do not match.';
                }
                return null;
              },
              suffixIcon: _buildVisibilityToggle(
                () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                _obscureConfirmPassword,
              ),
            ),
          ],
        ),
      ),
      // Tombol simpan di bagian bawah layar
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
        child: PrimaryButton(
          label: 'Save Changes',
          onPressed: _handleSaveChanges,
        ),
      ),
    );
  }

  /// Widget untuk field yang tidak bisa di-edit (seperti email)
  Widget _buildReadOnlyField(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMuted),
      ),
    );
  }

  /// Widget untuk ikon show/hide password
  Widget _buildVisibilityToggle(VoidCallback onPressed, bool isObscured) {
    return IconButton(
      icon: Icon(
        isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: AppColors.textMuted,
        size: 20,
      ),
      onPressed: onPressed,
    );
  }

  /// Widget reusable untuk TextFormField dengan style yang seragam
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      style: AppTextStyles.bodyLarge,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.surface,
        hintText: hint,
        hintStyle: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMuted),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.surfaceBorder.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.4),
        ),
        errorStyle: const TextStyle(color: AppColors.danger),
      ),
    );
  }
}