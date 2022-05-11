import 'package:design_proposal/modules/events/screens/single.dart';
import 'package:design_proposal/modules/events/widgets/event_card.dart';
import 'package:design_proposal/screens/loading.dart';
import 'package:design_proposal/services/events.dart';
import 'package:flutter/material.dart';

import '../../../models/event.dart';

class ExploreEvents extends StatelessWidget {
  ExploreEvents({Key? key}) : super(key: key);

  final eventService = EventsService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: eventService.listPublicEventsAsStream(),
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
