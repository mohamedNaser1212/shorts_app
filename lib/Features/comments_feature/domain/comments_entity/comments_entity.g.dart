// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentEntityAdapter extends TypeAdapter<CommentEntity> {
  @override
  final int typeId = 4;

  @override
  CommentEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentEntity(
      id: fields[0] as String,
      content: fields[1] as String,
      user: fields[2] as UserEntity,
      timestamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CommentEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.user)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
