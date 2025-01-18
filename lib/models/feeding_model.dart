import 'package:hive/hive.dart';
import 'pet_model.dart';

part 'feeding_model.g.dart';

@HiveType(typeId: 1)
class FeedingModel {
  @HiveField(0)
  final String foodType;

  @HiveField(1)
  final DateTime mealTime;

  @HiveField(2)
  final String amount;

  @HiveField(3)
  final bool hasWater;

  @HiveField(4)
  final PetModel pet;  

  FeedingModel({
    required this.foodType,
    required this.mealTime,
    required this.amount,
    required this.hasWater,
    required this.pet,
  });
}
