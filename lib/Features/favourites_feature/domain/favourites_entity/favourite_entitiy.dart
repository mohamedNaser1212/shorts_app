import 'package:hive/hive.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';

part 'favourite_entitiy.g.dart';

@HiveType(typeId: 2)
class FavouritesEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String thumbnail;
  @HiveField(2)
  final String videoUrl;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final UserEntity user;
  @HiveField(5)
  bool? isFavourite;

  FavouritesEntity({
    required this.id,
    required this.thumbnail,
    required this.videoUrl,
    this.description,
    required this.user,
    this.isFavourite,
  });
}
