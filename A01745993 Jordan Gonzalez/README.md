# Design proposal

This app was made as a "preview" for the team assigned for the generation and reading of the QR codes in the final app.

## Project structure
```
.
├── lib
│   ├── main.dart               
│   │
│   ├── models
│   │   ├── event.dart
│   │   └── ticket.dart
│   │
│   ├── modules
│   │   ├── events
│   │   │   ├── screens
│   │   │   │   ├── explore_events.dart
│   │   │   │   ├── single_event.dart
│   │   │   │   └── user_events.dart
│   │   │   └── widgets
│   │   │       ├── assistant_tile.dart
│   │   │       └── event_card.dart
│   │   │
│   │   ├── qr_scanner
│   │   │   ├── screens
│   │   │   │   └── qr_scanner.dart
│   │   │   └── widgets
│   │   │
│   │   └── tickets
│   │       ├── screens
│   │       │   └── all.dart
│   │       └── widgets
│   │           ├── ticket_card.dart
│   │           └── ticker_qr.dart
│   │    
│   │
│   │
│   └── screens
│       └── home.dart
│
├── assets
├── android
├── ios
├── test
├── web
├── windows
├── analysis_options.yaml
├── design_proposal.iml
├── pubspec.lock
├── pubspec.yaml
└── README.md
```
## Description of each file 

### Models

Definitions for every structured element used in the app.

1. `event.dart`
```dart
class Event {
  final String uid;
  final String name;
  final String description;
  final DateTime date;
  Map<String, dynamic> location;
  final String ownerId;
  List<Map<String, dynamic>> participants;

  Event(this.uid, this.name, this.description, this.date, this.location, this.ownerId, this.participants);
}
```
2. `ticket.dart`
```dart
class Ticket {
  final String uid;
  final String eventId;
  final String eventName;
  final DateTime date;
  Map<String, dynamic> location;

  Ticket(this.uid, this.eventId, this.eventName, this.date, this.location);
}
```


### Screens
1. `explore_events.dart`. Here we deploy the events that will be happening readed from the database (future, not implemented yet) as event cards.
```dart
import 'package:design_proposal/modules/events/widgets/event_card.dart';
import 'package:flutter/material.dart';

import '../../../models/event.dart';

class ExploreEvents extends StatelessWidget {
  ExploreEvents({Key? key}) : super(key: key);

  final testEvent1 = Event(...);
  final testEvent2 = Event(...);
  final testEvent3 = Event(...);
  final testEvent4 = Event(...);
  final testEvent5 = Event(...);

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

```
2. `single_event.dart`. Here we can see the people who are going to attend to one specific event and it can show each of the QR codes (templates). 
```dart
import 'package:design_proposal/modules/events/widgets/assistant_tile.dart';
import 'package:design_proposal/modules/qr_scanner/screens/qr_scanner.dart';
import 'package:flutter/material.dart';

import '../../../models/event.dart';

class SingleEvent extends StatefulWidget {
  final Event event;
  const SingleEvent({Key? key, required this.event}) : super(key: key);

  @override
  State<SingleEvent> createState() => _SingleEventState(event);
}

class _SingleEventState extends State<SingleEvent> {
  final Event event;

  _SingleEventState(this.event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
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
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.black,
              )),
        ],
        title: Text(event.name,
            style: const TextStyle(color: Colors.black, fontFamily: 'ProductSans')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => const QrScanner()))
        },
        child: const Icon(Icons.qr_code),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: 
          event.participants.map((participant) => AssistantTile(name: participant['name'], assistance: participant['assistance'])).toList(),
      ),
    );
  }
}

```

3. `user_events.dart`. Here we found ourselves in the "events" tab and when you choose one event the screen created on "single event" is showed.
```dart
import 'package:design_proposal/modules/events/screens/single_event.dart';
import 'package:design_proposal/modules/events/widgets/event_card.dart';
import 'package:flutter/material.dart';

import '../../../models/event.dart';

class UserEvents extends StatefulWidget {
  const UserEvents({Key? key}) : super(key: key);

  @override
  _UserEventsState createState() => _UserEventsState();
}

class _UserEventsState extends State<UserEvents> {
  final testEvent = Event(
      "EventID",
      "Evento de prueba",
      "Este evento es para la demostración del miércoles",
      DateTime.now(),
      {"city": "Naucalpan", "state": "México"},
      "IvanH",
      [
        {'name': 'Ivan', 'assistance': true},
        {'name': 'Jesús', 'assistance': true},
        {'name': 'Ricardo', 'assistance': true},
        {'name': 'Jordan', 'assistance': true},
        {'name': 'Antonio', 'assistance': true},
        {'name': 'Víctor', 'assistance': false}
      ]);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          GestureDetector(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SingleEvent(event: testEvent)))
            },
            child: EventCard(event: testEvent),
          ),
        ],
      ),
    );
  }
}
```
4. `home.dart`. Declaration of the home screen, main scaffold, nav bar, etc.
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
5. `qr_scanner.dart`. This screen will use the phone´s camera and here we can scan a ticket QR code.
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
### Widgets 
1. `assistant_tile.dart`. This is the widget used on "single event" to deploy the assistants data of an specific event.
```dart
import 'package:flutter/material.dart';

class AssistantTile extends StatelessWidget {
  final String name;
  final bool assistance;
  const AssistantTile({Key? key, required this.name, required this.assistance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
      child: Row(
        children: [
          const Icon(
            Icons.account_circle,
            size: 32,
            color: Colors.black,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                name,
                style: const TextStyle(fontSize: 18),
              )),
          const Spacer(),
          assistance
              ? const Icon(
                  Icons.check,
                  color: Colors.black,
                )
              : const Icon(
                  Icons.cancel,
                  color: Colors.black,
                )
        ],
      ),
    );
  }
}
```
2. `event_card.dart`. This widget is used to create a card for each event to be showed.
```dart
import 'package:flutter/material.dart';

import '../../../models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard(
      {Key? key, required this.event})
      : super(key: key);

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
                  padding:
                      const EdgeInsets.only(left: 16, top: 12, bottom: 12, right: 16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.name,
                              style: const TextStyle(
                                  fontSize: 22, fontFamily: 'ProductSans')),
                          Text(
                            '${event.location['state']}, ${event.location['city']}',
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${event.date.day}/${event.date.month}/${event.date.year}',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('${event.date.hour}:${event.date.minute}',
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
```
3. `ticket_card.dart`. At the tickets tab this widget is used to show a event card with the addition that it can show the QR code (next widget) when pressed to enter the event.
```dart
import 'package:design_proposal/modules/tickets/widgets/ticket_qr.dart';
import 'package:flutter/material.dart';

import '../../../models/ticket.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({Key? key, required this.ticket}) : super(key: key);

  dynamic _showQrDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Expanded(
              child: SimpleDialog(
                title: Text(ticket.eventName),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TickerQr(ticket: ticket),
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
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 1, top: 1),
        child: GestureDetector(
          onTap: () => _showQrDialog(context),
          child: Card(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, top: 12, bottom: 12, right: 16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.qr_code,
                          color: Colors.grey,
                          size: 36,
                        ),
                        const Padding(padding: EdgeInsets.only(right: 8)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ticket.eventName,
                                style: const TextStyle(
                                    fontSize: 18, fontFamily: 'ProductSans')),
                            Text(
                              '${ticket.location['state']}, ${ticket.location['city']}',
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${ticket.date.day}/${ticket.date.month}/${ticket.date.year}'.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            Text('${ticket.date.hour}:${ticket.date.minute}'.toUpperCase(),
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
          ),
        ));
  }
}
```
4. `ticket_qr`. When you press the event card at the ticket tab we need this widget to show the qr code.
```dart
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../models/ticket.dart';

class TickerQr extends StatelessWidget {
  final Ticket ticket;

  const TickerQr({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: 'Ticket ID: ${ticket.uid}\nEvent ID: ${ticket.eventId}\nEvent Name: ${ticket.eventName}\nLocation: ${ticket.location['state']}, ${ticket.location['city']}',
      version: QrVersions.auto,
      size: 320,
      gapless: false,
    );
  }
}
```
### Screens at the app (images)
[![imagen-2022-03-16-000048.png](https://i.postimg.cc/0QkByKcm/imagen-2022-03-16-000048.png)](https://postimg.cc/Y4P3X0cq)[![imagen-2022-03-16-000121.png](https://i.postimg.cc/8PJncSBy/imagen-2022-03-16-000121.png)](https://postimg.cc/bsPRV45b)[![imagen-2022-03-16-000201.png](https://i.postimg.cc/8zLKdmYM/imagen-2022-03-16-000201.png)](https://postimg.cc/PCrQTYT5)[![imagen-2022-03-16-000232.png](https://i.postimg.cc/VNDF4GWr/imagen-2022-03-16-000232.png)](https://postimg.cc/06KmyC3P)[![imagen-2022-03-16-000259.png](https://i.postimg.cc/pybQygR7/imagen-2022-03-16-000259.png)](https://postimg.cc/T5054Nyq)[![imagen-2022-03-16-000321.png](https://i.postimg.cc/N0JzLfVz/imagen-2022-03-16-000321.png)](https://postimg.cc/5Hz3R1fB)
