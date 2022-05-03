import 'package:design_proposal/models/event.dart';
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
                title: Text(
                  '${ticket.holder['name']} ${ticket.holder['lastname']}',
                  textAlign: TextAlign.center,
                ), //ticket.eventName),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TickerQr(ticket: ticket),
                    ),
                  ),
                  Text(
                    ticket.uid!,
                    textAlign: TextAlign.center,
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
    return StreamBuilder(
      stream: ticket.event!,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Event event = snapshot.data as Event;
          return Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 1, top: 1),
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
                                  Text(event.name,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'ProductSans')),
                                  Text(
                                    '${ticket.holder['name']} ${ticket.holder['lastname']}',
                                    style: const TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                      '${event.date.day}/${event.date.month}/${event.date.year}'
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      '${event.date.hour}:${event.date.minute.toString().padRight(2, '0')}'
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
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
        } else {
          return Container();
        }
      },
    );
  }
}
