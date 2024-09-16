import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_use_case/favourites_use_case.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit({
    required this.favouritesUseCase,
  }) : super(FavouritesState());
  final FavouritesUseCase favouritesUseCase;

  static FavouritesCubit get(context) => BlocProvider.of(context);

  Map<String, bool> favorites = {};
  List<VideoEntity> getFavouritesModel = [];

  Future<void> getFavourites() async {
    emit(GetFavoritesLoadingState());
    final result = await favouritesUseCase.getFavouriteVideos();
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

  Future<void> toggleFavourite(String videoId) async {
    emit(ToggleFavoritesLoadingState());
    favorites[videoId] = !(favorites[videoId] ?? false);
    emit(ToggleFavouriteSuccessState(isFavourite: favorites[videoId] ?? false));

    final result = await favouritesUseCase.toggleFavouriteVideo(
      videoId: videoId,
    );
    result.fold(
      (failure) {
        print('Failed to toggle favourite: ${failure.message}');
        emit(ToggleFavoriteErrorState(message: failure.message));
      },
      (favourites) async {
        await getFavourites();
        emit(ToggleFavouriteSuccessState(isFavourite: favourites));
      },
    );
  }
}
