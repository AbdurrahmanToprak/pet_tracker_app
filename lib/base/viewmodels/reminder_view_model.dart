import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/reminder_model.dart';

class ReminderViewModel extends ChangeNotifier {
  final String _boxName = 'reminders';
  late Box<ReminderModel> _reminderBox;

  // Başlatma (Hive box'ını aç)
  Future<void> initialize() async {
    _reminderBox = await Hive.openBox<ReminderModel>(_boxName);
    notifyListeners();
  }

  // Tüm hatırlatıcıları al
  List<ReminderModel> get reminderList => _reminderBox.values.toList();

  // Hatırlatıcı ekle
  Future<void> addReminder(ReminderModel reminder) async {
    await _reminderBox.add(reminder);
    notifyListeners();
  }

  // Hatırlatıcı sil
  Future<void> deleteReminder(int index) async {
    await _reminderBox.deleteAt(index);
    notifyListeners();
  }

  // Hatırlatıcı güncelle
  Future<void> updateReminder(int index, ReminderModel updatedReminder) async {
    await _reminderBox.putAt(index, updatedReminder);
    notifyListeners();
  }
}
