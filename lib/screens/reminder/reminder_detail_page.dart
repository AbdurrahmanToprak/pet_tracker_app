import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../base/viewmodels/reminder_view_model.dart';
import '../../models/reminder_model.dart';
import 'update_reminder_page.dart';

class ReminderDetailPage extends StatefulWidget {
  final ReminderModel reminder;

  const ReminderDetailPage({super.key, required this.reminder});

  @override
  _ReminderDetailPageState createState() => _ReminderDetailPageState();
}

class _ReminderDetailPageState extends State<ReminderDetailPage> {
  late ReminderModel _currentReminder;

  @override
  void initState() {
    super.initState();
    _currentReminder = widget.reminder;
  }

  @override
  Widget build(BuildContext context) {
    final reminderViewModel = Provider.of<ReminderViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text(_currentReminder.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Başlık: ${_currentReminder.title}',
                style: const TextStyle(fontSize: 18)),
            Text('Tür: ${_currentReminder.reminderType}',
                style: const TextStyle(fontSize: 18)),
            if (_currentReminder.isRecurring)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Tarih: Tekrarlı hatırlatma( ${_currentReminder.recurrenceInterval} günde bir)',
                      style: const TextStyle(fontSize: 18)),
                  Text(
                    'Saat: ${DateFormat('HH:mm').format(_currentReminder.reminderDate)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tarih: ${DateFormat('yyyy-MM-dd').format(_currentReminder.reminderDate)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Saat: ${DateFormat('HH:mm').format(_currentReminder.reminderDate)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            Text('Açıklama: ${_currentReminder.description}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateReminderPage(
                          petId: _currentReminder.petId,
                          reminder: _currentReminder,
                        ),
                      ),
                    ).then((_) {
                      final updatedReminder = reminderViewModel
                          .getRemindersByPetId(_currentReminder.petId)
                          .firstWhere((r) => r.id == _currentReminder.id);
                      setState(() {
                        _currentReminder = updatedReminder;
                      });
                    });
                  },
                  child: const Text('Güncelle'),
                ),
                ElevatedButton(
                  onPressed: () {
                    reminderViewModel.deleteReminder(_currentReminder.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Hatırlatıcı silindi')),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Sil'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
