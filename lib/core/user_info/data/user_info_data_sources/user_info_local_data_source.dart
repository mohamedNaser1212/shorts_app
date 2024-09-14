import '../../../../Features/authentication_feature/data/user_model/user_model.dart';
import '../../../network/Hive_manager/hive_boxes_names.dart';
import '../../../network/Hive_manager/hive_helper.dart';

abstract class UserInfoLocalDataSource {
  const UserInfoLocalDataSource();
  Future<void> saveUserData({required UserModel user});
  Future<UserModel?> loadUserData();
  Future<void> clearUserData();
}

class UserLocalDataSourceImpl implements UserInfoLocalDataSource {
  final LocalStorageManager hiveHelper;

  const UserLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<void> saveUserData({required UserModel user}) async {
    await hiveHelper.saveSingleItem<UserModel>(
        HiveBoxesNames.kUserBox, user, HiveBoxesNames.kUserBox);
    print('User data saved to Hive');
  }

  @override
  Future<UserModel?> loadUserData() async {
    final user = await hiveHelper.loadSingleItem<UserModel>(
        HiveBoxesNames.kUserBox, HiveBoxesNames.kUserBox);
    return user;
  }

  @override
  Future<void> clearUserData() async {
    await hiveHelper.clearData<UserModel>(HiveBoxesNames.kUserBox);
    print('User data cleared from Hive');
  }
}
