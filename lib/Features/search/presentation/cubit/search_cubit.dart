import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/model/search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SearchCubit() : super(SearchState());

  Future<void> searchVideos(String query) async {
    emit(SearchLoading());
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('videos')
          .where('description', isGreaterThanOrEqualTo: query)
          .get();

      // Map the snapshot to a list of SearchModel
      List<SearchModel> searchResults = snapshot.docs.map((doc) {
        return SearchModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      emit(SearchLoaded(
        searchResults: searchResults,
      ));
    } catch (e) {
      emit(SearchError(errorMessage: e.toString()));
    }
  }
}
