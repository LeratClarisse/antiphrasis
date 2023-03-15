// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamecard.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameCardAdapter extends TypeAdapter<GameCard> {
  @override
  final int typeId = 0;

  @override
  GameCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameCard(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, GameCard obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.answer)
      ..writeByte(3)
      ..write(obj.done)
      ..writeByte(4)
      ..write(obj.groupId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
