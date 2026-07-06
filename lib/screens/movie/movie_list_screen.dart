import 'package:flutter/material.dart';
import '../../main.dart';
import '../../data/dummy_data.dart';
import '../../widgets/movie/movie_card.dart';

class MovieListScreen extends StatefulWidget {
  final bool embedded;
  const MovieListScreen({super.key, this.embedded = false});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final movies = DummyData.movies
        .where((m) => m.title.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Daftar Film',
              style: TextStyle(
                  color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            style: const TextStyle(color: AppColors.textPrimary),
            onChanged: (v) => setState(() => _query = v),
            decoration: const InputDecoration(
              hintText: 'Cari judul film...',
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: GridView.builder(
              itemCount: movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.58,
              ),
              itemBuilder: (context, i) => LayoutBuilder(
                builder: (context, constraints) =>
                    MovieCard(movie: movies[i], width: constraints.maxWidth),
              ),
            ),
          ),
        ],
      ),
    );

    if (widget.embedded) {
      return SafeArea(child: content);
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Film')),
      body: content,
    );
  }
}
