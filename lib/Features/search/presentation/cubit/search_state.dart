part of 'search_cubit.dart';

class SearchState {}

final class GetSearchResultsLoadingState extends SearchState {}

final class GetSearchResultsSuccessState extends SearchState {
  final List<UserEntity> searchResults;

  GetSearchResultsSuccessState({required this.searchResults});
}

final class ClearSearchResultsSuccessState extends SearchState {
  final List<UserEntity> searchResults;

  ClearSearchResultsSuccessState({required this.searchResults});
}

final class GetSearchResultsErrorState extends SearchState {
  final String errorMessage;

  GetSearchResultsErrorState({required this.errorMessage});
}
