# Google Summits

This app is a prototype where we are intregating the efforts of both teams, the one in charge of creating the UI and the QR code functionality and the Firebase team.

## Features 

This project currently holds the following features:

### Events
- [x] Create event.
- [x] Update event.
- [ ] Delete event.
- [x] List every public event in the Explore tab.
- [ ] Paginate public events in the Explore tab.
- [x] List events owned per user.
- [ ] Paginate events owned per user.
### Tickets
- [x] Add tickets to an event.
- [ ] Remove ticket from event.
- [x] List tickets hold per user.
- [ ] Paginate tickets hold per user.
### Scan
- [x] Show assistants to organizer per event.
- [ ] Paginate assistants per event.
- [x] Scan ticket and update its participation.

## Pre-requisites

---

1. Install [Flutter](https://docs.flutter.dev/get-started/install).
2. [Set up](https://docs.flutter.dev/get-started/editor) an editor.
3. Run the following command and ensure everything in the output is checked.

```zsh
flutter doctor
```

### iOS

If developing for iOS, assuming you own a device with macOS, ensure to have the following:

1. [Xcode](https://developer.apple.com/xcode/) installed.
2. An Apple account set up with Xcode to sign apps.
3. Simulator app with at least one device with iOS 11+.

### Android

Android Studio already provides an emulator, ensure to have one with a minimum sdk version of 21.

## Project structure

---

```
.
├── lib
│   ├── main.dart
│   │
│   ├── models
│   │   ├── event.dart
│   │   |── ticket.dart
|   |   └── user.dart
│   │
│   ├── modules
│   │   ├── events
│   │   │   ├── screens
│   │   │   │   ├── explore.dart
│   │   │   │   ├── form.dart
│   │   │   │   ├── single.dart
│   │   │   │   └── user_events.dart
│   │   │   └── widgets
│   │   │       ├── assistant_tile.dart
│   │   │       └── event_card.dart
│   │   │
│   │   ├── qr_scanner
│   │   │   └── screens
│   │   │       └── qr_scanner.dart
│   │   │
|   |   ├── core
│   │   │   ├── widgets
│   │   │   │   └── text_form_field.dart
│   │   │   └── login.dart
|   |   |
│   │   └── tickets
│   │       ├── screens
│   │       │   ├── all.dart
│   │       │   └── form.dart
│   │       └── widgets
│   │           ├── ticket_card.dart
│   │           └── ticker_qr.dart
│   │
│   |── screens
│   │   ├── home.dart
│   |   └── loading.dart
│   │
│   |── providers
│   |   └── auth_provider.dart
│   │
│   └── services
│       |── firebase
|       |    |── firestore_client.dart
|       |    └── firestore_paths.dart
│       ├── events.dart
|       └── tickets.dart
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

## Project files

### Models

Definitions for every structured element used in the app, only its fields are shown.

1. `event.dart`

```dart
class Event {
  final String? uid;
  final String name;
  final String description;
  final DateTime date;
  Map<String, dynamic> address;
  final String ownerUid;
  final bool? isPublic;

  ...
```

2. `ticket.dart`

```dart
class Ticket {
  final String? uid;
  final String eventUid;
  final String userUid;
  final bool attendance;
  Map<String, dynamic> holder;
  Stream<Event>? event;

  ...
```

3. `user.dart`

```dart
class User {
  String uid;
  String? email;
  String? displayName;
  String? phoneNumber;
  String? photoUrl;

  ...
```

### Modules

#### Core

1. `login.dart` - Login page showing the logo and a single 'Sign-in with Google' button.

- `widgets`

  1. `text_form_field.dart` - Custom `TextFormField` element widely used within the forms of our app.

#### Events

- `screens`

  1. `explore.dart` - Community public events are displayed here.
  2. `form.dart` - Form to create/update/delete events.
  3. `single.dart` - Creation of the event.
  4. `user_events.dart` - Current user owned events.

- `widgets`

  1. `assistant_tile.dart` - Tile that displays whether a user has entered an event, used mainly in a single event.
  2. `event_card.dart` - Card which displays summarized information about an event, commonly used while listing events.

#### Qr_scanner

- `screens`

  1. `qr_scanner.dart` - Scanner for ticket QRs.

#### Tickets

- `screens`

  1. `all.dart` - Every ticket owned by the user.

- `widgets`

  1. `ticket_card.dart` - Card which shows summarized information about a ticket.
  2. `ticket_qr.dart` - Dialog showing the ticket QR, the event, and holder information.

### Providers

1. `auth_provider.dart` - Authentication provider to get the user in any branch of the tree.

### Services

Every service file is supported by the firestore client, which is an abstract implementation of the CRUD operations.

1. `events.dart` - Events service with some CRUD operations.
2. `tickets.dart` - Tickets service with some CRUD operations.

- `firebase`

  1. `firestore_client.dart` - Client to use the firestore database inside the flutter application.
  2. `firestore_paths.dart` - Paths inside the firestore database to store the users, events and tickets.

### Screens

1. `home.dart` - Home screen, where the main `NavigationBar` is set, as well as the stack.

### Application

1. `main.dart` - Main application class.
2. `generated_plugin_registrant.dart` - Generated file by Firebase
3. `firebase_options.dart` - Generated file by FlutterFire CLI.

### Extra Resources

- [Flutter 101](https://www.youtube.com/watch?v=nlTBwNqvVn8).
- [Starting with flutter](https://www.youtube.com/watch?v=mTErlB_wT6A&list=PLCKuOXG0bPi1_ZY2c9LU7MvvtWk82x1wB).
- [Udemy Course](https://www.udemy.com/course/flutter-ios-android-fernando-herrera/).
- [Widget of the day](https://www.youtube.com/watch?v=1OPDUhgrI24&list=PLCKuOXG0bPi2GD3Bq55ysZfQJz2k-LiEz).
- [Firebase](https://firebase.flutter.dev/docs/overview/).
- [Cloudinary(Image REST API)](https://cloudinary.com/documentation/image_upload_api_reference).

