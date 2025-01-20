import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'feeding_model.g.dart';

@HiveType(typeId: 1)
class FeedingModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String foodType;

  @HiveField(2)
  final DateTime mealTime;

  @HiveField(3)
  final double amount;

  @HiveField(4)
  final bool hasWater;

  @HiveField(5)
  String petId;

  FeedingModel({
    required this.foodType,
    required this.mealTime,
    required this.amount,
    required this.hasWater,
    required this.petId,
    String? id,
  }) : id = id ?? const Uuid().v4();
}
