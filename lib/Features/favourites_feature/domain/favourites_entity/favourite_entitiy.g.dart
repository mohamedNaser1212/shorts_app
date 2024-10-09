// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_entitiy.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouritesEntityAdapter extends TypeAdapter<FavouritesEntity> {
  @override
  final int typeId = 2;

  @override
  FavouritesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouritesEntity(
      id: fields[0] as String,
      thumbnail: fields[1] as String,
      videoUrl: fields[2] as String,
      description: fields[3] as String?,
      user: fields[4] as UserEntity,
      isFavourite: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, FavouritesEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.thumbnail)
      ..writeByte(2)
      ..write(obj.videoUrl)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.user)
      ..writeByte(5)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
