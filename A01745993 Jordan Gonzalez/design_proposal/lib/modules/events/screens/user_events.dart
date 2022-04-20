import 'package:design_proposal/modules/events/screens/single_event.dart';
import 'package:design_proposal/modules/events/widgets/event_card.dart';
import 'package:flutter/material.dart';

import '../../../models/event.dart';

class UserEvents extends StatefulWidget {
  const UserEvents({Key? key}) : super(key: key);

  @override
  _UserEventsState createState() => _UserEventsState();
}

class _UserEventsState extends State<UserEvents> {
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
    return Center(
      child: ListView(
        children: [
          GestureDetector(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SingleEvent(event: testEvent)))
            },
            child: EventCard(event: testEvent),
          ),
        ],
      ),
    );
  }
}
