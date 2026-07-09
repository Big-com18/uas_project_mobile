import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uts_project_mobile/data/app_data.dart';
import 'package:uts_project_mobile/data/session.dart';
import 'package:uts_project_mobile/model/user.dart';
import '../../data/auth_shared_prefs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final List<UserModel> _user = userData;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const Color _background = Color(0xFF0B0B0F);
  static const Color _fieldBorder = Color(0xFF2A2A30);
  static const Color _hintColor = Color(0xFF6B6B72);
  static const Color _accentOrange = Color(0xFFD98E4A);
  static const Color _primaryOrange = Color(0xFFFF6A1A);

  @override
  void initState() {
    super.initState();
    // FIX: dengerin perubahan teks biar tombol Login bisa ganti warna
    // real-time pas email & password valid.
    _emailController.addListener(_onCredentialsChanged);
    _passwordController.addListener(_onCredentialsChanged);
  }

  @override
  void dispose() {
    _emailController.removeListener(_onCredentialsChanged);
    _passwordController.removeListener(_onCredentialsChanged);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get _isValidCredential {
    return _user.any(
      (user) =>
          user.email == _emailController.text &&
          user.password == _passwordController.text,
    );
  }

  void _onCredentialsChanged() => setState(() {});

  void _handleLogin() async {
    // Email DAN password harus cocok di user yang SAMA (bukan dicek terpisah).
    final matchedUsers = _user.where(
      (user) =>
          user.email == _emailController.text &&
          user.password == _passwordController.text,
    );

    if (matchedUsers.isNotEmpty) {
      final user = matchedUsers.first;
      Session.login(user);
      
      // Simpan status login & email secara persisten ke SharedPreferences
      await AuthSharedPrefs.setLoggedIn(true, email: user.email);

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // FIX GLITCH: sebelumnya pakai Center + SingleChildScrollView bareng-bareng.
    // Kombinasi itu bikin layout "loncat" tiap keyboard muncul/hilang karena
    // Center terus ngitung ulang posisi tengah sementara tinggi area yang
    // tersedia berubah-ubah tiap keystroke. Sekarang cukup ListView biasa
    // (otomatis scrollable, tanpa recentering yang bikin jitter).
    return Scaffold(
      backgroundColor: _background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              children: [
                const SizedBox(height: 40),
    
                // Logo + brand name
                SvgPicture.asset(
                  'assets/icons/logo.svg',
                  width: 30,
                  height: 30,
                  colorFilter: const ColorFilter.mode(
                    _accentOrange,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'CINEPHILE ZONE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3,
                    ),
                  ),
                ),
    
                const SizedBox(height: 48),
    
                const Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
    
                const SizedBox(height: 36),
    
                _buildTextField(
                  controller: _emailController,
                  hint: 'Email Address',
                  icon: Icons.mail_outline,
                ),
    
                const SizedBox(height: 16),
    
                _buildTextField(
                  controller: _passwordController,
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: _hintColor,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
    
                const SizedBox(height: 28),
    
                // Login button — berubah oranye pas email & password yang lagi
                // diketik cocok sama salah satu user yang valid.
                SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isValidCredential
                          ? _primaryOrange
                          : const Color(0xFF1C1C22),
                      foregroundColor:
                          _isValidCredential ? Colors.white : Colors.white70,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color:
                              _isValidCredential ? _primaryOrange : _fieldBorder,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
    
                const SizedBox(height: 20),
    
                TextButton(
                  onPressed: () {
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: _hintColor, fontSize: 14),
                  ),
                ),
    
                const SizedBox(height: 56),
    
                Row(
                  children: [
                    const Expanded(
                        child: Divider(color: _fieldBorder, thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: _hintColor,
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const Expanded(
                        child: Divider(color: _fieldBorder, thickness: 1)),
                  ],
                ),
    
                const SizedBox(height: 24),
    
                Row(
                  children: [
                    Expanded(
                      child: _buildSocialButton(
                        label: 'Google',
                        onPressed: () {
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildSocialButton(
                        label: 'Apple',
                        onPressed: () {
                        },
                      ),
                    ),
                  ],
                ),
    
                const SizedBox(height: 40),
              ],
            ),
            // ---------- BACK BUTTON ----------
            IconButton(
              padding: const EdgeInsets.all(16.0),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
              tooltip: 'Kembali',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _fieldBorder),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: _hintColor, fontSize: 15),
          prefixIcon: Icon(icon, color: _hintColor, size: 20),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 4,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: _fieldBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}