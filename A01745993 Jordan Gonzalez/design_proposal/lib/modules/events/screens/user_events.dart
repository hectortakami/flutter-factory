import 'package:design_proposal/modules/events/screens/single_event.dart';
import 'package:design_proposal/modules/events/widgets/event_card.dart';
import 'package:design_proposal/providers/auth_provider.dart';
import 'package:design_proposal/services/events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/event.dart';

class UserEvents extends StatefulWidget {
  const UserEvents({Key? key}) : super(key: key);

  @override
  _UserEventsState createState() => _UserEventsState();
}

class _UserEventsState extends State<UserEvents> {
  final eventService = EventsService();
  final testEvent = Event(
      uid: "EventID",
      name: "Evento de prueba",
      description: "Este evento es para la demostración del miércoles",
      date: DateTime.now(),
      address: {"city": "Naucalpan", "state": "México"},
      ownerUid: "IvanH",
      participants: [
        {'name': 'Ivan', 'assistance': true},
        {'name': 'Jesús', 'assistance': true},
        {'name': 'Ricardo', 'assistance': true},
        {'name': 'Jordan', 'assistance': true},
        {'name': 'Antonio', 'assistance': true},
        {'name': 'Víctor', 'assistance': false}
      ]);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return StreamBuilder(
        stream: eventService.listUserEventsAsStream(auth.user!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Event> events = snapshot.data as List<Event>;
            if (events.isNotEmpty) {
              return ListView.separated(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SingleEvent(event: events[index])))
                    },
                    child: EventCard(event: events[index]),
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
        });
  }
}
