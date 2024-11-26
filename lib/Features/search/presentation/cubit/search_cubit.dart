import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/search/domain/use_case/search_use_case.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchUseCase}) : super(SearchState());

  final SearchUseCase searchUseCase;
  final Map<String, List<UserEntity>> _searchCache = {};
  final Map<String, int> _pageNumbers = {};
  String? _activeQuery;

  static SearchCubit get(context) => BlocProvider.of(context);

  Future<void> searchUsers({
    required String query,
    required int page,
    bool isLoadMore = false,
  }) async {
    _activeQuery = query;

    if (_searchCache.containsKey(query) && !isLoadMore) {
      emit(GetSearchResultsSuccessState(
        searchResults: _searchCache[query]!,
        isLoadMore: isLoadMore,
      ));
      return;
    }

    if (!isLoadMore) emit(GetSearchResultsLoadingState());

    if (_pageNumbers[query] != null && _pageNumbers[query]! >= page) return;

    final searchResults = await searchUseCase.call(search: query, page: page);
    searchResults.fold(
      (failure) {
        emit(GetSearchResultsErrorState(errorMessage: failure.message));
      },
      (newResults) {
        if (_activeQuery != query) return;
        print('search');
        final existingResults = _searchCache[query] ?? [];
        final updatedResults = [...existingResults, ...newResults];

        _searchCache[query] = updatedResults;
        _pageNumbers[query] = page;

        emit(GetSearchResultsSuccessState(
          searchResults: updatedResults,
          isLoadMore: isLoadMore,
        ));
      },
    );
  }

  void clearSearch() {
    _activeQuery = null;
    _searchCache.clear();
    _pageNumbers.clear();
    emit(ClearSearchResultsSuccessState(searchResults: []));
  }

  int getNextPage(String query) {
    return (_pageNumbers[query] ?? 0) + 1;
  }
}
