import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../base/viewmodels/reminder_view_model.dart';
import '../../models/reminder_model.dart';
import '../../base/services/reminder/notification_service.dart';

class UpdateReminderPage extends StatefulWidget {
  final String petId;
  final ReminderModel reminder;

  const UpdateReminderPage(
      {super.key, required this.petId, required this.reminder});

  @override
  _UpdateReminderPageState createState() => _UpdateReminderPageState();
}

class _UpdateReminderPageState extends State<UpdateReminderPage> {
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
    _title = widget.reminder.title;
    _reminderDate = widget.reminder.reminderDate;
    _description = widget.reminder.description;
    _reminderType = widget.reminder.reminderType;
    _isRecurring = widget.reminder.isRecurring;
    _recurrenceInterval = widget.reminder.recurrenceInterval;
  }

  @override
  Widget build(BuildContext context) {
    final reminderViewModel = Provider.of<ReminderViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Hatırlatıcıyı Güncelle')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: _title,
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
                  initialValue: _description,
                  decoration: const InputDecoration(labelText: 'Açıklama'),
                  onChanged: (value) {
                    _description = value;
                  },
                ),
                const SizedBox(height: 10),
                if (_isRecurring)
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Hatırlatıcı Saati'),
                    controller: TextEditingController(
                      text: DateFormat('HH:mm').format(_reminderDate),
                    ),
                    onTap: () async {
                      final selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(_reminderDate),
                      );
                      if (selectedTime != null) {
                        setState(() {
                          _reminderDate = DateTime(
                            _reminderDate.year,
                            _reminderDate.month,
                            _reminderDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                        });
                      }
                    },
                  ),
                if (!_isRecurring)
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Hatırlatıcı Zamanı'),
                    controller: TextEditingController(
                      text:
                          DateFormat('yyyy-MM-dd HH:mm').format(_reminderDate),
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
                    initialValue: _recurrenceInterval.toString(),
                    onChanged: (value) {
                      _recurrenceInterval = int.tryParse(value) ?? 1;
                    },
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (!_isRecurring &&
                          _reminderDate.isBefore(DateTime.now())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Lütfen gelecekte bir tarih seçin!')),
                        );
                        return;
                      }

                      final updatedReminder = ReminderModel(
                        title: _title,
                        reminderDate: _reminderDate,
                        description: _description,
                        reminderType: _reminderType,
                        isRecurring: _isRecurring,
                        recurrenceInterval: _recurrenceInterval,
                        petId: widget.petId,
                        id: widget.reminder.id,
                      );

                      reminderViewModel.updateReminder(
                          widget.reminder.id, updatedReminder);

                      NotificationService.scheduleNotification(
                        id: updatedReminder.id.hashCode,
                        title: 'Hatırlatıcı: ${updatedReminder.title}',
                        body: updatedReminder.description,
                        scheduledDate: updatedReminder.reminderDate,
                        isRecurring: updatedReminder.isRecurring,
                      );

                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Güncelle'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
