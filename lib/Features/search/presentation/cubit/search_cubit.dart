import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/search/domain/use_case/search_use_case.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required this.searchUseCase,
  }) : super(SearchState());

  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);

  final SearchUseCase searchUseCase;

  final Map<String, List<UserEntity>> _searchCache = {};

  Future<void> searchUsers({
    required String query,
  }) async {
    emit(GetSearchResultsLoadingState());

    if (_searchCache.containsKey(query)) {
      emit(GetSearchResultsSuccessState(searchResults: _searchCache[query]!));
      return;
    }

    final searchResults = await searchUseCase.call(search: query);
    searchResults.fold(
      (failure) =>
          emit(GetSearchResultsErrorState(errorMessage: failure.message)),
      (searchResults) {
        // Cache the results
        _searchCache[query] = searchResults;
        emit(GetSearchResultsSuccessState(searchResults: searchResults));
      },
    );
  }

  void clearSearch() {
    emit(ClearSearchResultsSuccessState(searchResults: []));
  }
}
