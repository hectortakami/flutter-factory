import 'package:design_proposal/modules/events/widgets/event_card.dart';
import 'package:flutter/material.dart';

import '../../../models/event.dart';

class ExploreEvents extends StatelessWidget {
  ExploreEvents({Key? key}) : super(key: key);

  final testEvent1 = Event(
      uid: "Event1ID",
      name: "Evento de prueba 1",
      description: "Este evento es para la demostración del miércoles",
      date: DateTime.now(),
      address: {"city": "Naucalpan", "state": "México"},
      ownerUid: "IvanH",
      participants: [
        {'name': 'Ivan', 'assistance': true},
        {'name': 'Jesús', 'assistance': false}
      ]);
  final testEvent2 = Event(
      uid: "Event2ID",
      name: "Evento de prueba 2",
      description: "Este evento es para la demostración del miércoles",
      date: DateTime.now(),
      address: {"city": "Naucalpan", "state": "México"},
      ownerUid: "IvanH",
      participants: [
        {'name': 'Ivan', 'assistance': true},
        {'name': 'Jesús', 'assistance': false}
      ]);
  final testEvent3 = Event(
      uid: "Event3ID",
      name: "Evento de prueba 3",
      description: "Este evento es para la demostración del miércoles",
      date: DateTime.now(),
      address: {"city": "Naucalpan", "state": "México"},
      ownerUid: "IvanH",
      participants: [
        {'name': 'Ivan', 'assistance': true},
        {'name': 'Jesús', 'assistance': false}
      ]);
  final testEvent4 = Event(
      uid: "Event4ID",
      name: "Evento de prueba 5",
      description: "Este evento es para la demostración del miércoles",
      date: DateTime.now(),
      address: {"city": "Naucalpan", "state": "México"},
      ownerUid: "IvanH",
      participants: [
        {'name': 'Ivan', 'assistance': true},
        {'name': 'Jesús', 'assistance': false}
      ]);
  final testEvent5 = Event(
      uid: "Event5ID",
      name: "Evento de prueba 5",
      description: "Este evento es para la demostración del miércoles",
      date: DateTime.now(),
      address: {"city": "Naucalpan", "state": "México"},
      ownerUid: "IvanH",
      participants: [
        {'name': 'Ivan', 'assistance': true},
        {'name': 'Jesús', 'assistance': false}
      ]);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          EventCard(event: testEvent1),
          EventCard(event: testEvent2),
          EventCard(event: testEvent3),
          EventCard(event: testEvent4),
          EventCard(event: testEvent5),
        ],
      ),
    );
  }
}
