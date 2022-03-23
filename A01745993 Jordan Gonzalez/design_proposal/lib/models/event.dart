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
