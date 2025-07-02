// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solved_quote.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SolvedQuoteAdapter extends TypeAdapter<SolvedQuote> {
  @override
  final int typeId = 2;

  @override
  SolvedQuote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SolvedQuote(
      text: fields[0] as String,
      author: fields[1] as String,
      rating: fields[2] as int,
      solveTime: fields[3] as double,
      gameMode: fields[4] as String,
      date: fields[6] as DateTime,
      isFavorite: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SolvedQuote obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.solveTime)
      ..writeByte(4)
      ..write(obj.gameMode)
      ..writeByte(5)
      ..write(obj.isFavorite)
      ..writeByte(6)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SolvedQuoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
