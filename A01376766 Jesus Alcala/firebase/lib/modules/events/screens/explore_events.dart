import 'package:design_proposal/modules/events/widgets/event_card.dart';
import 'package:flutter/material.dart';

import '../../../models/event.dart';

class ExploreEvents extends StatelessWidget {
  ExploreEvents({Key? key}) : super(key: key);

  final testEvent1 = Event(
      "Event1ID",
      "Evento de prueba 1",
      "Este evento es para la demostración del miércoles",
      DateTime.now(),
      {"city": "Naucalpan", "state": "México"},
      "IvanH",
      [{'name': 'Ivan', 'assistance': true}, {'name': 'Jesús', 'assistance': false}]
      );
  final testEvent2 = Event(
      "Event2ID",
      "Evento de prueba 2",
      "Este evento es para la demostración del miércoles",
      DateTime.now(),
      {"city": "Naucalpan", "state": "México"},
      "JesusA",
      [{'name': 'Ivan', 'assistance': true}, {'name': 'Jesús', 'assistance': false}]
      );
  final testEvent3 = Event(
      "Event23D",
      "Evento de prueba 3",
      "Este evento es para la demostración del miércoles",
      DateTime.now(),
      {"city": "Naucalpan", "state": "México"},
      "JordanG",
      [{'name': 'Ivan', 'assistance': true}, {'name': 'Jesús', 'assistance': false}]
      );
  final testEvent4 = Event(
      "Event2ID",
      "Evento de prueba 4",
      "Este evento es para la demostración del miércoles",
      DateTime.now(),
      {"city": "Naucalpan", "state": "México"},
      "AntonioG",
      [{'name': 'Ivan', 'assistance': true}, {'name': 'Jesús', 'assistance': false}]
      );
  final testEvent5 = Event(
      "Event2ID",
      "Evento de prueba 5",
      "Este evento es para la demostración del miércoles",
      DateTime.now(),
      {"city": "Naucalpan", "state": "México"},
      "RicardoZ",
      [{'name': 'Ivan', 'assistance': true}, {'name': 'Jesús', 'assistance': false}]
      );

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
