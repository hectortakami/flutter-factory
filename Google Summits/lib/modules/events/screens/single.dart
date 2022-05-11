import 'package:design_proposal/models/ticket.dart';
import 'package:design_proposal/modules/events/screens/form.dart';
import 'package:design_proposal/modules/events/widgets/assistant_tile.dart';
import 'package:design_proposal/modules/qr_scanner/screens/qr_scanner.dart';
import 'package:design_proposal/modules/tickets/screens/form.dart';
import 'package:design_proposal/providers/auth_provider.dart';
import 'package:design_proposal/services/tickets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        body: isEventOwner ? ownerView(context) : Container());
  }

  Widget ownerView(BuildContext context) {
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
                return GestureDetector(
                  onTap: () => {},
                  child: AssistantTile(ticket: tickets[index]),
                );
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
                onTap: () => {},
              ),
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
}
