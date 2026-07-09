import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPrefs {
  AuthSharedPrefs._();

  static const String _keyFirstTime = 'is_first_time';
  static const String _keyLoggedIn = 'is_logged_in';
  static const String _keyUserEmail = 'logged_in_user_email';

  /// Cek apakah pengguna pertama kali membuka aplikasi.
  /// Default: true.
  static Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyFirstTime) ?? true;
  }

  /// Atur flag isFirstTime (set ke false setelah pertama kali onboarding selesai).
  static Future<void> setFirstTime(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFirstTime, value);
  }

  /// Cek status login pengguna.
  /// Default: false.
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLoggedIn) ?? false;
  }

  /// Simpan status login dan email pengguna yang aktif.
  static Future<void> setLoggedIn(bool value, {String? email}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, value);
    if (email != null) {
      await prefs.setString(_keyUserEmail, email);
    } else if (!value) {
      await prefs.remove(_keyUserEmail);
    }
  }

  /// Dapatkan email pengguna yang sedang login.
  static Future<String?> getLoggedInUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail);
  }

  /// Hapus data sesi login saat pengguna logout.
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, false);
    await prefs.remove(_keyUserEmail);
  }
}
