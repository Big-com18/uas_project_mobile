import 'package:flutter/material.dart';
import 'main_nav_screen.dart';
import 'feature/onboarding/onboarding_screen.dart';
import 'feature/login/login_screen.dart';

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
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0D0D14),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
      ),
      // ---------- ROUTER ----------
      initialRoute: '/login',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const MainNavScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}