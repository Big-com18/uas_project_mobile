import 'package:flutter/material.dart';
import '../../data/dummy_movies.dart';
import '../../model/movie_model.dart';
import '../../theme/app_text_styles.dart';
import '../../widget/filter_chip_item.dart';
import '../../widget/movie_poster_card.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final List<String> _genres = const [
    'All',
    'Action',
    'Sci-Fi',
    'Horror',
    'Comedy',
    'Drama',
  ];
  String _selectedGenre = 'All';

  List<MovieModel> get _filteredMovies {
    if (_selectedGenre == 'All') return dummyMovies;
    return dummyMovies.where((m) => m.genres.contains(_selectedGenre)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            child: Text('All Movies', style: AppTextStyles.h1),
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: _genres.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final genre = _genres[index];
                return FilterChipItem(
                  label: genre,
                  isSelected: _selectedGenre == genre,
                  onTap: () => setState(() => _selectedGenre = genre),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              itemCount: _filteredMovies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 16,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (context, index) {
                final movie = _filteredMovies[index];
                return MoviePosterCard(
                  movie: movie,
                  posterHeight: 190,
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/movie-detail',
                    arguments: movie.id,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
