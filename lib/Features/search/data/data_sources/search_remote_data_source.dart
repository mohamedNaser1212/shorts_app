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
    // Convert the query to lowercase for case-insensitive search
    final lowerCaseQuery = query.toLowerCase();

    // Query Firestore to get users
    QuerySnapshot snapshot = await _firestore.collection('users').get();

    // Map Firestore documents to UserModel and filter based on case-insensitive search
    List<UserModel> searchResults = snapshot.docs
        .map((doc) {
          final data = doc.data();
          if (data != null) {
            final userModel = UserModel.fromJson(data as Map<String, dynamic>);
            // Ensure that the name is compared in lowercase for case-insensitive search
            if (userModel.name.toLowerCase().contains(lowerCaseQuery)) {
              return userModel;
            }
          }
          return null; // Return null if data is missing or doesn't match
        })
        .whereType<UserModel>()
        .toList();

    // Return the filtered results
    return searchResults;
  }
}
