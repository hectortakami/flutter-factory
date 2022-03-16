# Design proposal

## General description
This app was made as a "preview" for the team assigned for the generation and reading of the QR codes in the final app. 
## Structure of the files in the project
[![imagen-2022-03-15-211310.png](https://i.postimg.cc/L4NdzJ2s/imagen-2022-03-15-211310.png)](https://postimg.cc/z3bPNXLm)
## Description of each file 
### Screens
1. "explore_events.dart". Here we deploy the events that will be happening readed from the database (future, not implemented yet) as event cards.
```dart
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
```
2. "single_event.dart". Here we can see the people who are going to attend to one specific event and it can show each of the QR codes (templates). 
```dart
import 'package:design_proposal/modules/events/widgets/assistant_tile.dart';
import 'package:design_proposal/modules/qr_scanner/screens/qr_scanner.dart';
import 'package:flutter/material.dart';

class SingleEvent extends StatefulWidget {
  const SingleEvent({Key? key}) : super(key: key);

  @override
  State<SingleEvent> createState() => _SingleEventState();
}

class _SingleEventState extends State<SingleEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () => {},
              icon: Icon(
                Icons.more_horiz,
                color: Colors.black,
              )),
        ],
        title: Text('AWS Serverless',
            style: TextStyle(color: Colors.black, fontFamily: 'ProductSans')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => QrScanner()))
        },
        child: Icon(Icons.qr_code),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top: 16)),
          AssistantTile(name: 'Iván Honc'),
          AssistantTile(name: 'Ricardo Zambrano'),
          AssistantTile(name: 'Jordan González')
        ],
      ),
    );
  }
}
```
3. "user_events.dart". Here we found ourselves in the "events" tab and when you choose one event the screen created on "single event" is showed.
```dart
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
```
4. "home.dart". Declaration of the home screen, main scaffold, nav bar, etc.
```dart
import 'package:design_proposal/modules/events/screens/explore_events.dart';
import 'package:design_proposal/modules/events/screens/user_events.dart';
import 'package:design_proposal/modules/tickets/screens/all.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;

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
        floatingActionButton: _currentIndex == 1
            ? FloatingActionButton(
                onPressed: () => {},
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.add),
              )
            : Container(),
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
                activeIcon: Icon(Icons.event, color: Colors.blueAccent),
                icon: Icon(Icons.event, color: Colors.grey),
                label: 'Events'),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.search,
                  color: Colors.blueAccent,
                ),
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                label: 'Explore'),
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
          children: [UserEvents(), ExploreEvents(), Tickets()],
        ));
  }
}
```
5. "qr_scanner.dart". This screen will use the phone´s camera and here we can scan a ticket QR code.
```dart
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);
  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner>
    with SingleTickerProviderStateMixin {
  String? barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Ticket Scanner'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Builder(builder: (context) {
        return Stack(
          children: [
            MobileScanner(
                fit: BoxFit.cover,
                // allowDuplicates: false,
                onDetect: (barcode, args) {
                  setState(() {
                    this.barcode = barcode.rawValue;
                  });
                  print(barcode.rawValue);
                  print(barcode);
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height * 1 / 6,
                color: Colors.black.withOpacity(0.4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        height: 50,
                        child: FittedBox(
                          child: Text(
                            barcode ?? 'Scan something!',
                            overflow: TextOverflow.fade,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

```
### widgets 
1. "assistant_tile.dart". This is the widget used on "single event" to deploy the assistants data of an specific event.
```dart
import 'package:flutter/material.dart';

class AssistantTile extends StatelessWidget {
  final String name;
  const AssistantTile({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
      child: Row(
        children: [
          Icon(
            Icons.account_circle,
            size: 32,
            color: Colors.black,
          ),
          Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                this.name,
                style: TextStyle(fontSize: 18),
              )),
          Spacer(),
          Icon(
            Icons.check,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
```
2. "event_card.dart". This widget is used to create a card for each event to be showed.
```dart
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
```
3. "ticket_card.dart". At the tickets tab this widget is used to show a event card with the addition that it can show the QR code (next widget) when pressed to enter the event.
```dart
import 'package:design_proposal/modules/tickets/widgets/ticket_qr.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({Key? key}) : super(key: key);

  dynamic _showQrDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Expanded(
              child: SimpleDialog(
                title: Text('Event Name'),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TickerQr(),
                    ),
                  ),
                ],
                elevation: 5,
                //backgroundColor: Colors.green,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 1, top: 1),
        child: GestureDetector(
          onTap: () => _showQrDialog(context),
          child: Card(
            child: Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16, top: 12, bottom: 12, right: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.qr_code,
                          color: Colors.grey,
                          size: 36,
                        ),
                        Padding(padding: EdgeInsets.only(right: 8)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Event name',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'ProductSans')),
                            Text(
                              'Location',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('day'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            Text('time'.toUpperCase(),
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
          ),
        ));
  }
}
```
4. "ticket_qr". When you press the event card at the ticket tab we need this widget to show the qr code.
```dart
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TickerQr extends StatelessWidget {
  const TickerQr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: 'Ticket key/id/whatever goes here',
      version: QrVersions.auto,
      size: 320,
      gapless: false,
    );
  }
}
```
### Screens at the app (images)
[![imagen-2022-03-16-000048.png](https://i.postimg.cc/0QkByKcm/imagen-2022-03-16-000048.png)](https://postimg.cc/Y4P3X0cq)[![imagen-2022-03-16-000121.png](https://i.postimg.cc/8PJncSBy/imagen-2022-03-16-000121.png)](https://postimg.cc/bsPRV45b)[![imagen-2022-03-16-000201.png](https://i.postimg.cc/8zLKdmYM/imagen-2022-03-16-000201.png)](https://postimg.cc/PCrQTYT5)[![imagen-2022-03-16-000232.png](https://i.postimg.cc/VNDF4GWr/imagen-2022-03-16-000232.png)](https://postimg.cc/06KmyC3P)[![imagen-2022-03-16-000259.png](https://i.postimg.cc/pybQygR7/imagen-2022-03-16-000259.png)](https://postimg.cc/T5054Nyq)[![imagen-2022-03-16-000321.png](https://i.postimg.cc/N0JzLfVz/imagen-2022-03-16-000321.png)](https://postimg.cc/5Hz3R1fB)
