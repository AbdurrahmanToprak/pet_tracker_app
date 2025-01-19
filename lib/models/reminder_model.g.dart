// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderModelAdapter extends TypeAdapter<ReminderModel> {
  @override
  final int typeId = 3;

  @override
  ReminderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderModel(
      title: fields[1] as String,
      reminderDate: fields[2] as DateTime,
      description: fields[3] as String,
      reminderType: fields[4] as String,
      isRecurring: fields[5] as bool,
      recurrenceInterval: fields[6] as int,
      pet: fields[7] as PetModel,
    );
  }

  @override
  void write(BinaryWriter writer, ReminderModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.reminderDate)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.reminderType)
      ..writeByte(5)
      ..write(obj.isRecurring)
      ..writeByte(6)
      ..write(obj.recurrenceInterval)
      ..writeByte(7)
      ..write(obj.pet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
