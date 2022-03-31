import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * Inspired by: https://github.com/KenAragorn/create_flutter_provider_app
 */

/**
 * This class represents every possible CRUD operations for Cloud Firestore.
 * Represented as generic implementations for the document-based database.
 */
class FirestoreClient {
  FirestoreClient._();
  static final instance = FirestoreClient._();

  /**
   * Add a document to a collection given its path.
   */
  Future<void> set({
    required String path,
    required Map<String, dynamic> document,
    bool merge = false,
  }) async {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    await reference.set(document);
  }

  /**
   * Add multiple documents to a collection given its path.
   * TODO: Implement
   */
  Future<void> bulkSet({
    required String path,
    required List<Map<String, dynamic>> documents,
    bool merge = false,
  }) async {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final batchSet = FirebaseFirestore.instance.batch();

//    for()
//    batchSet.
  }

  /**
   * Remove a document from a collection given its path.
   */
  Future<void> delete({required String path}) async {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }

  /**
   * Retrieve every document in a collection.
   */
  Stream<List<T>> collectionStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentID),
    Query queryBuilder(Query query)?,
    int sort(T lhs, T rhs)?,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  /**
   * Retrieve a document from a collection.
   */
  Stream<T> documentStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        builder(snapshot.data() as Map<String, dynamic>, snapshot.id));
  }
}
