import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ============================================================
/// REGISTER SCREEN
/// Sesuai desain Figma: PROJECT_BILLY-GANTENG (Register-Flow)
/// - RegisterScreen-1 : Default
/// - RegisterScreen-2 : Active / Filling
/// - RegisterScreen-3 : Validation / Error
/// - RegisterScreen-4 : Success State
///
/// Perubahan penting dari versi sebelumnya:
/// 1. Validasi sekarang PER-FIELD. Error hanya muncul untuk field yang
///    sedang/sudah disentuh (fokus lalu keluar / blur), bukan langsung
///    menampilkan semua error saat baru mengetik di 1 field.
/// 2. Tombol "Sign Up" abu-abu selama form belum valid semua, dan
///    berubah oranye otomatis begitu semua field terisi & valid.
/// ============================================================

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ---------------------------------------------------------
  // Controllers & FocusNodes
  // ---------------------------------------------------------
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _fullNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  // Pesan error per field. Null = tidak ada error yang ditampilkan.
  final Map<String, String?> _errors = {
    'fullName': null,
    'email': null,
    'phone': null,
    'password': null,
    'confirmPassword': null,
  };

  // Menandai field mana saja yang sudah pernah disentuh user (fokus lalu blur).
  final Map<String, bool> _touched = {
    'fullName': false,
    'email': false,
    'phone': false,
    'password': false,
    'confirmPassword': false,
  };

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  // Warna sesuai tema gelap pada desain
  static const Color _bgColor = Color(0xFF15161B);
  static const Color _cardColor = Color(0xFF1E1F26);
  static const Color _fieldColor = Color(0xFF2A2B33);
  static const Color _accentOrange = Color(0xFFFF6A2B);
  static const Color _disabledGray = Color(0xFF3A3B44);
  static const Color _errorRed = Color(0xFFFF5A5F);
  static const Color _successGreen = Color(0xFF34C759);
  static const Color _hintGray = Color(0xFF8B8D98);

  @override
  void initState() {
    super.initState();

    // --- Focus listeners: validasi baru dijalankan saat field kehilangan fokus ---
    _fullNameFocus.addListener(() => _handleFocusChange(
        'fullName', _fullNameFocus, _fullNameController, _validateFullName));
    _emailFocus.addListener(() =>
        _handleFocusChange('email', _emailFocus, _emailController, _validateEmail));
    _phoneFocus.addListener(() =>
        _handleFocusChange('phone', _phoneFocus, _phoneController, _validatePhone));
    _passwordFocus.addListener(() => _handleFocusChange(
        'password', _passwordFocus, _passwordController, _validatePassword));
    _confirmPasswordFocus.addListener(() => _handleFocusChange(
        'confirmPassword',
        _confirmPasswordFocus,
        _confirmPasswordController,
        _validateConfirmPassword));

    // --- Text listeners: dipakai untuk (a) update tombol Sign Up live,
    // dan (b) revalidasi error HANYA jika field itu sudah "touched" ---
    _fullNameController.addListener(
        () => _handleTextChange('fullName', _fullNameController, _validateFullName));
    _emailController.addListener(
        () => _handleTextChange('email', _emailController, _validateEmail));
    _phoneController.addListener(
        () => _handleTextChange('phone', _phoneController, _validatePhone));
    _passwordController.addListener(() {
      _handleTextChange('password', _passwordController, _validatePassword);
      // Kalau confirm password sudah pernah disentuh, cek ulang kecocokannya
      // setiap kali password berubah (misal user ganti password lagi).
      if (_touched['confirmPassword'] == true) {
        setState(() {
          _errors['confirmPassword'] =
              _validateConfirmPassword(_confirmPasswordController.text);
        });
      }
    });
    _confirmPasswordController.addListener(() => _handleTextChange(
        'confirmPassword', _confirmPasswordController, _validateConfirmPassword));
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _fullNameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------
  // FOCUS & TEXT CHANGE HANDLERS
  // ---------------------------------------------------------

  void _handleFocusChange(
    String key,
    FocusNode node,
    TextEditingController controller,
    String? Function(String) validator,
  ) {
    if (!node.hasFocus) {
      setState(() {
        _touched[key] = true;
        _errors[key] = validator(controller.text);
      });
    }
  }

  // Dipanggil setiap kali teks sebuah field berubah.
  // - Kalau field itu sudah pernah "touched", error-nya diperbarui live
  //   (misalnya supaya pesan error langsung hilang saat sudah benar).
  // - Field lain yang belum disentuh TIDAK ikut divalidasi.
  // - setState tetap dipanggil supaya tombol Sign Up ikut update warnanya.
  void _handleTextChange(
    String key,
    TextEditingController controller,
    String? Function(String) validator,
  ) {
    setState(() {
      if (_touched[key] == true) {
        _errors[key] = validator(controller.text);
      }
    });
  }

  // ---------------------------------------------------------
  // VALIDATORS (pure function, tidak menyentuh state)
  // ---------------------------------------------------------

  String? _validateFullName(String value) {
    if (value.trim().isEmpty) {
      return 'Nama lengkap wajib diisi';
    }
    if (value.trim().length < 3) {
      return 'Nama lengkap minimal 3 karakter';
    }
    return null;
  }

  String? _validateEmail(String value) {
    if (value.trim().isEmpty) {
      return 'Email wajib diisi';
    }
    final email = value.trim().toLowerCase();

    if (!email.endsWith('@gmail.com')) {
      return 'Email harus menggunakan domain @gmail.com';
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
    if (!emailRegex.hasMatch(email)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? _validatePhone(String value) {
    if (value.trim().isEmpty) {
      return 'Nomor telepon wajib diisi';
    }
    final phoneRegex = RegExp(r'^[0-9+\-\s]{9,15}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Nomor telepon tidak valid';
    }
    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length < 11) {
      return 'Nomor telepon minimal 11 digit';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password wajib diisi';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  String? _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Konfirmasi password wajib diisi';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Mengecek validitas SELURUH form secara diam-diam (tanpa menampilkan
  // error apapun). Dipakai untuk menentukan warna & aktif/nonaktifnya
  // tombol Sign Up.
  bool get _isFormValid {
    return _validateFullName(_fullNameController.text) == null &&
        _validateEmail(_emailController.text) == null &&
        _validatePhone(_phoneController.text) == null &&
        _validatePassword(_passwordController.text) == null &&
        _validateConfirmPassword(_confirmPasswordController.text) == null;
  }

  // ---------------------------------------------------------
  // SUBMIT
  // ---------------------------------------------------------
  Future<void> _handleSignUp() async {
    // Safety check: tandai semua field sebagai touched supaya kalau ada
    // yang ternyata belum valid, errornya langsung kelihatan semua
    // (RegisterScreen-3: Validation/Error). Normalnya kondisi ini tidak
    // tercapai karena tombol sudah disabled selama form belum valid.
    setState(() {
      _touched.updateAll((key, value) => true);
      _errors['fullName'] = _validateFullName(_fullNameController.text);
      _errors['email'] = _validateEmail(_emailController.text);
      _errors['phone'] = _validatePhone(_phoneController.text);
      _errors['password'] = _validatePassword(_passwordController.text);
      _errors['confirmPassword'] =
          _validateConfirmPassword(_confirmPasswordController.text);
    });

    if (!_isFormValid) return;

    setState(() => _isLoading = true);

    // Simulasi proses register (ganti dengan pemanggilan API asli)
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (!mounted) return;

    // Tampilkan RegisterScreen-4: Success State
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: _cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: _successGreen.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: _successGreen,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Registration Successful!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your account has been created. You can now log in to your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _hintGray,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accentOrange,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // tutup dialog
                      Navigator.of(context).pushReplacementNamed('/login');
                      // Ganti '/login' dengan route halaman Login kamu
                    },
                    child: const Text(
                      'Go to Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------
  // BUILD
  // ---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final bool formValid = _isFormValid;

    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Create New Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Full Name
                    _buildTextField(
                      controller: _fullNameController,
                      focusNode: _fullNameFocus,
                      hint: 'Full Name',
                      icon: Icons.person_outline,
                      errorText: _errors['fullName'],
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                    ),
                    const SizedBox(height: 14),

                    // Email
                    _buildTextField(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      hint: 'alex@gmail.com',
                      icon: Icons.email_outlined,
                      errorText: _errors['email'],
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Phone Number
                    _buildTextField(
                      controller: _phoneController,
                      focusNode: _phoneFocus,
                      hint: 'Phone Number',
                      icon: Icons.phone_outlined,
                      errorText: _errors['phone'],
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9+\-\s]'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Password
                    _buildTextField(
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      hint: 'Password',
                      icon: Icons.lock_outline,
                      errorText: _errors['password'],
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: _hintGray,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Confirm Password
                    _buildTextField(
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocus,
                      hint: 'Confirm Password',
                      icon: Icons.lock_outline,
                      errorText: _errors['confirmPassword'],
                      obscureText: _obscureConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: _hintGray,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Sign Up Button
                    // - Abu-abu & nonaktif selama form belum valid semua.
                    // - Oranye & aktif otomatis begitu semua field valid.
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              formValid ? _accentOrange : _disabledGray,
                          disabledBackgroundColor: _disabledGray,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed:
                            (formValid && !_isLoading) ? _handleSignUp : null,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                'Sign Up',
                                style: TextStyle(
                                  color:
                                      formValid ? Colors.white : _hintGray,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Already have an account? Log In
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(color: _hintGray, fontSize: 13),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            },
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                color: _accentOrange,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // REUSABLE TEXT FIELD (sesuai style card gelap pada desain)
  // ---------------------------------------------------------
  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    required IconData icon,
    String? errorText,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      // forceErrorText membuat kita yang mengontrol penuh kapan error
      // tampil (per field), bukan Form/autovalidate bawaan Flutter.
      forceErrorText: errorText,
      autovalidateMode: AutovalidateMode.disabled,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      cursorColor: _accentOrange,
      decoration: InputDecoration(
        filled: true,
        fillColor: _fieldColor,
        hintText: hint,
        hintStyle: const TextStyle(color: _hintGray, fontSize: 14),
        prefixIcon: Icon(icon, color: _hintGray, size: 20),
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _accentOrange, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _errorRed, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _errorRed, width: 1.4),
        ),
        errorStyle: const TextStyle(color: _errorRed, fontSize: 12),
      ),
    );
  }
}