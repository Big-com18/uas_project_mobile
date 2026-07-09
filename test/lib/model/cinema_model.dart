class CinemaModel {
  final String id;
  final String name;
  final String address;
  final String city;
  final double distanceKm;
  final double rating;
  final List<String> facilities; // contoh: IMAX, DOLBY, SNACK BAR, PARKING, WIFI
  final String? heroImageUrl;

  const CinemaModel({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.distanceKm,
    this.rating = 4.5,
    this.facilities = const [],
    this.heroImageUrl,
  });

  String get distanceLabel => '${distanceKm.toStringAsFixed(1)} km';
}
