# Design_proposal

A new Flutter project.

This app is a prototype where we are integrating the efforts of both teams, the one in charge of creating the UI and the QR code functionality and the Firebase team.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Pre-requisites

---

1. Install [Flutter](1).
2. [Set up](2) an editor.
3. Run the following command and ensure everything in the output is checked.

```zsh
flutter doctor
```

## Create the app

---

In order to create our app, it is necessary to generate a boilerplate for us to start coding.

### 1. Generate boilerplate app

---

Open a terminal in the desired folder of destination and run the following commands:

```zsh
flutter create counter_app
cd counter_app
```

Once everything is created, open the generated folder `counter_app/lib` in your editor of preference and remove every comment, and the classes: `MyHomePage` and `_MyHomePageState`.

Rename the class `MyApp` to `CounterApp`, and every reference to it.

The code in `main.dart` should look like this:

```dart
// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // Rename this title to Counter App
      theme: ThemeData(
        primarySwatch: Colors.blue, // Try changing the color
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'), // This line should be marked as an error since we deleted the class.
    );
  }
}
```

## Project structure

```
.
├── lib
│   ├── main.dart
│   │
│   ├── models
│   │   ├── event.dart
│   │   |── ticket.dart └
|   |   └── user.dart
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
|   |   ├── core
│   │   │   └── login.dart
|   |   |
│   │   └── tickets
│   │       ├── screens
│   │       │   └── all.dart
│   │       └── widgets
│   │           ├── ticket_card.dart
│   │           └── ticker_qr.dart
│   │
│   │
│   │
│   |── screens
│   |   └── home.dart
│   |── providers
│   |   └── auth_provider.dart
│   └── services
│       |── firebase
|       |    |── firestore_client.dart
|       |    └── firestore_paths.dart
|       └── event.dart
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

3. `user.dart`

```dart

import 'package:firebase_auth/firebase_auth.dart' as fb;

class User {
  String uid;
  String? email;
  String? displayName;
  String? phoneNumber;
  String? photoUrl;

  User(
      {required this.uid,
      this.email,
      this.displayName,
      this.phoneNumber,
      this.photoUrl});

  factory User.fromFirebase(fb.User? firebaseUser) {
    return User(
        uid: firebaseUser!.uid,
        email: firebaseUser.email,
        displayName: firebaseUser.displayName,
        phoneNumber: firebaseUser.phoneNumber,
        photoUrl: firebaseUser.photoURL);
  }
}
```

### Modules

#### Core

1. 'login.dart' Creation of the login page where the user can login using his Google account.

```dart

import 'package:design_proposal/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: size.width / 4),
            const Text(
              'Google Summits',
              style: TextStyle(
                  color: Colors.grey, fontFamily: 'ProductSans', fontSize: 24),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: auth.status == Status.uninitialized
                    ? Container(
                        color: Colors.grey[200],
                        height: 50,
                        width: double.infinity,
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: SignInButton(
                          Buttons.Google,
                          onPressed: auth.signInWithGoogle,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
              ),
            ),
            SizedBox(height: size.width / 16)
          ],
        ),
      ),
    );
  }
}


```

#### Events

##### Screens

1. 'explore_events.dart' Screen where the user can explore other events.

```dart

import 'package:design_proposal/modules/events/screens/single_event.dart';
import 'package:design_proposal/modules/events/widgets/event_card.dart';
import 'package:design_proposal/services/events.dart';
import 'package:flutter/material.dart';

import '../../../models/event.dart';

class ExploreEvents extends StatelessWidget {
  ExploreEvents({Key? key}) : super(key: key);

  final eventService = EventsService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: eventService.listEventsAsStream(),
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


```

2. 'single_event.dart' Creation of the event.

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
        children: []
          // event.participants.map((participant) => AssistantTile(name: participant['name'], assistance: participant['assistance'])).toList(),
      ),
    );
  }
}


```

3. 'user_events.dart' Screen where the user can see their

events.

```dart

import 'package:design_proposal/modules/events/screens/single_event.dart';
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


```

##### Widgets

1. 'assistant_tile.dart'

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

2. 'event_card.dart' Card where the event is created and information about the event is introduced by the user.

```dart

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


```

#### Qr_scanner

##### screens

1. 'qr_scanner.dart Screen where the user scans a qr code

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
        title: const Text('Ticket Scanner'),
        leading: IconButton(
          icon: const Icon(
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

#### Tickets

##### screens

1. 'all.dart'

```dart

import 'package:design_proposal/modules/tickets/widgets/ticket_card.dart';
import 'package:flutter/material.dart';

import '../../../models/ticket.dart';

class Tickets extends StatelessWidget {
  Tickets({Key? key}) : super(key: key);

  final testTicket1 = Ticket(
      "Ticket1ID",
      "Event1ID",
      "Demostración del miércoles",
      DateTime.now(),
      {"city": "Naucalpan", "state": "México"},
      );
  final testTicket2 = Ticket(
      "Ticket2ID",
      "Event2ID",
      "Planeación del jueves",
      DateTime.now(),
      {"city": "Naucalpan", "state": "México"},
      );
  final testTicket3 = Ticket(
      "Ticket3ID",
      "Event3ID",
      "Fiesta del viernes",
      DateTime.now(),
      {"city": "Naucalpan", "state": "México"},
      );

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      TicketCard(ticket: testTicket1),
      TicketCard(ticket: testTicket2),
      TicketCard(ticket: testTicket3)
    ]);
  }
}


```

##### widgets

1. 'ticket_card.dart

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

2. 'ticket_qr.dart'

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

### Providers

1. 'auth_provider.dart' Provider file for the authentication.

```dart

import 'package:design_proposal/models/user.dart' as gs;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated,
}

class AuthProvider extends ChangeNotifier {
  late FirebaseAuth _auth;

  Status _status = Status.uninitialized;
  gs.User? _user;

  Status get status => _status;

  gs.User? get user => _user;

  AuthProvider() {
    _auth = FirebaseAuth.instance;

    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  Future<void> onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.unauthenticated;
    } else {
      _user = _userFromFirebase(firebaseUser);
      _status = Status.authenticated;
    }
    notifyListeners();
  }

  gs.User? _userFromFirebase(User? firebaseUser) {
    if (firebaseUser == null) {
      return null;
    }
    return gs.User.fromFirebase(firebaseUser);
  }

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (error) {
      print(error);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _status = Status.unauthenticated;
    notifyListeners();
  }
}


```

### Services

1. 'events.dart' Creation of the events.

```dart

// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_proposal/models/event.dart';
import 'package:design_proposal/services/firebase/firestore_client.dart';
import 'package:design_proposal/services/firebase/firestore_paths.dart';

/**
 * Inspired by: https://github.com/KenAragorn/create_flutter_provider_app
 */

/// TODO: Add documentation

class EventsService {
  EventsService();

  final _firestoreService = FirestoreClient.instance;

  Future<void> addEvent(Event event) async => await _firestoreService.add(
      path: FirestorePath.events(), document: event.toMap());

  Future<void> setEvent(Event event) async => await _firestoreService.set(
      path: FirestorePath.event(event.uid!), document: event.toMap());

  Future<void> deleteEvent(Event event) async =>
      await _firestoreService.delete(path: FirestorePath.event(event.uid!));

  Stream<Event> getEventAsStream(String uid) =>
      _firestoreService.documentStream(
          path: FirestorePath.event(uid),
          builder: (data, uid) => Event.fromMap(data, uid));

  Stream<List<Event>> listEventsAsStream() =>
      _firestoreService.collectionStream(
          path: FirestorePath.events(),
          builder: (data, uid) => Event.fromMap(data, uid));

  Stream<List<Event>> listUserEventsAsStream(String userUid) {
    Query query = FirebaseFirestore.instance
        .collection(FirestorePath.events())
        .where('ownerUid', isEqualTo: userUid);
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => Event.fromMap(
              snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();
      return result;
    });
  }
}


```

#### firebase

1. 'firestore_client.dart' Client to use the firestore database inside the flutter application.

```dart

import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * Inspired by: https://github.com/KenAragorn/create_flutter_provider_app
 */

/// This class represents every possible CRUD operations for Cloud Firestore.
/// Represented as generic implementations for the document-based database.
class FirestoreClient {
  FirestoreClient._();
  static final instance = FirestoreClient._();

  /// Add a document to a collection given its path
  Future<void> add(
      {required String path, required Map<String, dynamic> document}) async {
    final CollectionReference reference =
        FirebaseFirestore.instance.collection(path);
    await reference.add(document);
  }

  /// Update a document to a collection given its path.
  Future<void> set({
    required String path,
    required Map<String, dynamic> document,
    bool merge = false,
  }) async {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    await reference.set(document);
  }

  /// Add multiple documents to a collection given its path.
  /// TODO: Implement
  Future<void> bulkSet({
    required String path,
    required List<Map<String, dynamic>> documents,
    bool merge = false,
  }) async {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final batchSet = FirebaseFirestore.instance.batch();

//    for()
//    batchSet.
  }

  /// Remove a document from a collection given its path.
  Future<void> delete({required String path}) async {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }

  /// Retrieve every document in a collection.
  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  /// Retrieve a document from a collection.
  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        builder(snapshot.data() as Map<String, dynamic>, snapshot.id));
  }
}


```

2. 'firestore_paths.dart' Paths inside the firestore database to store the users, events and tickets.

```dart

/// This class represents every possible path in our Cloud Firestore.
class FirestorePath {
  static String event(String uid) => 'events/$uid';
  static String events() => 'events';

  static String ticket(String uid) => 'tickets/$uid';
  static String tickets() => 'tickets';

  static String user(String uid) => 'users/$uid';
  static String users() => 'users';
}


```

### Screens

1. `home.dart`. Declaration of the home screen, main scaffold, nav bar, etc.

```dart
import 'package:design_proposal/modules/events/screens/explore_events.dart';
import 'package:design_proposal/modules/events/screens/user_events.dart';
import 'package:design_proposal/modules/tickets/screens/all.dart';
import 'package:design_proposal/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/event.dart';
import '../services/events.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final eventService = EventsService();

  void _selectIndex(int index) => setState(() => {_currentIndex = index});

  Future<void> showEventForm(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          TextEditingController nameController = TextEditingController();
          TextEditingController dateController = TextEditingController();
          TextEditingController timeController = TextEditingController();
          TextEditingController descriptionController = TextEditingController();
          TextEditingController stateController = TextEditingController();
          TextEditingController cityController = TextEditingController();

          return AlertDialog(
              content: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Event Form',
                          style: TextStyle(
                              color: Colors.grey, fontFamily: 'ProductSans'),
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            return value!.isEmpty ? 'Missing field' : null;
                          },
                          decoration:
                              const InputDecoration(hintText: 'Event name'),
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: dateController,
                          decoration:
                              const InputDecoration(hintText: "Event date"),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 10));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);

                              setState(() {
                                dateController.text = formattedDate;
                              });
                            }
                          },
                          validator: (value) {
                            value!.isEmpty ? 'Missing field' : null;
                          },
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: timeController,
                          decoration: const InputDecoration(
                            labelText: 'Event time',
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay time = TimeOfDay.now();
                            TimeOfDay? pickedTime = await showTimePicker(
                                context: context, initialTime: time);

                            if (pickedTime != null) {
                              var formattedHour =
                                  pickedTime.hour.toString().length < 2
                                      ? "0" + pickedTime.hour.toString()
                                      : pickedTime.hour.toString();
                              var formattedMinute =
                                  pickedTime.minute.toString().length < 2
                                      ? "0" + pickedTime.minute.toString()
                                      : pickedTime.minute.toString();

                              setState(() {
                                timeController.text =
                                    formattedHour + ":" + formattedMinute;
                              });
                            }
                          },
                          validator: (value) {
                            value!.isEmpty ? 'Missing field' : null;
                          },
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: descriptionController,
                          validator: (value) {
                            return value!.isEmpty ? 'Missing field' : null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Event description'),
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: stateController,
                          validator: (value) {
                            return value!.isEmpty ? 'Missing field' : null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Location: State'),
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: cityController,
                          validator: (value) {
                            return value!.isEmpty ? 'Missing field' : null;
                          },
                          decoration:
                              const InputDecoration(hintText: 'Location: City'),
                        ),
                      ],
                    ),
                  )),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final auth =
                            Provider.of<AuthProvider>(context, listen: false);
                        auth.user!.uid;
                        DateTime dt = DateTime.parse(dateController.text +
                            " " +
                            timeController.text +
                            ":00");
                        TimeOfDay time = TimeOfDay.now();

                        final Event event = Event(
                            name: nameController.text,
                            description: descriptionController.text,
                            date: dt,
                            address: {
                              "city": cityController.text,
                              "state": stateController.text
                            },
                            ownerUid: auth.user!.uid);

                        eventService.addEvent(event);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Create Event'))
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    String profilePicture = "";

    final auth = Provider.of<AuthProvider>(context);

    if (auth.user != null && auth.user!.photoUrl!.isNotEmpty) {
      profilePicture = auth.user!.photoUrl!;
    }

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
              onPressed: () => _buildUserMenuBottomSheet(context),
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  profilePicture,
                  scale: 0.1,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 4)),
          ],
          leading: IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.menu, color: Colors.black, size: 24),
          ),
        ),
        floatingActionButton: _currentIndex == 0
            ? FloatingActionButton(
                onPressed: () async {
                  await showEventForm(context);
                },
                backgroundColor: Colors.blueAccent,
                child: const Icon(Icons.add),
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
          items: const [
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
          children: [const UserEvents(), ExploreEvents(), Tickets()],
        ));
  }

  void _buildUserMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          final auth = Provider.of<AuthProvider>(context);

          return Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ListTile(
                title: const Text('Log out'),
                onTap: () => {
                  Navigator.pop(context),
                  auth.signOut(),
                },
              ),
              const ListTile(
                title: Text(''),
              ),
              const Divider(
                color: Colors.transparent,
              )
            ],
          );
        });
  }
}
```

### Application

1. `main.dart`. This is the main application class.

```dart

import 'package:design_proposal/modules/core/login.dart';
import 'package:design_proposal/providers/auth_provider.dart';
import 'package:design_proposal/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider())
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Summits',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: auth.status == Status.authenticated ? const Home() : const Login(),
    );
  }
}


```

2. 'generated_plugin_registrant.dart' Generated file by Firebase

```dart

//
// Generated file. Do not edit.
//

// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:mobile_scanner/mobile_scanner_web_plugin.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  FirebaseFirestoreWeb.registerWith(registrar);
  FirebaseAuthWeb.registerWith(registrar);
  FirebaseCoreWeb.registerWith(registrar);
  GoogleSignInPlugin.registerWith(registrar);
  MobileScannerWebPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}


```

3. 'firebase_options.dart' Generated file by FlutterFire CLI.

````dart

// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDsfU8lK3ZWSlW08yaWaeh2tI6-6poctMQ',
    appId: '1:112541665833:web:808b635d39bd375ca9aa38',
    messagingSenderId: '112541665833',
    projectId: 'g-summits',
    authDomain: 'g-summits.firebaseapp.com',
    storageBucket: 'g-summits.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfwTjih7zkIoHGJYnvvDz0Yyo-732bAEs',
    appId: '1:112541665833:android:234437b80fa291a4a9aa38',
    messagingSenderId: '112541665833',
    projectId: 'g-summits',
    storageBucket: 'g-summits.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXQh6Yt1l7NLIT4pVc2WrAaF_qoMjuL9s',
    appId: '1:112541665833:ios:7c6f7e7cdf1531cba9aa38',
    messagingSenderId: '112541665833',
    projectId: 'g-summits',
    storageBucket: 'g-summits.appspot.com',
    iosClientId: '112541665833-hrre32v6s4l99tjb926tmfdh565bofqa.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );
}
````
