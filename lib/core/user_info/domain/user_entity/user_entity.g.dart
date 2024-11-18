// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserEntityAdapter extends TypeAdapter<UserEntity> {
  @override
  final int typeId = 5;

  @override
  UserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserEntity(
      name: fields[0] as String,
      email: fields[1] as String,
      phone: fields[2] as String,
      id: fields[3] as String?,
      fcmToken: fields[4] as String,
      profilePic: fields[5] as String,
      bio: fields[6] as String,
      followersCount: fields[7] as int,
      followingCount: fields[8] as int,
      likesCount: fields[9] as int,
      isVerified: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.fcmToken)
      ..writeByte(5)
      ..write(obj.profilePic)
      ..writeByte(6)
      ..write(obj.bio)
      ..writeByte(7)
      ..write(obj.followersCount)
      ..writeByte(8)
      ..write(obj.followingCount)
      ..writeByte(9)
      ..write(obj.likesCount)
      ..writeByte(10)
      ..write(obj.isVerified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
