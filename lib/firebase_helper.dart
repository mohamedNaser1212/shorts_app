import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseHelperManager {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getCollectionDocuments({
    required String collectionPath,
    String? docId,
    String? subCollectionPath,
    int? limit,
    String? orderBy,
    bool descending = false,
  });

  Future<void> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? docId, // Ensure docId is used
    String? subCollectionPath,
  });

  // Method to update a document
  Future<void> updateDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
    String? subCollectionPath,
  });

  Future<void> deleteDocument({
    required String collectionPath,
    required String docId,
    String? subCollectionPath,
    String? subDocId,
  });

  Future<Map<String, dynamic>?> getDocument({
    required String collectionPath,
    required String docId,
  });
}

class FirebaseHelperManagerImpl extends FirebaseHelperManager {
  @override
  Future<List<Map<String, dynamic>>> getCollectionDocuments({
    required String collectionPath,
    String? docId,
    String? subCollectionPath,
    int? limit,
    String? orderBy,
    bool descending = false,
  }) async {
    CollectionReference collection = firestore.collection(collectionPath);

    if (docId != null && subCollectionPath != null) {
      collection = collection.doc(docId).collection(subCollectionPath);
    }

    Query query = collection;
    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }
    if (limit != null) {
      query = query.limit(limit);
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
    String? docId, // Ensure docId is used
    String? subCollectionPath,
  }) async {
    CollectionReference collection = firestore.collection(collectionPath);

    // Handle sub-collection
    if (docId != null && subCollectionPath != null) {
      collection = collection.doc(docId).collection(subCollectionPath);
    }

    if (docId != null) {
      // Use set() with docId to add the document with a specific ID
      await collection.doc(docId).set(data);
    } else {
      // Otherwise, add a document with a random ID
      await collection.add(data);
    }
  }

  @override
  Future<void> updateDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
    String? subCollectionPath,
  }) async {
    DocumentReference document =
        firestore.collection(collectionPath).doc(docId);

    if (subCollectionPath != null) {
      document = document.collection(subCollectionPath).doc();
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
      document = document.collection(subCollectionPath).doc(
            subDocId,
          );
    }

    await document.delete();
  }

  @override
  Future<Map<String, dynamic>?> getDocument({
    required String collectionPath,
    required String docId,
  }) async {
    final documentSnapshot =
        await firestore.collection(collectionPath).doc(docId).get();
    return documentSnapshot.data() as Map<String, dynamic>?;
  }
}
