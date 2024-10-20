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
