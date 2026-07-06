class Movie {
  final int id;
  final String title;
  final String genre;
  final String duration;
  final double rating;
  final String synopsis;
  final String posterUrl;
  final List<int> cinemaIds;

  Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.duration,
    required this.rating,
    required this.synopsis,
    required this.posterUrl,
    required this.cinemaIds,
  });
}
