import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../base/services/reminder/notification_service.dart';
import '../../base/viewmodels/reminder_view_model.dart';
import '../../models/pet_model.dart';
import '../../models/reminder_model.dart';
import 'package:intl/intl.dart';

class AddReminderPage extends StatefulWidget {
  final PetModel pet;

  const AddReminderPage({super.key, required this.pet});

  @override
  _AddReminderPageState createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late DateTime _reminderDate;
  late String _description;
  late String _reminderType;
  late bool _isRecurring;
  late int _recurrenceInterval;

  @override
  void initState() {
    super.initState();
    _title = '';
    _reminderDate = DateTime.now();
    _description = '';
    _reminderType = 'Beslenme';
    _isRecurring = false;
    _recurrenceInterval = 1;
  }

  @override
  Widget build(BuildContext context) {
    final reminderViewModel = Provider.of<ReminderViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Yeni Hatırlatıcı Ekle')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Başlık'),
                onChanged: (value) {
                  _title = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Başlık boş olamaz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Açıklama'),
                onChanged: (value) {
                  _description = value;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Hatırlatıcı Zamanı'),
                controller: TextEditingController(
                  text: DateFormat('yyyy-MM-dd HH:mm').format(_reminderDate),
                ),
                onTap: () async {
                
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _reminderDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );

                  if (selectedDate != null) {
                  
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_reminderDate),
                    );

                    if (selectedTime != null) {
                      setState(() {
                      
                        _reminderDate = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _reminderType,
                onChanged: (value) {
                  setState(() {
                    _reminderType = value!;
                  });
                },
                items: ['Beslenme', 'İlaç', 'Egzersiz', 'Veteriner']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                decoration:
                    const InputDecoration(labelText: 'Hatırlatıcı Türü'),
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                title: const Text('Tekrarla'),
                value: _isRecurring,
                onChanged: (value) {
                  setState(() {
                    _isRecurring = value;
                  });
                },
              ),
              if (_isRecurring)
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Tekrar Aralığı (Günlük)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _recurrenceInterval = int.tryParse(value) ?? 1;
                  },
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newReminder = ReminderModel(
                      title: _title,
                      reminderDate: _reminderDate,
                      description: _description,
                      reminderType: _reminderType,
                      isRecurring: _isRecurring,
                      recurrenceInterval: _recurrenceInterval,
                      petId: widget.pet.id,
                    );
                    
                    // Bildirim
                    NotificationService.scheduleNotification(
                      id: newReminder.id.hashCode,
                      title: 'Hatırlatıcı: ${newReminder.title}',
                      body: newReminder.description,
                      scheduledDate: newReminder.reminderDate,
                    );
                    reminderViewModel.addReminder(newReminder);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
