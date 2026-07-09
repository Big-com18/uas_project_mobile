import '../model/ticket_model.dart';

final List<TicketModel> dummyTickets = [
  TicketModel(
    id: 'TKT-892481-X',
    movieTitle: 'Dune: Part Two',
    posterUrl: 'assets/images/dummy1.jpg',
    cinemaName: 'CGV Grand Indonesia',
    studio: 'Studio 1',
    seat: 'G, 12-13',
    format: 'IMAX',
    date: DateTime(2026, 2, 24),
    time: '14:30',
    ticketCount: 2,
    status: TicketStatus.active,
  ),
  TicketModel(
    id: 'TKT-773210-A',
    movieTitle: 'Oppenheimer',
    posterUrl: 'assets/images/dummy2.jpg',
    cinemaName: 'XXI Senayan City',
    studio: 'Studio 3',
    seat: 'D, 5',
    format: 'Regular',
    date: DateTime(2026, 2, 25),
    time: '18:00',
    ticketCount: 1,
    status: TicketStatus.active,
  ),
  TicketModel(
    id: 'TKT-651098-B',
    movieTitle: 'Interstellar',
    posterUrl: 'assets/images/dummy4.jpg',
    cinemaName: 'CGV Kelapa Gading',
    studio: 'Studio 2',
    seat: 'F, 8',
    format: 'IMAX',
    date: DateTime(2026, 1, 10),
    time: '20:00',
    ticketCount: 3,
    status: TicketStatus.done,
  ),
  TicketModel(
    id: 'TKT-402917-C',
    movieTitle: 'The Batman',
    posterUrl: 'assets/images/dummy3.jpg',
    cinemaName: 'CGV Pacific Place',
    studio: 'Studio 1',
    seat: 'C, 3-4',
    format: 'Regular',
    date: DateTime(2026, 1, 5),
    time: '18:15',
    ticketCount: 2,
    status: TicketStatus.done,
  ),
];

List<TicketModel> get activeTickets =>
    dummyTickets.where((t) => t.status == TicketStatus.active).toList();

List<TicketModel> get doneTickets =>
    dummyTickets.where((t) => t.status == TicketStatus.done).toList();
