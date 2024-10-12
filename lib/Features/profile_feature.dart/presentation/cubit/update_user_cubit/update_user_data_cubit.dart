import 'package:bloc/bloc.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';


part 'update_user_data_state.dart';

class UpdateUserDataCubit extends Cubit<UpdateUserDataState> {
  UpdateUserDataCubit() : super(UpdateUserDataState());
}
