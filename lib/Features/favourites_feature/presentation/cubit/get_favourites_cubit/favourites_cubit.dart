import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_entity/favourite_entitiy.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_use_case/get_favourites_use_case.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../../domain/favourites_use_case/get_favourites_count_use_case.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit({
    required this.favouritesUseCase,
    required this.getFavouritesCountUseCase,
  }) : super(FavouritesState());

  static FavouritesCubit get(context) => BlocProvider.of(context);

  final GetFavouritesUseCase favouritesUseCase;
  final GetFavouritesCountUseCase getFavouritesCountUseCase;

  final Map<String, bool> favorites = {};
  List<FavouritesEntity> getFavouritesModel = [];
  final Map<String, num> favouritesCount = {};

  // StreamController to broadcast favorites count updates
  final _favouritesCountController =
      StreamController<Map<String, num>>.broadcast();

  // Expose the stream to listen for favorites count updates
  Stream<Map<String, num>> get favouritesCountStream =>
      _favouritesCountController.stream;

  @override
  Future<void> close() {
    _favouritesCountController.close();
    return super.close();
  }

  // Method to get favorites for a user
  Future<void> getFavourites({
    required UserEntity user,
  }) async {
    emit(GetFavoritesLoadingState());

    final result = await favouritesUseCase.getFavouriteVideos(user: user);

    result.fold(
      (failure) {
        print('Failed to fetch favourites: $failure');
        emit(GetFavoritesErrorState(message: failure.message));
      },
      (favourites) {
        getFavouritesModel = favourites;
        favorites.clear();
        favorites.addAll({for (var p in favourites) p.id!: true});

        // Emit the updated favorites count to the stream
        _favouritesCountController.add(favouritesCount);

        emit(GetFavoritesSuccessState(getFavouritesModel: getFavouritesModel));
      },
    );
  }

  // Method to update the favorites count in the stream after toggling
  void updateFavouriteCount() {
    _favouritesCountController.add(favouritesCount);
  }

  // Method to get the favourites count for a video
  Future<num> getFavouritesCount({required String videoId}) async {
    emit(GetFavoritesCountLoadingState());

    final result =
        await getFavouritesCountUseCase.getFavouritesCount(videoId: videoId);
    result.fold(
      (failure) => emit(GetFavoritesCountErrorState(message: failure.message)),
      (count) {
        favouritesCount[videoId] = count;
        // Add updated favorites count to the stream
        _favouritesCountController.add(favouritesCount);
        emit(GetFavoritesCountSuccessState(favCount: count));
      },
    );

    return result.getOrElse(() => 0);
  }
}
