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
