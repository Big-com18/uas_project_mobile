import '../model/schedule_model.dart';

final List<ScheduleModel> dummySchedules = [
  const ScheduleModel(
    id: 'sc-001',
    movieId: 'mv-004', // Interstellar
    cinemaId: 'cn-001', // Grand Indonesia CGV
    format: 'IMAX',
    times: ['12:30', '14:00', '16:30', '19:15', '21:00'],
  ),
  const ScheduleModel(
    id: 'sc-002',
    movieId: 'mv-004',
    cinemaId: 'cn-002', // Pacific Place CGV
    format: 'Regular',
    times: ['13:15', '15:45', '18:30'],
  ),
  const ScheduleModel(
    id: 'sc-003',
    movieId: 'mv-004',
    cinemaId: 'cn-003', // Plaza Senayan CGV
    format: 'Dolby',
    times: ['12:00', '14:30', '17:00', '20:15'],
  ),
  const ScheduleModel(
    id: 'sc-004',
    movieId: 'mv-001', // Dune Part Two
    cinemaId: 'cn-001',
    format: 'IMAX',
    times: ['12:00', '14:30', '16:30', '19:00'],
  ),
  const ScheduleModel(
    id: 'sc-005',
    movieId: 'mv-002', // Oppenheimer
    cinemaId: 'cn-001',
    format: 'Regular',
    times: ['11:30', '15:00', '18:30'],
  ),
  const ScheduleModel(
    id: 'sc-006',
    movieId: 'mv-003', // The Batman
    cinemaId: 'cn-001',
    format: 'Regular',
    times: ['13:15', '16:00', '20:30'],
  ),
];

/// Ambil semua jadwal untuk 1 movie tertentu (dipakai di MovieDetailScreen)
List<ScheduleModel> schedulesForMovie(String movieId) =>
    dummySchedules.where((s) => s.movieId == movieId).toList();

/// Ambil semua jadwal untuk 1 cinema tertentu (dipakai di CinemaDetailScreen)
List<ScheduleModel> schedulesForCinema(String cinemaId) =>
    dummySchedules.where((s) => s.cinemaId == cinemaId).toList();
