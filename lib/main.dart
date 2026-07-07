import 'package:flutter/material.dart';
import 'main_nav_screen.dart';

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
      initialRoute: '/home',
      routes: {
        '/home': (context) => const MainNavScreen(),
      },
    );
  }
}