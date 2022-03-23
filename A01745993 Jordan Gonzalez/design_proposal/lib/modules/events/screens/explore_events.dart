import 'package:design_proposal/modules/events/widgets/event_card.dart';
import 'package:flutter/material.dart';

class ExploreEvents extends StatelessWidget {
  const ExploreEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView(
          children: [
            EventCard(
              title: 'Google Cloud K8s',
              formattedLocation: 'Mexico City, MX',
              formattedDay: 'March 3rd',
              formattedTime: '16:00 PM',
            ),
            EventCard(
              title: 'Google Recruiting',
              formattedLocation: 'State of Mexico, MX',
              formattedDay: 'April 25th',
              formattedTime: '14:00 PM',
            ),
            EventCard(
              title: 'AWS Serverless',
              formattedLocation: 'Las Vegas, US',
              formattedDay: 'June 8th',
              formattedTime: '12:00 PM',
            ),
            EventCard(
              title: 'Graduation Day',
              formattedLocation: 'State of Mexico, MX',
              formattedDay: 'June 25th',
              formattedTime: '10:00 AM',
            ),
          ],
        ),
      ),
    );
  }
}
