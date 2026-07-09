import '../model/user.dart';

/// Penyimpanan sederhana buat data user yang lagi login.
///
/// Ini BUKAN state management beneran (Provider/Riverpod/Bloc/dst),
/// cuma global holder paling simpel: di-set sekali pas login berhasil,
/// terus dibaca di screen manapun (HomeScreen, ProfileScreen, dst)
/// tanpa perlu oper UserModel manual lewat Navigator.push di semua tempat.
///
/// Catatan: karena ini cuma variable static biasa, datanya bakal ke-reset
/// kalau app di-kill/restart (gak persist). Kalau nanti mau "tetep login"
/// walau app ditutup, baru butuh shared_preferences atau auth beneran
/// dari backend temen kamu.
class Session {
  Session._();

  static UserModel? currentUser;

  static void login(UserModel user) => currentUser = user;

  static void logout() => currentUser = null;

  static bool get isLoggedIn => currentUser != null;
}
