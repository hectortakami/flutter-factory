import 'package:design_proposal/modules/tickets/widgets/ticket_card.dart';
import 'package:design_proposal/providers/auth_provider.dart';
import 'package:design_proposal/screens/loading.dart';
import 'package:design_proposal/services/tickets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/ticket.dart';

class Tickets extends StatelessWidget {
  Tickets({Key? key}) : super(key: key);

  final TicketsService ticketsService = TicketsService();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return StreamBuilder(
        stream: ticketsService.listUserTicketsAsStream(auth.user!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Ticket> tickets = snapshot.data as List<Ticket>;
            if (tickets.isNotEmpty) {
              return ListView.separated(
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {},
                    child: TicketCard(ticket: tickets[index]),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(height: 0.5);
                },
              );
            } else {
              return Container();
            }
          } else {
            return Loading();
          }
        });
  }
}
