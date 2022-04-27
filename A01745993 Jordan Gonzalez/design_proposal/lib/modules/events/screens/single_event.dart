import 'package:design_proposal/models/ticket.dart';
import 'package:design_proposal/modules/events/widgets/assistant_tile.dart';
import 'package:design_proposal/modules/qr_scanner/screens/qr_scanner.dart';
import 'package:design_proposal/services/tickets.dart';
import 'package:flutter/material.dart';

import '../../../models/event.dart';

class SingleEvent extends StatefulWidget {
  final Event event;
  const SingleEvent({Key? key, required this.event}) : super(key: key);

  @override
  State<SingleEvent> createState() => _SingleEventState(event);
}

class _SingleEventState extends State<SingleEvent> {
  final Event event;

  _SingleEventState(this.event);

  @override
  Widget build(BuildContext context) {
    final TicketsService ticketsService = TicketsService();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.black,
              )),
        ],
        title: Text(event.name,
            style: const TextStyle(
                color: Colors.black, fontFamily: 'ProductSans')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const QrScanner()))
        },
        child: const Icon(Icons.qr_code),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder(
        stream: ticketsService.listEventTicketsAsStream(event.uid!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Ticket> tickets = snapshot.data as List<Ticket>;
            if (tickets.isNotEmpty) {
              return ListView.separated(
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {},
                    child: AssistantTile(ticket: tickets[index]),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 0.5);
                },
              );
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
