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
      doctorName: fields[1] as String,
      visitDate: fields[2] as DateTime,
      description: fields[3] as String,
      petId: fields[4] as String,
      id: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HealthRecordModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.doctorName)
      ..writeByte(2)
      ..write(obj.visitDate)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.petId);
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
