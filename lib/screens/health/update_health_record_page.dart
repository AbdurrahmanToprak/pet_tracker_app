import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/health_record_model.dart';
import '../../models/pet_model.dart';
import '../../base/viewmodels/health_record_view_model.dart';

class UpdateHealthRecordPage extends StatefulWidget {
  final PetModel pet;
  final HealthRecordModel record;

  const UpdateHealthRecordPage(
      {super.key, required this.pet, required this.record});

  @override
  State<UpdateHealthRecordPage> createState() => _UpdateHealthRecordPageState();
}

class _UpdateHealthRecordPageState extends State<UpdateHealthRecordPage> {
  late TextEditingController doctorController;
  late TextEditingController descriptionController;
  late TextEditingController visitDateController;
  late bool hasWater;
  late DateTime selectedDateTime;

  @override
  void initState() {
    super.initState();
    doctorController = TextEditingController(text: widget.record.doctorName);
    descriptionController =
        TextEditingController(text: widget.record.description);
    selectedDateTime = widget.record.visitDate;
    visitDateController = TextEditingController(
        text:
            "${widget.record.visitDate.day}/${widget.record.visitDate.month}/${widget.record.visitDate.year} ${widget.record.visitDate.hour}:${widget.record.visitDate.minute}");
  }

  @override
  void dispose() {
    doctorController.dispose();
    descriptionController.dispose();
    visitDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final healthRecordViewModel =
        Provider.of<HealthRecordViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sağlık Kaydını Güncelle'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: doctorController,
              decoration: const InputDecoration(labelText: 'Doktor Adı'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Açıklama'),
            ),
            TextField(
              controller: visitDateController,
              decoration:
                  const InputDecoration(labelText: 'Ziyaret Tarihi ve Saat'),
              readOnly: true,
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: widget.record.visitDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (selectedDate != null) {
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(widget.record.visitDate),
                  );
                  if (selectedTime != null) {
                    final newVisitDate = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );
                    setState(() {
                      selectedDateTime = newVisitDate;
                      visitDateController.text = DateFormat('dd-MM-yyyy HH:mm')
                          .format(selectedDateTime);
                    });
                  }
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedRecord = HealthRecordModel(
                  id: widget.record.id,
                  petId: widget.pet.id,
                  doctorName: doctorController.text,
                  visitDate: selectedDateTime,
                  description: descriptionController.text,
                );

                healthRecordViewModel.updateHealthRecord(
                    widget.record.id, updatedRecord);

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sağlık kaydı güncellendi')),
                );
              },
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
