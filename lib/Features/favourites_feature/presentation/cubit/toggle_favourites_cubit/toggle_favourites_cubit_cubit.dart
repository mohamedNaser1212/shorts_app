import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_use_case/toggle_favourites_use_case.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

part 'toggle_favourites_cubit_state.dart';

class ToggleFavouritesCubit extends Cubit<ToggleFavouritesState> {
  ToggleFavouritesCubit({
    required this.favouritesUseCase,
  }) : super(ToggleFavouritesState());
  static ToggleFavouritesCubit get(context) => BlocProvider.of(context);

  final ToggleFavouritesUseCase favouritesUseCase;
  Future<void> toggleFavourite({
    required VideoEntity video,
    required UserEntity userModel,
  }) async {
    emit(ToggleFavoritesLoadingState());

    final result = await favouritesUseCase.toggleFavouriteVideo(
      videoEntity: video,
      userModel: userModel,
    );
    result.fold(
      (failure) {
        print('Failed to toggle favourite: ${failure.message}');
        emit(ToggleFavoriteErrorState(message: failure.message));
      },
      (favourites) {
        emit(ToggleFavouriteSuccessState(isFavourite: favourites));
      },
    );
  }
}
