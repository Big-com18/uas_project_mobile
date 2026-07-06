# CineGo - Aplikasi Movie (UAS Pemrograman Mobile)

Aplikasi pemesanan tiket bioskop sederhana dibangun dengan Flutter.
Navigasi antar halaman memakai **named routes** (`Navigator.pushNamed`) lewat
`AppRoutes` (didefinisikan langsung di `main.dart`), dengan data dioper via
parameter `arguments`. State management tetap `setState` sesuai ketentuan soal
(tanpa Provider/Bloc/Riverpod dsb).

## Struktur Halaman & Alur Routing

| Route (`AppRoutes`) | Halaman | Argument yang dikirim |
|---|---|---|
| `/splash` | SplashScreen | - |
| `/onboarding` | OnboardingScreen | - |
| `/auth-choice` | AuthChoiceScreen (pilih Masuk/Daftar) | - |
| `/login` | LoginScreen | - |
| `/register` | RegisterScreen | - |
| `/home` | HomeScreen (BottomNav 4 tab) | `String username` |
| `/movie-list` | MovieListScreen | - |
| `/movie-detail` | MovieDetailScreen | `Movie movie` |
| `/cinema-list` | CinemaListScreen | - |
| `/cinema-detail` | CinemaDetailScreen | `Cinema cinema` |
| `/riwayat` | RiwayatScreen | - |

**Alur aplikasi:** Splash (± 2 detik, tampilkan logo) → Onboarding (3 slide)
→ Auth Choice (pilih Masuk atau Daftar) → Login/Register → Home.

Contoh pemakaian di dalam kode:
```dart
Navigator.pushNamed(context, AppRoutes.movieDetail, arguments: movie);
```

## Struktur Folder (per fitur, biar gampang dibaca)

```
movie_app/
├── pubspec.yaml
├── lib/
│   ├── main.dart                        # Entry point, tema, AppRoutes & MaterialApp router
│   ├── models/
│   │   ├── movie.dart
│   │   ├── cinema.dart
│   │   └── ticket.dart                  # + TicketStore (riwayat in-memory)
│   ├── data/
│   │   └── dummy_data.dart              # Data dummy film & bioskop
│   ├── screens/
│   │   ├── splash/
│   │   │   └── splash_screen.dart       # Logo di awal (splash dalam Flutter)
│   │   ├── onboarding/
│   │   │   └── onboarding_screen.dart
│   │   ├── auth/
│   │   │   ├── auth_choice_screen.dart  # Halaman pilih Masuk/Daftar
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   ├── home/
│   │   │   └── home_screen.dart         # Berisi BottomNav + tab Beranda
│   │   ├── movie/
│   │   │   ├── movie_list_screen.dart
│   │   │   └── movie_detail_screen.dart
│   │   ├── cinema/
│   │   │   ├── cinema_list_screen.dart
│   │   │   └── cinema_detail_screen.dart
│   │   ├── profile/
│   │   │   └── profile_screen.dart
│   │   └── ticket/
│   │       └── riwayat_screen.dart      # Riwayat pembelian tiket (opsional)
│   └── widgets/
│       ├── nav/
│       │   └── bottom_nav.dart          # Widget BottomNavigationBar kustom
│       ├── movie/
│       │   └── movie_card.dart
│       ├── cinema/
│       │   └── cinema_card.dart
│       └── ticket/
│           └── buy_ticket_sheet.dart    # BottomSheet Beli Tiket
```

Prinsip pembagian folder: setiap fitur (movie, cinema, auth, ticket, nav, dst)
punya foldernya sendiri baik di `screens/` maupun `widgets/`, jadi kalau mau
cari/edit sesuatu tinggal buka folder fiturnya — gak perlu scroll satu folder
besar isinya campur semua.

## Mengganti Logo

Ada 2 logo yang bisa diganti, keduanya sumbernya sama-sama dari 1 file:
`assets/images/logo.png` — **tinggal timpa file ini dengan gambar kamu**
(disarankan persegi, PNG transparan), tidak perlu ubah kode apapun.

1. **Logo di dalam aplikasi** (Splash Screen Flutter & Auth Choice Screen) —
   otomatis kepakai begitu file `assets/images/logo.png` diganti.
2. **Logo native / splash paling awal** (yang muncul sebelum Flutter selesai
   load — ini yang biasanya masih logo Flutter bawaan):
   - Project ini murni file Dart (`lib/` + `pubspec.yaml`), folder
     `android/` dan `ios/` belum digenerate. Kalau project kamu belum punya
     folder itu, jalankan dulu di root project:
     ```bash
     flutter create .
     ```
   - Setelah itu, jalankan:
     ```bash
     flutter pub get
     flutter pub run flutter_native_splash:create
     ```
     Package `flutter_native_splash` (sudah ditambahkan di `pubspec.yaml`)
     akan otomatis generate splash native Android & iOS pakai logo di
     `assets/images/logo.png` — jadi logo Flutter bawaan bakal ketutup sama
     logo kamu.
   - Kalau nanti ganti logo lagi, cukup timpa file `assets/images/logo.png`
     lalu ulangi command `flutter pub run flutter_native_splash:create`.

## Cara Menjalankan

```bash
flutter pub get
flutter run
```

Poster film & foto bioskop pakai `Image.network` (picsum.photos), jadi
memerlukan koneksi internet. Kalau gagal load, otomatis fallback ke ikon
placeholder (`errorBuilder`), jadi tidak akan menyebabkan crash.

## Catatan Teknis

- **Routing:** `AppRoutes` (nama-nama route) dan `onGenerateRoute` sekarang
  ada langsung di `main.dart`, satu file bareng `AppColors` dan `MovieApp`.
- **State management:** `setState` di tiap halaman; data antar halaman lewat
  `arguments` pada `Navigator.pushNamed`.
- **Data dummy:** ada di `lib/data/dummy_data.dart`, silakan diganti sesuai
  kebutuhan (API asli, database, dsb).
- **Riwayat tiket:** disimpan sementara di memori lewat `TicketStore`
  (static list), reset saat aplikasi ditutup — cukup untuk demo tanpa database.
