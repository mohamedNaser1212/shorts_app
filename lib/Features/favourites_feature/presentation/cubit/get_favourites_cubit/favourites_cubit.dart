import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_entity/favourite_entitiy.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_use_case/get_favourites_use_case.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit({
    required this.favouritesUseCase,
  }) : super(FavouritesState());
  final GetFavouritesUseCase favouritesUseCase;

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
}
