import 'package:design_proposal/modules/events/screens/single_event.dart';
import 'package:design_proposal/modules/events/widgets/event_card.dart';
import 'package:flutter/material.dart';

class UserEvents extends StatefulWidget {
  const UserEvents({Key? key}) : super(key: key);

  @override
  _UserEventsState createState() => _UserEventsState();
}

class _UserEventsState extends State<UserEvents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SingleEvent()))
              },
              child: EventCard(
                title: 'AWS Serverless',
                formattedLocation: 'Las Vegas, US',
                formattedDay: 'June 8th',
                formattedTime: '12:00 PM',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
