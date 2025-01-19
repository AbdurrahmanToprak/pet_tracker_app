import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'pet_model.dart';

part 'health_record_model.g.dart';

@HiveType(typeId: 2)
class HealthRecordModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String doctorName;

  @HiveField(2)
  final DateTime visitDate;

  @HiveField(3)
  final String description;

  @HiveField(4)
  String petId;

  HealthRecordModel({
    required this.doctorName,
    required this.visitDate,
    required this.description,
    required this.petId,
    String? id,
  }) : id = id ?? Uuid().v4();
}
