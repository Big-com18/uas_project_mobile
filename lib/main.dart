import 'package:flutter/material.dart';
import 'pages/list_mahasiswa_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Directory',
      theme: ThemeData(
        // Font yang bersih mendukung desain neo-brutalism/minimalist
        fontFamily: 'Inter', 
      ),
      home: const ListMahasiswaPages(), // Mengarah ke class yang baru dibuat
    );
  }
}