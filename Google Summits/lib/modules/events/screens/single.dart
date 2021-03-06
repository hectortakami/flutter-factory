import 'package:design_proposal/models/ticket.dart';
import 'package:design_proposal/modules/events/screens/form.dart';
import 'package:design_proposal/modules/events/widgets/assistant_tile.dart';
import 'package:design_proposal/modules/qr_scanner/screens/qr_scanner.dart';
import 'package:design_proposal/modules/tickets/screens/form.dart';
import 'package:design_proposal/providers/auth_provider.dart';
import 'package:design_proposal/services/events.dart';
import 'package:design_proposal/services/tickets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:design_proposal/screens/loading.dart';
import 'package:collection/collection.dart';

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
    final auth = Provider.of<AuthProvider>(context);
    bool isEventOwner = auth.user!.uid == event.ownerUid;

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
          actions: isEventOwner
              ? [
                  IconButton(
                      onPressed: () => _buildEventSettingsBottomSheet(context),
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                      )),
                ]
              : [],
          title: Text(event.name,
              style: const TextStyle(
                  color: Colors.black, fontFamily: 'ProductSans')),
        ),
        floatingActionButton: isEventOwner
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: 'add-participant',
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => TicketForm(
                                    event: event,
                                  )))
                    },
                    child: const Icon(Icons.add),
                    backgroundColor: Colors.blueAccent,
                  ),
                  const Padding(padding: EdgeInsets.only(left: 8)),
                  FloatingActionButton(
                    heroTag: 'scan-ticket',
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => QrScanner(
                                    event: event,
                                  )))
                    },
                    child: const Icon(Icons.qr_code),
                    backgroundColor: Colors.blueAccent,
                  ),
                ],
              )
            : Container(),
        body: isEventOwner ? OwnerView(context) : VisitorView(context, auth));
  }

  Widget OwnerView(BuildContext context) {
    final TicketsService ticketsService = TicketsService();

    return StreamBuilder(
      stream: ticketsService.listEventTicketsAsStream(event.uid!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Ticket> tickets = snapshot.data as List<Ticket>;
          if (tickets.isNotEmpty) {
            return ListView.separated(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                return Dismissible(
                    key: Key(tickets[index].uid!),
                    direction: DismissDirection.endToStart,
                    background: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Text(
                              'Remove from event',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))),
                    onDismissed: (_) =>
                        ticketsService.deleteTicket(tickets[index]),
                    child: AssistantTile(ticket: tickets[index]));
              },
              separatorBuilder: (context, index) {
                return const Divider(height: 0.5);
              },
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: Text(
                    'There are no participants to this event.',
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            );
          }
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: const [
                Text('An error occurred, try loading this event later.')
              ],
            ),
          );
        }
      },
    );
  }

  Widget VisitorView(BuildContext context, AuthProvider auth) {
    final TicketsService ticketsService = TicketsService();
    return StreamBuilder(
        stream: ticketsService.listUserTicketsAsStream(auth.user!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Ticket> tickets = snapshot.data as List<Ticket>;
            final Ticket fbTicket = Ticket(
                eventUid: event.uid!,
                userUid: auth.user!.uid,
                attendance: false,
                holder: {
                  'name': auth.user!.displayName!.split(' ')[0],
                  'lastname': auth.user!.displayName!.split(' ')[1]
                });

            var listedTicket = tickets.firstWhereOrNull((item) =>
                item.eventUid == fbTicket.eventUid &&
                item.userUid == fbTicket.userUid);

            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(event.description,
                          style: const TextStyle(fontSize: 18))),
                  const SizedBox(height: 100),
                  Center(
                    child: listedTicket == null
                        ? TextButton(
                            onPressed: () {
                              if (fbTicket == null) {
                                ticketsService.setTicket(fbTicket);
                              } else {
                                ticketsService.addTicket(fbTicket);
                              }
                            },
                            child: const Text('Join Event',
                                style: TextStyle(fontSize: 16)))
                        : const Text('You are already a participant',
                            style: TextStyle(
                                fontSize: 16, color: Colors.blueAccent)),
                  )
                ]);
          } else {
            return Loading();
          }
        });
  }

  void _buildEventSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ListTile(
                title: const Text('Edit event'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EventForm(
                                event: event,
                              )));
                },
              ),
              ListTile(
                  title: const Text('Delete event'),
                  onTap: () {
                    _buildDeleteConfirmation(context);
                  }),
              const ListTile(
                title: Text(''),
              ),
              const Divider(
                color: Colors.transparent,
              )
            ],
          );
        });
  }

  void _buildDeleteConfirmation(BuildContext context) {
    final eventService = EventsService();
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Do you want to delete this event?'),
              content: Text(
                  'This event and its tickets will be deleted permanently.'),
              actions: [
                TextButton(
                    onPressed: () async {
                      await eventService.deleteEvent(event);
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 3);
                    },
                    child: Text('Yes')),
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text('No')),
              ],
            ));
  }
}
