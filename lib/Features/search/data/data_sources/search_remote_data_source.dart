import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/Features/authentication_feature/data/user_model/user_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<UserModel>> search({
    required String query,
  });
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<UserModel>> search({
    required String query,
  }) async {
    final lowerCaseQuery = query.toLowerCase();

    QuerySnapshot snapshot = await _firestore.collection('users').get();

    List<UserModel> searchResults = snapshot.docs
        .map((doc) {
          final data = doc.data();
          if (data != null) {
            final userModel = UserModel.fromJson(data as Map<String, dynamic>);

            if (userModel.name.toLowerCase().contains(lowerCaseQuery)) {
              return userModel;
            }
          }
          return null;
        })
        .whereType<UserModel>()
        .toList();

    return searchResults;
  }
}
