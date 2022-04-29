// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_proposal/models/event.dart';
import 'package:design_proposal/services/firebase/firestore_client.dart';
import 'package:design_proposal/services/firebase/firestore_paths.dart';

/**
 * Inspired by: https://github.com/KenAragorn/create_flutter_provider_app
 */

/// TODO: Add documentation

class EventsService {
  EventsService();

  final _firestoreService = FirestoreClient.instance;

  Future<void> addEvent(Event event) async => await _firestoreService.add(
      path: FirestorePath.events(), document: event.toMap());

  Future<void> setEvent(Event event) async => await _firestoreService.set(
      path: FirestorePath.event(event.uid!), document: event.toMap());

  Future<void> deleteEvent(Event event) async =>
      await _firestoreService.delete(path: FirestorePath.event(event.uid!));

  Stream<Event> getEventAsStream(String uid) =>
      _firestoreService.documentStream(
          path: FirestorePath.event(uid),
          builder: (data, uid) => Event.fromMap(data, uid));

  Stream<List<Event>> listEventsAsStream() =>
      _firestoreService.collectionStream(
          path: FirestorePath.events(),
          builder: (data, uid) => Event.fromMap(data, uid));

  Stream<List<Event>> listPublicEventsAsStream() {
    Query query = FirebaseFirestore.instance
        .collection(FirestorePath.events())
        .where('isPublic', isEqualTo: true);
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => Event.fromMap(
              snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();
      return result;
    });
  }

  Stream<List<Event>> listUserEventsAsStream(String userUid) {
    Query query = FirebaseFirestore.instance
        .collection(FirestorePath.events())
        .where('ownerUid', isEqualTo: userUid);
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => Event.fromMap(
              snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();
      return result;
    });
  }
}
