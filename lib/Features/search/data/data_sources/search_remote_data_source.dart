import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../authentication_feature/data/user_model/user_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<UserModel>> search({
    required String query,
    QueryDocumentSnapshot? lastDocument, // For pagination
    int limit = 10, // Default items per page
  });
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<UserModel>> search({
    required String query,
    QueryDocumentSnapshot? lastDocument,
    int limit = 10,
  }) async {
    final lowerCaseQuery = query.toLowerCase();

    Query queryRef = _firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: lowerCaseQuery)
        .where('name', isLessThanOrEqualTo: '$lowerCaseQuery\uf8ff')
        .limit(limit);

    if (lastDocument != null) {
      queryRef = queryRef.startAfterDocument(lastDocument);
    }

    QuerySnapshot snapshot = await queryRef.get();
    List<UserModel> searchResults = snapshot.docs
        .map((doc) {
          final data = doc.data();
          if (data != null) {
            return UserModel.fromJson(data as Map<String, dynamic>);
          }
          return null;
        })
        .whereType<UserModel>()
        .toList();

    return searchResults;
  }
}
