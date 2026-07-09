class OrderModel {
  final String movieTitle;
  final String posterUrl;
  final String cinemaName;
  final String format; // IMAX, Regular, dst
  final DateTime date;
  final String time;
  final int ticketCount;
  final int pricePerTicket; // dalam Rupiah, contoh 50000

  const OrderModel({
    required this.movieTitle,
    required this.posterUrl,
    required this.cinemaName,
    required this.format,
    required this.date,
    required this.time,
    required this.ticketCount,
    required this.pricePerTicket,
  });

  int get totalPrice => ticketCount * pricePerTicket;

  OrderModel copyWith({int? ticketCount}) {
    return OrderModel(
      movieTitle: movieTitle,
      posterUrl: posterUrl,
      cinemaName: cinemaName,
      format: format,
      date: date,
      time: time,
      ticketCount: ticketCount ?? this.ticketCount,
      pricePerTicket: pricePerTicket,
    );
  }
}
