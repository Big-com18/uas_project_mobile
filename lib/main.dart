import 'package:flutter/material.dart';
import 'models/movie.dart';
import 'models/cinema.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/auth_choice_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/movie/movie_list_screen.dart';
import 'screens/movie/movie_detail_screen.dart';
import 'screens/cinema/cinema_list_screen.dart';
import 'screens/cinema/cinema_detail_screen.dart';
import 'screens/ticket/riwayat_screen.dart';

void main() {
  runApp(const MovieApp());
}

// Palet warna utama aplikasi
class AppColors {
  static const bg = Color(0xFF0F0F1B);
  static const surface = Color(0xFF1A1A2E);
  static const card = Color(0xFF232339);
  static const primary = Color(0xFFE63946);
  static const accent = Color(0xFFFFC53D);
  static const textPrimary = Color(0xFFF5F5F7);
  static const textSecondary = Color(0xFFA0A0B2);
}

/// Kumpulan nama route aplikasi + logic untuk membangun halaman (onGenerateRoute).
/// Semua perpindahan antar halaman lewat Navigator.pushNamed(context, ...),
/// dan data dioper lewat parameter `arguments`.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String authChoice = '/auth-choice';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String movieList = '/movie-list';
  static const String movieDetail = '/movie-detail';
  static const String cinemaList = '/cinema-list';
  static const String cinemaDetail = '/cinema-detail';
  static const String riwayat = '/riwayat';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _page(const SplashScreen());

      case onboarding:
        return _page(const OnboardingScreen());

      case authChoice:
        return _page(const AuthChoiceScreen());

      case login:
        return _page(const LoginScreen());

      case register:
        return _page(const RegisterScreen());

      case home:
        final username = settings.arguments as String? ?? '';
        return _page(HomeScreen(username: username));

      case movieList:
        return _page(const MovieListScreen());

      case movieDetail:
        final movie = settings.arguments as Movie;
        return _page(MovieDetailScreen(movie: movie));

      case cinemaList:
        return _page(const CinemaListScreen());

      case cinemaDetail:
        final cinema = settings.arguments as Cinema;
        return _page(CinemaDetailScreen(cinema: cinema));

      case riwayat:
        return _page(const RiwayatScreen());

      default:
        return _page(
          Scaffold(
            body: Center(child: Text('Halaman "${settings.name}" tidak ditemukan')),
          ),
        );
    }
  }

  static MaterialPageRoute _page(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bg,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surface,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.textPrimary),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: AppColors.textPrimary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.card,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: AppColors.textSecondary),
        ),
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
