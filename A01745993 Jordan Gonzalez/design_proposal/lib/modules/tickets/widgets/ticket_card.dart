import 'package:design_proposal/modules/tickets/widgets/ticket_qr.dart';
import 'package:flutter/material.dart';

import '../../../models/ticket.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({Key? key, required this.ticket}) : super(key: key);

  dynamic _showQrDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Expanded(
              child: SimpleDialog(
                title: Text(ticket.eventName),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TickerQr(ticket: ticket),
                    ),
                  ),
                ],
                elevation: 5,
                //backgroundColor: Colors.green,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 1, top: 1),
        child: GestureDetector(
          onTap: () => _showQrDialog(context),
          child: Card(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, top: 12, bottom: 12, right: 16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.qr_code,
                          color: Colors.grey,
                          size: 36,
                        ),
                        const Padding(padding: EdgeInsets.only(right: 8)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ticket.eventName,
                                style: const TextStyle(
                                    fontSize: 18, fontFamily: 'ProductSans')),
                            Text(
                              '${ticket.location['state']}, ${ticket.location['city']}',
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${ticket.date.day}/${ticket.date.month}/${ticket.date.year}'.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            Text('${ticket.date.hour}:${ticket.date.minute}'.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
