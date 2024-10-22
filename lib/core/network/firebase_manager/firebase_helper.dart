import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseHelper {
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
    String? docId,
    String? subCollectionPath,
    String? subDocId,
  });

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

  Future<String> generateDocumentId({required String collectionPath});

  // New method to add a document with an auto-generated ID
  Future<void> addDocumentWithAutoId({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? docId,
    String? subCollectionPath,
  });
}
