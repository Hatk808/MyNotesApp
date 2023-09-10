// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notedata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class notedataAdapter extends TypeAdapter<notedata> {
  @override
  final int typeId = 1;

  @override
  notedata read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return notedata(
      title: fields[0] as String,
      note: fields[1] as String,
      date: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, notedata obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.note)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is notedataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
