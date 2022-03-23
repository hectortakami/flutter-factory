import 'package:design_proposal/modules/tickets/widgets/ticket_card.dart';
import 'package:flutter/material.dart';

class Tickets extends StatelessWidget {
  const Tickets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(children: [
      TicketCard(),
      TicketCard(),
    ]));
  }
}
