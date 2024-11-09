import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/search/domain/use_case/search_use_case.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SearchCubit({
    required this.searchUseCase,
  }) : super(SearchState());
  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);
  final SearchUseCase searchUseCase;

  Future<void> searchUsers({
    required String query,
  }) async {
    emit(SearchLoading());

    final searchResults = await searchUseCase.call(search: query);
    searchResults.fold(
      (failure) => emit(SearchError(errorMessage: failure.message)),
      (searchResults) => emit(SearchLoaded(searchResults: searchResults)),
    );
    // try {
    //   QuerySnapshot snapshot = await _firestore
    //       .collection('users')
    //       .where('name', isGreaterThanOrEqualTo: query)
    //       .where('name', isLessThanOrEqualTo: query + '\uf8ff')
    //       .get();
    //
    //   List<UserEntity> searchResults = snapshot.docs
    //       .map((doc) {
    //         final data = doc.data();
    //         if (data != null) {
    //           return UserEntity.fromJson(data as Map<String, dynamic>);
    //         }
    //         return null; // Return null if data is missing
    //       })
    //       .whereType<UserEntity>()
    //       .toList();
    //
    //   emit(SearchLoaded(
    //     searchResults: searchResults,
    //   ));
    // } catch (e) {
    //   print(e.toString());
    //   emit(SearchError(errorMessage: e.toString()));
    // }
  }
}
