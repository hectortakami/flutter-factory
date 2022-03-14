import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

class Tickets extends StatelessWidget {
  const Tickets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(children: [
      TicketCard(),
      TicketCard(),
    ]));
  }
}

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
