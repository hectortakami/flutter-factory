import 'package:flutter/material.dart';

import '../../../models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 1, top: 1),
        child: Card(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1 / 8,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, top: 12, bottom: 12, right: 16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.name,
                              style: const TextStyle(
                                  fontSize: 22, fontFamily: 'ProductSans')),
                          Text(
                            '${event.address['state']}, ${event.address['city']}',
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              '${event.date.day}/${event.date.month}/${event.date.year}',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Text(
                              '${event.date.hour}:${event.date.minute.toString().padRight(2, '0')}',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
