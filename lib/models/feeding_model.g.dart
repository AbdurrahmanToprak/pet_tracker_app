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
      foodType: fields[0] as String,
      mealTime: fields[1] as DateTime,
      amount: fields[2] as String,
      hasWater: fields[3] as bool,
      pet: fields[4] as PetModel,
    );
  }

  @override
  void write(BinaryWriter writer, FeedingModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.foodType)
      ..writeByte(1)
      ..write(obj.mealTime)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.hasWater)
      ..writeByte(4)
      ..write(obj.pet);
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
