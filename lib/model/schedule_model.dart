class ScheduleModel {
  final String id;
  final String movieId;
  final String cinemaId;
  final String format; // Regular, IMAX, 4DX, Dolby
  final List<String> times; // ["12:00", "14:30", "16:30", "19:00"]

  const ScheduleModel({
    required this.id,
    required this.movieId,
    required this.cinemaId,
    required this.format,
    required this.times,
  });
}
