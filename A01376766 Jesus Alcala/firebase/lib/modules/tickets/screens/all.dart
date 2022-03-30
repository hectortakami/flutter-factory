import 'package:design_proposal/modules/tickets/widgets/ticket_card.dart';
import 'package:flutter/material.dart';

import '../../../models/ticket.dart';

class Tickets extends StatelessWidget {
  Tickets({Key? key}) : super(key: key);

  final testTicket1 = Ticket(
      "Ticket1ID",
      "Event1ID",
      "Demostración del miércoles",
      DateTime.now(),
      {"city": "Naucalpan", "state": "México"},
      );
  final testTicket2 = Ticket(
      "Ticket2ID",
      "Event2ID",
      "Planeación del jueves",
      DateTime.now(),
      {"city": "Naucalpan", "state": "México"},
      );
  final testTicket3 = Ticket(
      "Ticket3ID",
      "Event3ID",
      "Fiesta del viernes",
      DateTime.now(),
      {"city": "Naucalpan", "state": "México"},
      );

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      TicketCard(ticket: testTicket1),
      TicketCard(ticket: testTicket2),
      TicketCard(ticket: testTicket3)
    ]);
  }
}
