import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';

class FirebaseManagerImpl implements FirebaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<Map<String, dynamic>> getDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      final doc =
          await _firestore.collection(collectionPath).doc(documentId).get();
      if (doc.exists) {
        return doc.data()!;
      } else {
        throw Exception('Document not found');
      }
    } catch (e) {
      print('Error fetching document: $e');
      throw Exception('Failed to fetch document');
    }
  }

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
  Future<DocumentReference> post({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      if (documentId != null) {
        final docRef = _firestore.collection(collectionPath).doc(documentId);
        await docRef.set(data);
        return docRef;
      } else {
        final docRef = _firestore.collection(collectionPath).doc();
        await docRef.set(data);
        return docRef;
      }
    } catch (e) {
      print('Error posting data: $e');
      throw Exception('Failed to post data');
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

  @override
  Future<String> uploadToStorage({
    required String videoPath,
    required String videoId,
    required String collectionName,
  }) async {
    try {
      final videoRef = _storage.ref().child(collectionName).child(videoId);
      final uploadTask = videoRef.putFile(File(videoPath));
      final snapshot = await uploadTask.whenComplete(() => null);
      final videoUrl = await snapshot.ref.getDownloadURL();
      return videoUrl;
    } catch (e) {
      print('Error uploading video: $e');
      throw Exception('Failed to upload video');
    }
  }

  @override
  Future<Map<String, dynamic>> getUserById({
    required String userId,
  }) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return doc.data()!;
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      print('Error fetching user: $e');
      throw Exception('Failed to fetch user');
    }
  }
}
