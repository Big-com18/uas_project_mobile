enum TicketStatus { active, done }

class TicketModel {
  final String id; // dipakai sebagai kode tiket, contoh "TKT-892481-X"
  final String movieTitle;
  final String posterUrl;
  final String cinemaName;
  final String studio;
  final String seat;
  final String format; // IMAX, Regular, dst
  final DateTime date;
  final String time;
  final int ticketCount;
  final TicketStatus status;

  const TicketModel({
    required this.id,
    required this.movieTitle,
    required this.posterUrl,
    required this.cinemaName,
    required this.studio,
    required this.seat,
    required this.format,
    required this.date,
    required this.time,
    required this.ticketCount,
    required this.status,
  });
}
