class MovieModel {
  final String id;
  final String title;
  final String posterUrl;
  final double rating;
  final List<String> genres;
  final int durationMinutes;
  final String synopsis;
  final bool isNowPlaying;
  final bool isComingSoon;

  const MovieModel({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.rating,
    required this.genres,
    required this.durationMinutes,
    required this.synopsis,
    this.isNowPlaying = true,
    this.isComingSoon = false,
  });

  /// contoh output: "2h 49m"
  String get durationLabel {
    final h = durationMinutes ~/ 60;
    final m = durationMinutes % 60;
    return '${h}h ${m}m';
  }

  String get genresLabel => genres.join(', ');
}
