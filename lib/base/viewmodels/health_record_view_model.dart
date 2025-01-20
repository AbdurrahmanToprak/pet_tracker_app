import 'package:flutter/material.dart';
import '../../models/health_record_model.dart';
import 'package:hive/hive.dart';

class HealthRecordViewModel extends ChangeNotifier {
  final _healthRecordBox = Hive.box<HealthRecordModel>('healthRecords');
  List<HealthRecordModel> get healthRecords => _healthRecordBox.values.toList();

  List<HealthRecordModel> getHealthRecordsForPet(String petId) {
    return _healthRecordBox.values
        .where((record) => record.petId == petId)
        .toList();
  }

  void addHealthRecord(String petId, HealthRecordModel record) {
    record.petId = petId;
    _healthRecordBox.add(record);
    notifyListeners();
  }

  void updateHealthRecord(String recordId, HealthRecordModel updatedRecord) {
    final index = _healthRecordBox.values
        .toList()
        .indexWhere((record) => record.id == recordId);

    if (index != -1) {
      _healthRecordBox.putAt(index, updatedRecord);
      notifyListeners();
    }
  }

  void deleteHealthRecord(String recordId) {
    final index = _healthRecordBox.values
        .toList()
        .indexWhere((record) => record.id == recordId);
    if (index != -1) {
      _healthRecordBox.deleteAt(index);
      notifyListeners();
    }
  }
}
