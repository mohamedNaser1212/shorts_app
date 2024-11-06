import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../../domain/authentication_use_case/google_sign_in_use_case.dart';

part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit({
    required this.googleSignInUseCase,
  }) : super(GoogleSignInState());

  final GoogleSignInUseCase googleSignInUseCase;

  static GoogleSignInCubit get(context) => BlocProvider.of(context);

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInLoadingState());
    final result = await googleSignInUseCase.call();
    result.fold(
      (failure) => emit(GoogleSignInErrorState(failure: failure.message)),
      (userEntity) => emit(GoogleSignInSuccessState(userEntity: userEntity)),
    );
  }
}
