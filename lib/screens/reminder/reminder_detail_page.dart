import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../base/viewmodels/reminder_view_model.dart';
import '../../models/reminder_model.dart';
import 'update_reminder_page.dart';

class ReminderDetailPage extends StatelessWidget {
  final ReminderModel reminder;

  const ReminderDetailPage({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    final reminderViewModel = Provider.of<ReminderViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text(reminder.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Başlık: ${reminder.title}',
                style: const TextStyle(fontSize: 18)),
            Text('Tür: ${reminder.reminderType}',
                style: const TextStyle(fontSize: 18)),
            Text('Tarih: ${reminder.reminderDate}',
                style: const TextStyle(fontSize: 18)),
            Text('Açıklama: ${reminder.description}',
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
                          petId: reminder.petId,
                          reminder: reminder,
                        ),
                      ),
                    );
                  },
                  child: const Text('Güncelle'),
                ),
                ElevatedButton(
                  onPressed: () {
                  
                    reminderViewModel.deleteReminder(reminder.id);
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
