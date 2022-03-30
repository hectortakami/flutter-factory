class Ticket {
  final String uid;
  final String eventId;
  final String eventName;
  final DateTime date;
  Map<String, dynamic> location;

  Ticket(this.uid, this.eventId, this.eventName, this.date, this.location);
}
