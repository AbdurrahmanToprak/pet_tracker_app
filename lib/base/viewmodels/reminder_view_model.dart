import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../../models/reminder_model.dart';

class ReminderViewModel with ChangeNotifier {
  final Box<ReminderModel> _reminderBox;

  ReminderViewModel() : _reminderBox = Hive.box<ReminderModel>('reminders');

  List<ReminderModel> get reminders => _reminderBox.values.toList();

  void addReminder(ReminderModel reminder) {
    _reminderBox.add(reminder);
    notifyListeners();
  }

  void updateReminder(
      ReminderModel oldReminder, ReminderModel updatedReminder) {
    final index = _reminderBox.values.toList().indexOf(oldReminder);
    if (index != -1) {
      _reminderBox.putAt(index, updatedReminder);
      notifyListeners();
    }
  }

  void deleteReminder(int index) {
    _reminderBox.deleteAt(index);
    notifyListeners();
  }
}
