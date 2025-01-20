import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../../models/feeding_model.dart';

class FeedingViewModel with ChangeNotifier {
  final Box<FeedingModel> _feedingBox;

  FeedingViewModel() : _feedingBox = Hive.box<FeedingModel>('feedings');

  List<FeedingModel> get feedings => _feedingBox.values.toList();

  List<FeedingModel> getFeedingsForPet(String petId) {
    return _feedingBox.values
        .where((feeding) => feeding.petId == petId)
        .toList();
  }

  // Yemek kaydı ekleme
  void addFeeding(String petId, FeedingModel feeding) {
    feeding.petId = petId;
    _feedingBox.add(feeding);
    notifyListeners();
  }

  // Yemek kaydını güncelleme
  void updateFeeding(String id, FeedingModel updatedFeeding) {
    final index =
        _feedingBox.values.toList().indexWhere((feeding) => feeding.id == id);
    if (index != -1) {
      _feedingBox.putAt(index, updatedFeeding);
      notifyListeners();
    }
  }

  // Yemek kaydını silme
  void deleteFeeding(String id) {
    final index =
        _feedingBox.values.toList().indexWhere((feeding) => feeding.id == id);
    if (index != -1) {
      _feedingBox.deleteAt(index);
      notifyListeners();
    }
  }
}
