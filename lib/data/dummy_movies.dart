import '../model/movie_model.dart';

/// Data dummy sementara sebelum backend jadi.
/// Nanti tinggal ganti sumber data ini jadi hasil fetch dari API temen kamu,
/// screen-screen lain gak perlu diubah selama shape-nya (MovieModel) sama.
final List<MovieModel> dummyMovies = [
  const MovieModel(
    id: 'mv-001',
    title: 'Dune: Part Two',
    posterUrl: 'assets/images/dune_part2.jpg',
    rating: 4.8,
    genres: ['Sci-Fi', 'Adventure'],
    durationMinutes: 166,
    synopsis:
        'Paul Atreides unites with Chani and the Fremen while on a path '
        'of revenge against the conspirators who destroyed his family, '
        'as he tries to prevent a terrible future only he can foresee.',
    isNowPlaying: true,
  ),
  const MovieModel(
    id: 'mv-002',
    title: 'Oppenheimer',
    posterUrl: 'assets/images/dummy3.jpg',
    rating: 4.9,
    genres: ['Drama', 'Thriller'],
    durationMinutes: 180,
    synopsis:
        'The story of J. Robert Oppenheimer\'s role in the development of '
        'the atomic bomb during World War II, and the moral weight he '
        'carried for the rest of his life.',
    isNowPlaying: true,
  ),
  const MovieModel(
    id: 'mv-003',
    title: 'The Batman',
    posterUrl: 'assets/images/batman.jpg',
    rating: 4.5,
    genres: ['Action', 'Crime'],
    durationMinutes: 176,
    synopsis:
        'When a sadistic serial killer begins murdering key political '
        'figures in Gotham, Batman is forced to investigate the city\'s '
        'hidden corruption and question his family\'s involvement.',
    isNowPlaying: true,
  ),
  const MovieModel(
    id: 'mv-004',
    title: 'Interstellar',
    posterUrl: 'assets/images/img.png',
    rating: 4.8,
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    durationMinutes: 169,
    synopsis:
        'When Earth becomes uninhabitable in the future, a farmer and '
        'ex-NASA pilot, Joseph Cooper, is tasked to pilot a spacecraft, '
        'along with a team of researchers, to find a new planet for humans.',
    isNowPlaying: true,
  ),
  const MovieModel(
    id: 'mv-005',
    title: 'Mad Max: Wasteland',
    posterUrl: 'assets/images/img_1.png',
    rating: 0,
    genres: ['Action', 'Adventure'],
    durationMinutes: 148,
    synopsis: 'Coming soon.',
    isNowPlaying: false,
    isComingSoon: true,
  ),
  const MovieModel(
    id: 'mv-006',
    title: 'Horizon',
    posterUrl: 'assets/images/img_2.png',
    rating: 0,
    genres: ['Adventure', 'Drama'],
    durationMinutes: 155,
    synopsis: 'Coming soon.',
    isNowPlaying: false,
    isComingSoon: true,
  ),
];

MovieModel findMovieById(String id) =>
    dummyMovies.firstWhere((m) => m.id == id, orElse: () => dummyMovies.first);
