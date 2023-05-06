// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ToDo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoAdapter extends TypeAdapter<ToDo> {
  @override
  final int typeId = 0;

  @override
  ToDo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDo(
      text: fields[3] as String,
      secondaryText: fields[2] as String,
      categoria: fields[4] as String,
      priority: fields[5] as int,
      createion: fields[0] as DateTime,
      finish: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ToDo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.createion)
      ..writeByte(1)
      ..write(obj.finish)
      ..writeByte(2)
      ..write(obj.secondaryText)
      ..writeByte(3)
      ..write(obj.text)
      ..writeByte(4)
      ..write(obj.categoria)
      ..writeByte(5)
      ..write(obj.priority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
