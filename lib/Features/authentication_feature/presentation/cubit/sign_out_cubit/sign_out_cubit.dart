import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/authentication_use_case/sign_out_use_case.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit({
    required this.signOutUseCase,
  }) : super(SignOutState());
  static SignOutCubit get(context) => BlocProvider.of(context);
  final SignOutUseCase signOutUseCase;
  Future<void> signOut() async {
    emit(SignOutLoadingState());
    final result = await signOutUseCase.call();
    result.fold(
      (failure) {
        print(failure.message);
        emit(SignOutErrorState(error: failure.message));
      },
      (success) {
        emit(SignOutSuccessState());
      },
    );
  }
}
