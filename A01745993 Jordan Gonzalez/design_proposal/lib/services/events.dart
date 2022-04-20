import 'dart:async';
import 'package:design_proposal/models/event.dart';
import 'package:design_proposal/services/firebase/firestore_client.dart';
import 'package:design_proposal/services/firebase/firestore_paths.dart';

/**
 * Inspired by: https://github.com/KenAragorn/create_flutter_provider_app
 */

/**
 * TODO: Add documentation
 * 
 */
class EventsService {
  EventsService();

  final _firestoreService = FirestoreClient.instance;

  Future<void> setEvent(Event event) async => await _firestoreService.set(
      path: FirestorePath.events(), document: event.toMap());

  Future<void> deleteEvent(Event event) async =>
      await _firestoreService.delete(path: FirestorePath.event(event.uid));

  Stream<Event> getEventAsStream(String uid) =>
      _firestoreService.documentStream(
          path: FirestorePath.event(uid),
          builder: (data, uid) => Event.fromMap(data, uid));

  Stream<List<Event>> listEventsAsStream() =>
      _firestoreService.collectionStream(
          path: FirestorePath.events(),
          builder: (data, uid) => Event.fromMap(data, uid));
}
