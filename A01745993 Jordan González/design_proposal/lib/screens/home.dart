import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  void _selectIndex(int index) => setState(() => {_currentIndex = index});

  @override
  Widget build(BuildContext context) {
    const fontSize24 = TextStyle(fontSize: 24);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Google Summits',
            style: TextStyle(color: Colors.grey, fontFamily: 'ProductSans'),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => {},
                icon: Icon(
                  Icons.account_circle,
                  size: 32,
                  color: Colors.black,
                )),
            Padding(padding: EdgeInsets.only(right: 4)),
          ],
          leading: IconButton(
            onPressed: () => {},
            icon: Icon(Icons.menu, color: Colors.black, size: 24),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          onTap: _selectIndex,
          elevation: 10,
          currentIndex: _currentIndex,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: Colors.blueAccent,
          items: [
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.event,
                  color: Colors.blueAccent,
                ),
                icon: Icon(
                  Icons.event,
                  color: Colors.grey,
                ),
                label: 'Events'),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.turned_in, color: Colors.blueAccent),
                icon: Icon(Icons.turned_in_not, color: Colors.grey),
                label: 'Saved'),
            BottomNavigationBarItem(
                activeIcon:
                    Icon(Icons.confirmation_number, color: Colors.blueAccent),
                icon: Icon(Icons.confirmation_number_outlined,
                    color: Colors.grey),
                label: 'Tickets'),
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [Events(), Container(), Tickets()],
        ));
  }
}

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

class Events extends StatelessWidget {
  const Events({Key? key}) : super(key: key);

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

class Tickets extends StatelessWidget {
  const Tickets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: ListView(children: []));
  }
}
