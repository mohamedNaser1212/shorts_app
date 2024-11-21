import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';

abstract class SearchRemoteDataSource {
  Future<List<UserEntity>> search({
    required String query,
    required int page,
  });
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DocumentSnapshot? lastDocument;

  @override
  Future<List<UserEntity>> search({
    required String query,
    required int page,
  }) async {
    final lowerCaseQuery = query.toLowerCase();

    Query queryBuilder = _firestore
        .collection('users')
        .orderBy('name', descending: true)
        .limit(14);

    if (page > 1 && lastDocument != null) {
      queryBuilder = queryBuilder.startAfterDocument(lastDocument!);
    }

    QuerySnapshot snapshot = await queryBuilder.get();

    if (snapshot.docs.isEmpty) {
      return [];
    }

    List<UserEntity> searchResults = snapshot.docs
        .map((doc) {
          final data = doc.data();
          if (data != null) {
            final userModel = UserEntity.fromJson(data as Map<String, dynamic>);

            if (userModel.name.toLowerCase().contains(lowerCaseQuery)) {
              return userModel;
            }
          }
          return null;
        })
        .whereType<UserEntity>()
        .toList();

    if (searchResults.isNotEmpty) {
      lastDocument = snapshot.docs.last;
    }

    print('Search results for page $page: ${searchResults.length}');

    return searchResults;
  }
}
