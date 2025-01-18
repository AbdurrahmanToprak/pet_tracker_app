// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_record_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthRecordModelAdapter extends TypeAdapter<HealthRecordModel> {
  @override
  final int typeId = 2;

  @override
  HealthRecordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthRecordModel(
      doctorName: fields[0] as String,
      visitDate: fields[1] as DateTime,
      description: fields[2] as String,
      pet: fields[3] as PetModel,
    );
  }

  @override
  void write(BinaryWriter writer, HealthRecordModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.doctorName)
      ..writeByte(1)
      ..write(obj.visitDate)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.pet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthRecordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
