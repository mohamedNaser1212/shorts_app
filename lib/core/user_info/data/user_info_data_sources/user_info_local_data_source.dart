import '../../../network/Hive_manager/hive_boxes_names.dart';
import '../../../network/Hive_manager/hive_helper.dart';
import '../../domain/user_entity/user_entity.dart';

abstract class UserInfoLocalDataSource {
  const UserInfoLocalDataSource();
  Future<void> saveUserData({required UserEntity user});
  Future<UserEntity?> loadUserData();
  Future<void> clearUserData();
}

class UserLocalDataSourceImpl implements UserInfoLocalDataSource {
  final LocalStorageManager hiveHelper;

  const UserLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<void> saveUserData({required UserEntity user}) async {
    await hiveHelper.saveSingleItem<UserEntity>(
        HiveBoxesNames.kUserBox, user, HiveBoxesNames.kUserBox);
    print('User data saved to Hive');
  }

  @override
  Future<UserEntity?> loadUserData() async {
    final user = await hiveHelper.loadSingleItem<UserEntity>(
        HiveBoxesNames.kUserBox, HiveBoxesNames.kUserBox);
    return user;
  }

  @override
  Future<void> clearUserData() async {
    await hiveHelper.clearData<UserEntity>(HiveBoxesNames.kUserBox);
    print('User data cleared from Hive');
  }
}
