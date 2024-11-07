part of 'search_cubit.dart';

class SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<UserEntity> searchResults;

  SearchLoaded({required this.searchResults});
}

final class SearchError extends SearchState {
  final String errorMessage;

  SearchError({required this.errorMessage});
}
