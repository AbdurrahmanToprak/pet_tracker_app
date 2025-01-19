// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PetModelAdapter extends TypeAdapter<PetModel> {
  @override
  final int typeId = 0;

  @override
  PetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PetModel(
      name: fields[1] as String,
      type: fields[2] as String,
      age: fields[3] as int,
      breed: fields[4] as String,
      photoUrl: fields[5] as String,
      weight: fields[6] as double,
      healthStatus: fields[7] as String,
      id: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PetModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.breed)
      ..writeByte(5)
      ..write(obj.photoUrl)
      ..writeByte(6)
      ..write(obj.weight)
      ..writeByte(7)
      ..write(obj.healthStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
