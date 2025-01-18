import 'package:hive/hive.dart';
import 'pet_model.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 3)
class ReminderModel {
  @HiveField(0)
  final String message;

  @HiveField(1)
  final DateTime reminderTime;

  @HiveField(2)
  final PetModel pet; // Evcil hayvanla bağlantı kuruyoruz.

  ReminderModel({
    required this.message,
    required this.reminderTime,
    required this.pet,
  });
}
