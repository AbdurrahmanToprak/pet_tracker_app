import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/reminder_model.dart';

class ReminderViewModel extends ChangeNotifier {
  final Box<ReminderModel> _reminderBox;

  ReminderViewModel() : _reminderBox = Hive.box<ReminderModel>('reminders');

  List<ReminderModel> getRemindersByPetId(String petId) {
    return _reminderBox.values
        .where((reminder) => reminder.petId == petId)
        .toList();
  }

  void addReminder(ReminderModel reminder) {
    _reminderBox.add(reminder);
    notifyListeners();
  }

  void updateReminder(String id, ReminderModel updatedReminder) {
    final index = _reminderBox.values.toList().indexWhere((r) => r.id == id);
    if (index != -1) {
      _reminderBox.putAt(index, updatedReminder);
      notifyListeners();
    }
  }

  void deleteReminder(String id) {
    final index = _reminderBox.values.toList().indexWhere((r) => r.id == id);
    if (index != -1) {
      _reminderBox.deleteAt(index);
      notifyListeners();
    }
  }
}
