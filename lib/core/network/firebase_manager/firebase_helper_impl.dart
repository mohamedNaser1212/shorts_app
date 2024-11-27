import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';

class FirebaseHelperImpl extends FirebaseHelper {
  @override
  Future<List<Map<String, dynamic>>> getCollectionDocuments({
    required String collectionPath,
    String? docId,
    String? subCollectionPath,
    String? whereField,
    dynamic whereValue,
    int? limit,
    String? orderBy,
    bool descending = false,
    DocumentSnapshot? startAfter, // Add startAfter parameter
  }) async {
    CollectionReference collection = firestore.collection(collectionPath);

    if (docId != null && subCollectionPath != null) {
      collection = collection.doc(docId).collection(subCollectionPath);
    }

    Query query = collection;

    if (whereField != null && whereValue != null) {
      query = query.where(whereField, isEqualTo: whereValue);
    }

    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    if (startAfter != null) {
      query = query.startAfterDocument(
          startAfter); // Use startAfterDocument for pagination
    }

    final querySnapshot = await query.get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Future<void> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? docId,
    String? subCollectionPath,
    String? subDocId,
  }) async {
    CollectionReference collection = firestore.collection(collectionPath);

    if (docId != null && subCollectionPath != null) {
      collection = collection.doc(docId).collection(subCollectionPath);
    }

    if (docId != null) {
      if (subDocId != null) {
        await collection.doc(subDocId).set(data);
      } else {
        await collection.doc(docId).set(data);
      }
    } else {
      await collection.add(data);
    }
  }

  @override
  Future<void> updateDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
    String? subCollectionPath,
    String? subDocId,
  }) async {
    DocumentReference document =
        firestore.collection(collectionPath).doc(docId);

    if (subCollectionPath != null) {
      document = document.collection(subCollectionPath).doc(subDocId);
    }

    await document.update(data);
  }

  @override
  Future<void> deleteDocument({
    required String collectionPath,
    required String docId,
    String? subCollectionPath,
    String? subDocId,
  }) async {
    DocumentReference document =
        firestore.collection(collectionPath).doc(docId);

    if (subCollectionPath != null) {
      document = document.collection(subCollectionPath).doc(subDocId);
    }

    await document.delete();
  }

  @override
  Future<Map<String, dynamic>?> getDocument({
    required String collectionPath,
    required String docId,
    String? subCollectionPath,
    String? subDocId,
  }) async {
    DocumentReference document =
        firestore.collection(collectionPath).doc(docId);

    if (subCollectionPath != null && subDocId != null) {
      document = document.collection(subCollectionPath).doc(subDocId);
    }

    final documentSnapshot = await document.get();

    return documentSnapshot.exists
        ? documentSnapshot.data() as Map<String, dynamic>?
        : null;
  }

  @override
  Future<DocumentSnapshot<Object?>> getDocumentDocumentSnapShot({
    required String collectionPath,
    required String docId,
    String? subCollectionPath,
    String? subDocId,
  }) async {
    DocumentSnapshot document =
        await firestore.collection(collectionPath).doc(docId).get();

    return document;
  }

  @override
  Future<String> generateDocumentId({required String collectionPath}) async {
    return firestore.collection(collectionPath).doc().id;
  }

  @override
  Future<void> addDocumentWithAutoId({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? docId,
    String? subCollectionPath,
  }) async {
    CollectionReference collection = firestore.collection(collectionPath);

    if (docId != null && subCollectionPath != null) {
      collection = collection.doc(docId).collection(subCollectionPath);
    }

    await collection.add(data);
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getCollectionQuerySnapshot({
    required String collectionPath,
    String? docId,
    String? subCollectionPath,
    String? whereField,
    dynamic whereValue,
    int? limit,
    String? orderBy,
    bool descending = false,
    DocumentSnapshot? startAfter,
  }) async {
    CollectionReference<Map<String, dynamic>> collection =
        firestore.collection(collectionPath);

    if (docId != null && subCollectionPath != null) {
      collection = collection.doc(docId).collection(subCollectionPath)
          as CollectionReference<Map<String, dynamic>>;
    }

    Query<Map<String, dynamic>> query = collection;

    if (whereField != null && whereValue != null) {
      query = query.where(whereField, isEqualTo: whereValue);
    }

    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter); // Handle pagination
    }

    return await query.get();
  }
}
