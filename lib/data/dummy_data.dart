import 'dart:math';
import '../models/movie.dart';
import '../models/cinema.dart';

class DummyData {
  static final List<Cinema> cinemas = [
    Cinema(
      id: 1,
      name: 'CGV Grand Indonesia',
      city: 'Jakarta Pusat',
      address: 'Jl. MH Thamrin No.1, Jakarta Pusat',
      imageUrl: 'https://picsum.photos/seed/cinema1/500/300',
      rating: 4.7,
    ),
    Cinema(
      id: 2,
      name: 'XXI Plaza Senayan',
      city: 'Jakarta Selatan',
      address: 'Jl. Asia Afrika, Jakarta Selatan',
      imageUrl: 'https://picsum.photos/seed/cinema2/500/300',
      rating: 4.5,
    ),
    Cinema(
      id: 3,
      name: 'Cinepolis Living World',
      city: 'Tangerang',
      address: 'BSD City, Tangerang',
      imageUrl: 'https://picsum.photos/seed/cinema3/500/300',
      rating: 4.3,
    ),
    Cinema(
      id: 4,
      name: 'CGV Bekasi Cyber Park',
      city: 'Bekasi',
      address: 'Jl. KH Noer Alie, Bekasi',
      imageUrl: 'https://picsum.photos/seed/cinema4/500/300',
      rating: 4.4,
    ),
    Cinema(
      id: 5,
      name: 'XXI Kelapa Gading',
      city: 'Jakarta Utara',
      address: 'Mall Kelapa Gading, Jakarta Utara',
      imageUrl: 'https://picsum.photos/seed/cinema5/500/300',
      rating: 4.2,
    ),
    Cinema(
      id: 6,
      name: 'Cinepolis Depok Town Square',
      city: 'Depok',
      address: 'Jl. Margonda Raya, Depok',
      imageUrl: 'https://picsum.photos/seed/cinema6/500/300',
      rating: 4.1,
    ),
  ];

  static final List<Movie> movies = [
    Movie(
      id: 1,
      title: 'Interstellar Voyage',
      genre: 'Sci-Fi, Adventure',
      duration: '2j 49m',
      rating: 4.9,
      synopsis:
          'Sekelompok penjelajah antariksa melakukan perjalanan melewati lubang cacing demi mencari harapan baru bagi umat manusia yang kehabisan sumber daya di Bumi.',
      posterUrl: 'https://picsum.photos/seed/movie1/500/750',
      cinemaIds: [1, 2, 3, 4, 5],
    ),
    Movie(
      id: 2,
      title: 'Kota Tanpa Cahaya',
      genre: 'Drama, Thriller',
      duration: '2j 05m',
      rating: 4.6,
      synopsis:
          'Seorang detektif menyelidiki serangkaian kasus misterius di kota yang perlahan kehilangan cahaya, sambil menyimpan rahasia kelam masa lalunya sendiri.',
      posterUrl: 'https://picsum.photos/seed/movie2/500/750',
      cinemaIds: [1, 3, 5],
    ),
    Movie(
      id: 3,
      title: 'Laskar Nusantara',
      genre: 'Action, Sejarah',
      duration: '2j 20m',
      rating: 4.7,
      synopsis:
          'Kisah perjuangan sekelompok pemuda dalam mempertahankan kampung halaman mereka dari ancaman penjajah di era kolonial.',
      posterUrl: 'https://picsum.photos/seed/movie3/500/750',
      cinemaIds: [2, 4, 6],
    ),
    Movie(
      id: 4,
      title: 'Senyum Terakhir',
      genre: 'Romance, Drama',
      duration: '1j 58m',
      rating: 4.4,
      synopsis:
          'Dua sahabat masa kecil dipertemukan kembali setelah bertahun-tahun berpisah, menghadapi perasaan yang tak pernah benar-benar hilang.',
      posterUrl: 'https://picsum.photos/seed/movie4/500/750',
      cinemaIds: [1, 2, 5, 6],
    ),
    Movie(
      id: 5,
      title: 'Legenda Rimba Timur',
      genre: 'Fantasy, Adventure',
      duration: '2j 12m',
      rating: 4.8,
      synopsis:
          'Petualangan seorang gadis desa yang menemukan kekuatan tersembunyi untuk melindungi hutan leluhurnya dari kekuatan jahat.',
      posterUrl: 'https://picsum.photos/seed/movie5/500/750',
      cinemaIds: [3, 4, 5, 1],
    ),
    Movie(
      id: 6,
      title: 'Malam Tanpa Bintang',
      genre: 'Horror, Mystery',
      duration: '1j 45m',
      rating: 4.3,
      synopsis:
          'Sebuah keluarga pindah ke rumah tua di pinggiran kota dan mulai mengalami kejadian aneh yang tak dapat dijelaskan.',
      posterUrl: 'https://picsum.photos/seed/movie6/500/750',
      cinemaIds: [2, 6],
    ),
  ];

  static List<Cinema> getCinemasForMovie(Movie movie) {
    final list = cinemas.where((c) => movie.cinemaIds.contains(c.id)).toList();
    return list.take(5).toList();
  }

  static List<Movie> getRandomMoviesForCinema(Cinema cinema, {int? count}) {
    final rnd = Random();
    final n = count ?? (rnd.nextBool() ? 3 : 5);
    final shuffled = List<Movie>.from(movies)..shuffle(rnd);
    return shuffled.take(n).toList();
  }
}
