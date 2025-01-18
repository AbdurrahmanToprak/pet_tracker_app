import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../../models/health_record_model.dart';

class HealthRecordViewModel with ChangeNotifier {
  final Box<HealthRecordModel> _healthRecordBox;

  HealthRecordViewModel()
      : _healthRecordBox = Hive.box<HealthRecordModel>('healthRecords');

  List<HealthRecordModel> get healthRecords => _healthRecordBox.values.toList();

  // Sağlık kaydı ekleme
  void addHealthRecord(HealthRecordModel healthRecord) {
    _healthRecordBox.add(healthRecord);
    notifyListeners();
  }

  // Sağlık kaydını güncelleme
  void updateHealthRecord(
      HealthRecordModel oldRecord, HealthRecordModel updatedRecord) {
    final index = _healthRecordBox.values.toList().indexOf(oldRecord);
    if (index != -1) {
      _healthRecordBox.putAt(index, updatedRecord);
      notifyListeners();
    }
  }

  // Sağlık kaydını silme
  void deleteHealthRecord(int index) {
    _healthRecordBox.deleteAt(index);
    notifyListeners();
  }
}
