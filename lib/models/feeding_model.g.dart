// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeding_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeedingModelAdapter extends TypeAdapter<FeedingModel> {
  @override
  final int typeId = 1;

  @override
  FeedingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedingModel(
      foodType: fields[1] as String,
      mealTime: fields[2] as DateTime,
      amount: fields[3] as double,
      hasWater: fields[4] as bool,
      petId: fields[5] as String,
      id: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FeedingModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.foodType)
      ..writeByte(2)
      ..write(obj.mealTime)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.hasWater)
      ..writeByte(5)
      ..write(obj.petId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
