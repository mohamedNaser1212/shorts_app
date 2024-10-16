import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseHelperManager {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getCollectionDocuments({
 required String collectionPath,
  String? docId,
  String? subCollectionPath,
  String? whereField,
  dynamic whereValue,
  int? limit,
  String? orderBy,
  bool descending = false,
  });

  Future<void> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? docId, // Ensure docId is used
    String? subCollectionPath,
    String? subDocId,
  });

  // Method to update a document
  Future<void> updateDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
    String? subCollectionPath,
    String? subDocId,
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
  String? whereField,
  dynamic whereValue,
  int? limit,
  String? orderBy,
  bool descending = false,
}) async {
  CollectionReference collection = firestore.collection(collectionPath);

  // Accessing the sub-collection if provided
  if (docId != null && subCollectionPath != null) {
    collection = collection.doc(docId).collection(subCollectionPath);
  }

  Query query = collection;

  // Applying the 'where' clause if specified
  if (whereField != null && whereValue != null) {
    query = query.where(whereField, isEqualTo: whereValue);
  }

  // Applying ordering if specified
  if (orderBy != null) {
    query = query.orderBy(orderBy, descending: descending);
  }

  // Applying limit if specified
  if (limit != null) {
    query = query.limit(limit);
  }

  final querySnapshot = await query.get();
  
  // Returning the documents data as a list of maps
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
  String? subDocId,
}) async {
  CollectionReference collection = firestore.collection(collectionPath);

  // Handle sub-collection if docId and subCollectionPath are provided
  if (docId != null && subCollectionPath != null) {
    collection = collection.doc(docId).collection(subCollectionPath);
  }

  if (docId != null) {
    // If subDocId is provided, set the document with that ID in the sub-collection
    if (subDocId != null) {
      await collection.doc(subDocId).set(data);
    } else {
      // Use set() with docId to add the document with a specific ID
      await collection.doc(docId).set(data);
    }
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
