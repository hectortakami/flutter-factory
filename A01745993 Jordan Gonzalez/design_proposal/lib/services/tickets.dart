// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_proposal/models/event.dart';
import 'package:design_proposal/models/ticket.dart';
import 'package:design_proposal/services/events.dart';
import 'package:design_proposal/services/firebase/firestore_client.dart';
import 'package:design_proposal/services/firebase/firestore_paths.dart';

/**
 * Inspired by: https://github.com/KenAragorn/create_flutter_provider_app
 */

/// TODO: Add documentation

class TicketsService {
  TicketsService();

  final _firestoreService = FirestoreClient.instance;

  Future<void> setTicket(Ticket ticket) async => await _firestoreService.set(
      path: FirestorePath.tickets(), document: ticket.toMap());

  Future<void> deleteTicket(Ticket ticket) async =>
      await _firestoreService.delete(path: FirestorePath.ticket(ticket.uid));

  Stream<Ticket> getTicketAsStream(String uid) =>
      _firestoreService.documentStream(
          path: FirestorePath.ticket(uid),
          builder: (data, uid) => Ticket.fromMap(data: data, uid: uid));

  Stream<List<Ticket>> listTicketsAsStream() =>
      _firestoreService.collectionStream(
          path: FirestorePath.tickets(),
          builder: (data, uid) => Ticket.fromMap(data: data, uid: uid));

  Stream<List<Ticket>> listUserTicketsAsStream(String userUid) {
    Query ticketsQuery = FirebaseFirestore.instance
        .collection(FirestorePath.tickets())
        .where('userUid', isEqualTo: userUid);
    final Stream<QuerySnapshot> snapshots = ticketsQuery.snapshots();

    final EventsService eventsService = EventsService();

    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) {
            Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
            Stream<Event> event =
                eventsService.getEventAsStream(data['eventUid']);
            return Ticket.fromMap(data: data, uid: snapshot.id, event: event);
          })
          .where((value) => value != null)
          .toList();
      return result;
    });
  }

  Stream<List<Ticket>> listEventTicketsAsStream(String eventUid) {
    Query ticketsQuery = FirebaseFirestore.instance
        .collection(FirestorePath.tickets())
        .where('eventUid', isEqualTo: eventUid);
    final Stream<QuerySnapshot> snapshots = ticketsQuery.snapshots();

    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) {
            Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
            return Ticket.fromMap(data: data, uid: snapshot.id);
          })
          .where((value) => value != null)
          .toList();
      return result;
    });
  }
}
