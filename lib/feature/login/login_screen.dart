import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../service/auth_service.dart';
import '../../main_nav_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  String? _emailError;
  String? _passwordError;
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const Color _background = Color(0xFF0B0B0F);
  static const Color _fieldBorder = Color(0xFF2A2A30);
  static const Color _hintColor = Color(0xFF6B6B72);
  static const Color _accentOrange = Color(0xFFFF6900);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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

                // Welcome text
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

                // Email field
                _buildTextField(
                  controller: _emailController,
                  hint: 'Email Address',
                  icon: Icons.mail_outline,
                  hasError: _emailError != null,
                ),

                if (_emailError != null) ...[
                  const SizedBox(height: 8),
                  _buildErrorMessage(_emailError!),
                ],

                const SizedBox(height: 16),

                // Password field
                _buildTextField(
                  controller: _passwordController,
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  hasError: _passwordError != null,
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

                if (_passwordError != null) ...[
                  const SizedBox(height: 8),
                  _buildErrorMessage(_passwordError!),
                ],

                const SizedBox(height: 28),

                // Login button
                SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text;

                      setState(() {
                        _emailError = null;
                        _passwordError = null;
                      });

                      if (email.isEmpty) {
                        setState(() {
                          _emailError = 'Please enter your email address.';
                        });
                        return;
                      }

                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(email)) {
                        setState(() {
                          _emailError = 'Please enter a valid email address.';
                        });
                        return;
                      }

                      if (password.isEmpty) {
                        setState(() {
                          _passwordError = 'Please enter your password.';
                        });
                        return;
                      }

                      final user = _authService.login(email, password);

                      if (user != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Selamat datang, ${user.name}!')),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const MainNavScreen()),
                        );
                      } else {
                        setState(() {
                          _passwordError = 'Incorrect password. Please try again.';
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6900),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Forgot password
                TextButton(
                  onPressed: () {
                    // TODO: handle forgot password
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: _hintColor,
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 56),

                // OR divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: _fieldBorder, thickness: 1),
                    ),
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
                    Expanded(
                      child: Divider(color: _fieldBorder, thickness: 1),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Google / Apple buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildSocialButton(
                        label: 'Google',
                        onPressed: () {
                          // TODO: handle Google sign in
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildSocialButton(
                        label: 'Apple',
                        onPressed: () {
                          // TODO: handle Apple sign in
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Row(
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.redAccent,
          size: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    bool hasError = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasError ? Colors.redAccent.withOpacity(0.8) : _fieldBorder,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: _hintColor, fontSize: 15),
          prefixIcon: Icon(
            icon,
            color: hasError ? Colors.redAccent : _hintColor,
            size: 20,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 18, horizontal: 4),
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
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}