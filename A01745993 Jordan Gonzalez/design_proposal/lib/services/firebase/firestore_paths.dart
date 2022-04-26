/// This class represents every possible path in our Cloud Firestore.
class FirestorePath {
  static String event(String uid) => 'events/$uid';
  static String events() => 'events';

  static String ticket(String uid) => 'tickets/$uid';
  static String tickets() => 'tickets';

  static String user(String uid) => 'users/$uid';
  static String users() => 'users';
}
