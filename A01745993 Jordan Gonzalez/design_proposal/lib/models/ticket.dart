import 'package:design_proposal/models/event.dart';

class Ticket {
  final String uid;
  final String eventUid;
  final String userUid;
  final bool attendance;
  Map<String, dynamic> holder;
  Stream<Event>? event;

  Ticket(
      {required this.uid,
      required this.eventUid,
      required this.userUid,
      required this.holder,
      required this.attendance,
      this.event});

  factory Ticket.fromMap(
      {required Map<String, dynamic> data,
      required String uid,
      Stream<Event>? event}) {
    String eventUid = data['eventUid'];
    String userUid = data['userUid'];
    bool attendance = data['attedance'] == 'true';

    return Ticket(
        uid: uid,
        eventUid: eventUid,
        userUid: userUid,
        holder: data['holder'],
        attendance: attendance,
        event: event);
  }

  Map<String, dynamic> toMap() {
    return {
      'eventUid': eventUid,
      'userUid': userUid,
      'holder': holder,
      'attendance': attendance,
    };
  }
}
