import 'package:hive/hive.dart';
import 'pet_model.dart';

part 'health_record_model.g.dart';

@HiveType(typeId: 2)
class HealthRecordModel {
  @HiveField(0)
  final String doctorName;

  @HiveField(1)
  final DateTime visitDate;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final PetModel pet;

  HealthRecordModel({
    required this.doctorName,
    required this.visitDate,
    required this.description,
    required this.pet,
  });
}
