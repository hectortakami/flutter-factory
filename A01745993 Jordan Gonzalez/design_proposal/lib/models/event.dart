import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String? uid;
  final String name;
  final String description;
  final DateTime date;
  Map<String, dynamic> address;
  final String ownerUid;

  Event(
      {this.uid,
      required this.name,
      required this.description,
      required this.date,
      required this.address,
      required this.ownerUid});

  factory Event.fromMap(Map<String, dynamic> data, String uid) {
    String name = data['name'];
    String description = data['description'];
    DateTime date = data['date'].toDate();
    String ownerUid = data['ownerUid'];

    return Event(
        uid: uid,
        name: name,
        description: description,
        date: date,
        address: data['address'],
        ownerUid: ownerUid);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'address': address,
      'date': Timestamp.fromDate(date),
      'ownerUid': ownerUid
    };
  }
}
