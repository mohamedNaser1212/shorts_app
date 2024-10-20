part of 'toggle_favourites_cubit_cubit.dart';

class ToggleFavouritesState {}

class ToggleFavoriteErrorState extends ToggleFavouritesState {
  final String message;
  ToggleFavoriteErrorState({
    required this.message,
  });
}

class ToggleFavouriteSuccessState extends ToggleFavouritesState {
  final bool isFavourite;
  ToggleFavouriteSuccessState({
    required this.isFavourite,
  });
}

class ToggleFavoritesLoadingState extends ToggleFavouritesState {}
