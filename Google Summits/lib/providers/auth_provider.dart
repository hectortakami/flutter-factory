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
    _status = Status.authenticating;
    notifyListeners();

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleUser != null && googleAuth != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Once signed in, return the UserCredential
        await _auth.signInWithCredential(credential);
      } else {
        _status = Status.unauthenticated;
        notifyListeners();
      }
    } on FirebaseAuthException catch (error) {
      print(error);
      _status = Status.unauthenticated;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _status = Status.unauthenticated;
    notifyListeners();
  }
}
