import 'package:design_proposal/models/user.dart' as GS;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
}

class AuthProvider extends ChangeNotifier {
  late FirebaseAuth _auth;

  Status _status = Status.Uninitialized;

  Status get status => _status;

  Stream<GS.User> get user => _auth.authStateChanges().map(_userFromFirebase);

  AuthProvider() {
    _auth = FirebaseAuth.instance;

    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  Future<void> onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _userFromFirebase(firebaseUser);
      _status = Status.Authenticated;
    }
  }

  GS.User _userFromFirebase(User? firebaseUser) {
    if (firebaseUser == null) {
      return GS.User(uid: 'null', displayName: 'null');
    }
    return GS.User.fromFirebase(firebaseUser);
  }

  Future<void> signInWithGoogle() async {
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
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
  }
}
