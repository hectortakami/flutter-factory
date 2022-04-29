import 'package:design_proposal/modules/events/screens/single.dart';
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
