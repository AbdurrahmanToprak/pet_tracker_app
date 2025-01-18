import 'package:hive/hive.dart';

part 'pet_model.g.dart';

@HiveType(typeId: 0)
class PetModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final int age;

  @HiveField(3)
  final String breed;

  @HiveField(4)
  final String photoUrl;

  @HiveField(5)
  final double weight;

  @HiveField(6)
  final String healthStatus;

  PetModel({
    required this.name,
    required this.type,
    required this.age,
    required this.breed,
    required this.photoUrl,
    required this.weight,
    required this.healthStatus,
  });
}
