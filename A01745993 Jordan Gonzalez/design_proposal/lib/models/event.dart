import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String uid;
  final String name;
  final String description;
  final DateTime date;
  Map<String, dynamic> address;
  final String ownerUid;
  List<Map<String, dynamic>> participants;

  Event(
      {required this.uid,
      required this.name,
      required this.description,
      required this.date,
      required this.address,
      required this.ownerUid,
      required this.participants});

  factory Event.fromMap(Map<String, dynamic> data, String uid) {
    String name = data['name'];
    String description = data['description'];
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(int.parse(data['date']));
    String ownerUid = data['ownerUid'];
    List<Map<String, dynamic>> participants = [];

    return Event(
        uid: uid,
        name: name,
        description: description,
        date: date,
        address: data['address'],
        ownerUid: ownerUid,
        participants: participants);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'address': address,
      'date': Timestamp.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch)
          .toString(),
      'ownerUid': ownerUid
    };
  }
}
