// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoEntityAdapter extends TypeAdapter<VideoEntity> {
  @override
  final int typeId = 0;

  @override
  VideoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoEntity(
      id: fields[0] as String,
      thumbnail: fields[1] as String,
      videoUrl: fields[2] as String,
      description: fields[3] as String,
      user: fields[4] as UserEntity,
      timeStamp: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, VideoEntity obj) {
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
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
