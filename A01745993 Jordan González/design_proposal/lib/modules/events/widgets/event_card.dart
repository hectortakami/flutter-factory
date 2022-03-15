import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String formattedLocation;
  final String formattedDay;
  final String formattedTime;

  const EventCard(
      {Key? key,
      required this.title,
      required this.formattedLocation,
      required this.formattedDay,
      required this.formattedTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 1, top: 1),
        child: Card(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1 / 8,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, top: 12, bottom: 12, right: 16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  fontSize: 22, fontFamily: 'ProductSans')),
                          Text(
                            formattedLocation,
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(formattedDay.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Text(formattedTime.toUpperCase(),
                              style: TextStyle(
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
