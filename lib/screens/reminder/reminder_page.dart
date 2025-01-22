import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/pet_model.dart';
import '../../base/viewmodels/reminder_view_model.dart';
import '../../base/viewmodels/pet_view_model.dart';
import 'add_reminder_page.dart';
import 'reminder_detail_page.dart';

class ReminderPage extends StatelessWidget {
  final PetModel pet;

  const ReminderPage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final reminderViewModel = Provider.of<ReminderViewModel>(context);

    final petReminders = reminderViewModel.getRemindersByPetId(pet.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hatırlatıcılar'),
      ),
      body: petReminders.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.notifications_off,
                    size: 50,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Henüz hatırlatıcı eklenmedi',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: petReminders.length,
              itemBuilder: (context, index) {
                final reminder = petReminders[index];
                return ListTile(
                  title: Text(reminder.title),
                  subtitle: Text(reminder.reminderType),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReminderDetailPage(
                          reminder: reminder,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReminderPage(pet: pet),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
