part of 'favourites_cubit.dart';

class FavouritesState {}

class GetFavoritesErrorState extends FavouritesState {
  final String message;
  GetFavoritesErrorState({
    required this.message,
  });
}

class GetFavoritesSuccessState extends FavouritesState {
  final List<FavouritesEntity> getFavouritesModel;
  GetFavoritesSuccessState({
    required this.getFavouritesModel,
  });
}

class GetFavoritesLoadingState extends FavouritesState {}

class GetFavoritesCountErrorState extends FavouritesState {
  final String message;
  GetFavoritesCountErrorState({
    required this.message,
  });
}

class GetFavoritesCountSuccessState extends FavouritesState {
  final num favCount;
  GetFavoritesCountSuccessState({
    required this.favCount,
  });
}

class GetFavoritesCountLoadingState extends FavouritesState {}
