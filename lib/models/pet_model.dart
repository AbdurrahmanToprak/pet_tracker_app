import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'pet_model.g.dart';

@HiveType(typeId: 0)
class PetModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final int age;

  @HiveField(4)
  final String breed;

  @HiveField(5)
  final String photoUrl;

  @HiveField(6)
  final double weight;

  @HiveField(7)
  final String healthStatus;

  PetModel({
    required this.name,
    required this.type,
    required this.age,
    required this.breed,
    required this.photoUrl,
    required this.weight,
    required this.healthStatus,
    required this.id,
  });

  static Future<PetModel> create({
    required String name,
    required String type,
    required int age,
    required String breed,
    required String photoUrl,
    required double weight,
    required String healthStatus,
  }) async {
    String? id = await _getStoredId();
    if (id == null) {
      id = _generateId();
      await _storeId(id);
    }
    return PetModel(
      id: id,
      name: name,
      type: type,
      age: age,
      breed: breed,
      photoUrl: photoUrl,
      weight: weight,
      healthStatus: healthStatus,
    );
  }

  // ID'yi sabit tutmak için kaydetme işlemi
  static Future<void> _storeId(String id) async {
    var box = await Hive.openBox('pet_id_box');
    await box.put('pet_id', id);
  }

  // ID'yi al
  static Future<String?> _getStoredId() async {
    var box = await Hive.openBox('pet_id_box');
    return box.get('pet_id');
  }

  // Yeni bir sabit ID oluştur
  static String _generateId() {
    return const Uuid().v4();
  }
}
