import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/favourites_feature/domain/favourite_entitiy.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_use_case/favourites_use_case.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit({
    required this.favouritesUseCase,
  }) : super(FavouritesState());
  final FavouritesUseCase favouritesUseCase;

  static FavouritesCubit get(context) => BlocProvider.of(context);

  Map<String, bool> favorites = {};
  List<FavouritesEntity> getFavouritesModel = [];

  Future<void> getFavourites({
    required UserEntity user,
  }) async {
    emit(GetFavoritesLoadingState());
    final result = await favouritesUseCase.getFavouriteVideos(
      user: user,
    );
    result.fold(
      (failure) {
        print('Failed to fetch favourites: $failure');
        emit(GetFavoritesErrorState(message: failure.message));
      },
      (favourites) {
        getFavouritesModel = favourites;
        favorites = {for (var p in favourites) p.id!: true};
        emit(GetFavoritesSuccessState(getFavouritesModel: getFavouritesModel));
      },
    );
  }

  Future<void> toggleFavourite({
    required String videoId,
    required UserEntity userModel,
  }) async {
    emit(ToggleFavoritesLoadingState());
    favorites[videoId] = !(favorites[videoId] ?? false);

    emit(ToggleFavouriteSuccessState(isFavourite: favorites[videoId] ?? false));

    final result = await favouritesUseCase.toggleFavouriteVideo(
      videoId: videoId,
      userModel: userModel,
    );
    result.fold(
      (failure) {
        print('Failed to toggle favourite: ${failure.message}');
        emit(ToggleFavoriteErrorState(message: failure.message));
      },
      (favourites) async {
        emit(ToggleFavouriteSuccessState(isFavourite: favourites));
      },
    );
  }
}
