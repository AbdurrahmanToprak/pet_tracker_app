import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../../models/feeding_model.dart';

class FeedingViewModel with ChangeNotifier {
  final Box<FeedingModel> _feedingBox;

  FeedingViewModel() : _feedingBox = Hive.box<FeedingModel>('feedings');

  List<FeedingModel> get feedings => _feedingBox.values.toList();

  // Beslenme ekleme
  void addFeeding(FeedingModel feeding) {
    _feedingBox.add(feeding);
    notifyListeners();
  }

  // Beslenme güncelleme
  void updateFeeding(FeedingModel oldFeeding, FeedingModel updatedFeeding) {
    final index = _feedingBox.values.toList().indexOf(oldFeeding);
    if (index != -1) {
      _feedingBox.putAt(index, updatedFeeding);
      notifyListeners();
    }
  }

  // Beslenme silme
  void deleteFeeding(int index) {
    _feedingBox.deleteAt(index);
    notifyListeners();
  }
}
