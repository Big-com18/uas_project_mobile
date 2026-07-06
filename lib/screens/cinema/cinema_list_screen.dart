import 'package:flutter/material.dart';
import '../../main.dart';
import '../../data/dummy_data.dart';
import '../../widgets/cinema/cinema_card.dart';

class CinemaListScreen extends StatefulWidget {
  final bool embedded;
  const CinemaListScreen({super.key, this.embedded = false});

  @override
  State<CinemaListScreen> createState() => _CinemaListScreenState();
}

class _CinemaListScreenState extends State<CinemaListScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final cinemas = DummyData.cinemas
        .where((c) =>
            c.name.toLowerCase().contains(_query.toLowerCase()) ||
            c.city.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Daftar Bioskop',
              style: TextStyle(
                  color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            style: const TextStyle(color: AppColors.textPrimary),
            onChanged: (v) => setState(() => _query = v),
            decoration: const InputDecoration(
              hintText: 'Cari nama atau kota bioskop...',
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: ListView.builder(
              itemCount: cinemas.length,
              itemBuilder: (context, i) => CinemaCard(cinema: cinemas[i]),
            ),
          ),
        ],
      ),
    );

    if (widget.embedded) {
      return SafeArea(child: content);
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Bioskop')),
      body: content,
    );
  }
}
