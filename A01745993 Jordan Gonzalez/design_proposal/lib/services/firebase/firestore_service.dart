import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_proposal/models/event.dart';
import 'package:design_proposal/services/firebase/firestore_client.dart';
import 'package:design_proposal/services/firebase/firestore_paths.dart';

/**
 * Inspired by: https://github.com/KenAragorn/create_flutter_provider_app
 */

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

/*
This is the main class access/call for any UI widgets that require to perform
any CRUD activities operation in FirebaseFirestore database.
This class work hand-in-hand with FirestoreService and FirestorePath.

Notes:
For cases where you need to have a special method such as bulk update specifically
on a field, then is ok to use custom code and write it here. For example,
setAllTodoComplete is require to change all todos item to have the complete status
changed to true.

 */

/**
 * TODO: Add documentation
 * 
 */
class FirestoreService {
  FirestoreService();

  final _firestoreService = FirestoreClient.instance;

  Future<void> setEvent(Event event) async => await _firestoreService.set(
      path: FirestorePath.events(), document: event.toMap());

  Stream<Event> getEvent(String uid) => _firestoreService.documentStream(
      path: FirestorePath.event(uid),
      builder: (data, uid) => Event.fromMap(data, uid));

  /** TODO: Everything, listed below are examples */

  //Method to create/update todoModel
  Future<void> setTodo(TodoModel todo) async => await _firestoreService.set(
        path: FirestorePath.todo(uid, todo.id),
        data: todo.toMap(),
      );

  //Method to delete todoModel entry
  Future<void> deleteTodo(TodoModel todo) async {
    await _firestoreService.deleteData(path: FirestorePath.todo(uid, todo.id));
  }

  //Method to retrieve todoModel object based on the given todoId
  Stream<TodoModel> todoStream({required String todoId}) =>
      _firestoreService.documentStream(
        path: FirestorePath.todo(uid, todoId),
        builder: (data, documentId) => TodoModel.fromMap(data, documentId),
      );

  //Method to retrieve all todos item from the same user based on uid
  Stream<List<TodoModel>> todosStream() => _firestoreService.collectionStream(
        path: FirestorePath.todos(uid),
        builder: (data, documentId) => TodoModel.fromMap(data, documentId),
      );

  //Method to mark all todoModel to be complete
  Future<void> setAllTodoComplete() async {
    final batchUpdate = FirebaseFirestore.instance.batch();

    final querySnapshot = await FirebaseFirestore.instance
        .collection(FirestorePath.todos(uid))
        .get();

    for (DocumentSnapshot ds in querySnapshot.docs) {
      batchUpdate.update(ds.reference, {'complete': true});
    }
    await batchUpdate.commit();
  }

  Future<void> deleteAllTodoWithComplete() async {
    final batchDelete = FirebaseFirestore.instance.batch();

    final querySnapshot = await FirebaseFirestore.instance
        .collection(FirestorePath.todos(uid))
        .where('complete', isEqualTo: true)
        .get();

    for (DocumentSnapshot ds in querySnapshot.docs) {
      batchDelete.delete(ds.reference);
    }
    await batchDelete.commit();
  }
}
