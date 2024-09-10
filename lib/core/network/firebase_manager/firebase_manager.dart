import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';

class FirebaseManagerImpl implements FirebaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> get({
    required String collectionPath,
  }) async {
    try {
      final snapshot = await _firestore.collection(collectionPath).get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  @override
  Future<void> post({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      if (documentId != null) {
        await _firestore.collection(collectionPath).doc(documentId).set(data);
      } else {
        await _firestore.collection(collectionPath).add(data);
      }
    } catch (e) {
      print('Error posting data: $e');
    }
  }

  @override
  Future<void> update({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).update(data);
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  @override
  Future<void> delete({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
    } catch (e) {
      print('Error deleting data: $e');
    }
  }
}
