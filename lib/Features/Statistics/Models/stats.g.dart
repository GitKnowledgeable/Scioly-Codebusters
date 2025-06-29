// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../stats_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SolveRecordAdapter extends TypeAdapter<SolveRecord> {
  @override
  final int typeId = 0;

  @override
  SolveRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SolveRecord(
      solveTime: fields[0] as double,
      timestamp: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SolveRecord obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.solveTime)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SolveRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GameModeStatsAdapter extends TypeAdapter<GameModeStats> {
  @override
  final int typeId = 1;

  @override
  GameModeStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameModeStats(solveRecords: (fields[0] as List).cast<SolveRecord>());
  }

  @override
  void write(BinaryWriter writer, GameModeStats obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.solveRecords);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameModeStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
