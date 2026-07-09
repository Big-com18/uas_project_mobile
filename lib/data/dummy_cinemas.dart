import '../model/cinema_model.dart';
final List<CinemaModel> dummyCinemas = [
  const CinemaModel(
    id: 'cn-001',
    name: 'Grand Indonesia CGV',
    address: 'Jl. MH Thamrin No.1, Jakarta Pusat',
    city: 'Jakarta, ID',
    distanceKm: 2.5,
    rating: 4.8,
    facilities: ['IMAX', 'DOLBY', 'SNACK BAR', 'PARKING', 'WIFI'],
    heroImageUrl: 'assets/images/cgv-grand-indonesia.jpg',
  ),
  const CinemaModel(
    id: 'cn-002',
    name: 'Pacific Place CGV',
    address: 'Jl. Jend. Sudirman Kav 52-53, Jakarta Selatan',
    city: 'Jakarta, ID',
    distanceKm: 3.8,
    rating: 4.6,
    facilities: ['IMAX', 'SNACK BAR', 'PARKING', 'WIFI'],
    heroImageUrl: 'assets/images/cgv-pacific-place-jakarta.jpg',
  ),
  const CinemaModel(
    id: 'cn-003',
    name: 'Plaza Senayan CGV',
    address: 'Jl. Asia Afrika No.8, Jakarta Pusat',
    city: 'Jakarta, ID',
    distanceKm: 4.2,
    rating: 4.5,
    facilities: ['DOLBY', 'SNACK BAR', 'PARKING', 'WIFI'],
    heroImageUrl: 'assets/images/cgv-plaza-senayan.jpg',
  ),
  const CinemaModel(
    id: 'cn-004',
    name: 'FX Sudirman CGV',
    address: 'Jl. Jend. Sudirman No.Pintu 1 Senayan',
    city: 'Jakarta, ID',
    distanceKm: 3.0,
    rating: 4.7,
    facilities: ['IMAX', '4DX', 'REGULAR'],
    heroImageUrl: 'assets/images/cgv-sudirman.jpg',
  ),
];

CinemaModel findCinemaById(String id) => dummyCinemas.firstWhere(
      (c) => c.id == id,
      orElse: () => dummyCinemas.first,
    );
