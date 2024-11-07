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
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    List<UserModel> searchResults = snapshot.docs
        .map((doc) {
          final data = doc.data();
          if (data != null) {
            return UserModel.fromJson(data as Map<String, dynamic>);
          }
          return null; // Return null if data is missing
        })
        .whereType<UserModel>()
        .toList();

    return searchResults;
  }
}
