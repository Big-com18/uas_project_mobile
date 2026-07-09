import 'package:flutter/material.dart';
import 'main_nav_screen.dart';
import 'theme/app_theme.dart';

import 'model/order_model.dart';
import 'model/ticket_model.dart';

import 'feature/splashscreen/splash_screen.dart';
import 'feature/onboarding/onboarding_screen.dart';
import 'feature/login/login_screen.dart';
import 'feature/register/register_screen.dart';
import 'feature/movies/movie_detail_screen.dart';
import 'feature/cinema/cinema_detail_screen.dart';
import 'feature/order/order_summary_screen.dart';
import 'feature/order/payment_success_screen.dart';
import 'feature/ticket/my_ticket_screen.dart';
import 'feature/ticket/e_ticket_screen.dart';
import 'feature/welcome/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CineGo',
      theme: AppTheme.darkTheme,

      // ---------- ROUTER ----------
      initialRoute: '/',

      // Route yang GAK butuh data / arguments cukup didaftarin di sini.
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const MainNavScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/my-ticket': (context) => const MyTicketScreen(),
        '/welcome': (context) => const WelcomeScreen(),
      },

      // Route yang BUTUH data (movieId, cinemaId, OrderModel, TicketModel)
      // ditangani manual di sini lewat `settings.arguments`.
      //
      // Cara pakai di layar lain, contoh:
      //   Navigator.pushNamed(context, '/movie-detail', arguments: movie.id);
      //   Navigator.pushNamed(context, '/order-summary', arguments: order);
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/movie-detail':
            final movieId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => MovieDetailScreen(movieId: movieId),
            );

          case '/cinema-detail':
            final cinemaId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => CinemaDetailScreen(cinemaId: cinemaId),
            );

          case '/order-summary':
            final order = settings.arguments as OrderModel;
            return MaterialPageRoute(
              builder: (_) => OrderSummaryScreen(order: order),
            );

          case '/payment-success':
            final order = settings.arguments as OrderModel;
            return MaterialPageRoute(
              builder: (_) => PaymentSuccessScreen(order: order),
            );

          case '/e-ticket':
            final ticket = settings.arguments as TicketModel;
            return MaterialPageRoute(
              builder: (_) => ETicketScreen(ticket: ticket),
            );

          default:
            return null; // route gak ketemu -> Flutter munculin error default
        }
      },
    );
  }
}
