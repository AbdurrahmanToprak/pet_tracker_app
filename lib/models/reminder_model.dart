import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 3)
class ReminderModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime reminderDate;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String reminderType;

  @HiveField(5)
  final bool isRecurring;

  @HiveField(6)
  final int recurrenceInterval;

  @HiveField(7)
  final String petId;

  ReminderModel({
    required this.title,
    required this.reminderDate,
    required this.description,
    required this.reminderType,
    required this.isRecurring,
    required this.recurrenceInterval,
    required this.petId,
    String? id,
  }) : id = id ?? const Uuid().v4();
}
