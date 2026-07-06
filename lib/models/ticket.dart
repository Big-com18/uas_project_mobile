class Ticket {
  final String movieTitle;
  final String cinemaName;
  final String posterUrl;
  final String date;
  final String time;
  final int seatCount;
  final int totalPrice;
  final DateTime purchaseDate;

  Ticket({
    required this.movieTitle,
    required this.cinemaName,
    required this.posterUrl,
    required this.date,
    required this.time,
    required this.seatCount,
    required this.totalPrice,
    required this.purchaseDate,
  });
}

/// Penyimpanan riwayat tiket secara in-memory (tanpa package state management
/// tambahan, cukup static list yang bisa diakses dari halaman manapun).
class TicketStore {
  static final List<Ticket> _tickets = [];

  static List<Ticket> get tickets => List.unmodifiable(_tickets.reversed);

  static void addTicket(Ticket ticket) {
    _tickets.add(ticket);
  }
}
