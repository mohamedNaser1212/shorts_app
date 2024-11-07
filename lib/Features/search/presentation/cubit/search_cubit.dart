import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../domain/model/search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SearchCubit() : super(SearchState());

  Future<void> searchUsers(String query) async {
    emit(SearchLoading());
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      List<UserEntity> searchResults = snapshot.docs
          .map((doc) {
            final data = doc.data();
            if (data != null) {
              return UserEntity.fromJson(data as Map<String, dynamic>);
            }
            return null; // Return null if data is missing
          })
          .whereType<UserEntity>()
          .toList();

      emit(SearchLoaded(
        searchResults: searchResults,
      ));
    } catch (e) {
      print(e.toString());
      emit(SearchError(errorMessage: e.toString()));
    }
  }
}
