import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/pet_model.dart';
import '../../models/health_record_model.dart';
import '../../base/viewmodels/health_record_view_model.dart';

class AddHealthRecordPage extends StatefulWidget {
  final PetModel pet;

  AddHealthRecordPage({required this.pet});

  @override
  _AddHealthRecordPageState createState() => _AddHealthRecordPageState();
}

class _AddHealthRecordPageState extends State<AddHealthRecordPage> {
  final _formKey = GlobalKey<FormState>();
  String _doctorName = '';
  DateTime _visitDate = DateTime.now();
  String _description = '';

  Future<void> _selectVisitDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _visitDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_visitDate),
      );
      if (pickedTime != null) {
        setState(() {
          _visitDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final healthRecordViewModel =
        Provider.of<HealthRecordViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Sağlık Kaydı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Doktor Adı'),
                onSaved: (value) => _doctorName = value!,
                validator: (value) => value == null || value.isEmpty
                    ? 'Doktor adı gerekli'
                    : null,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Ziyaret Saati: ${_visitDate.toLocal()}'),
                  TextButton(
                    onPressed: () => _selectVisitDate(context),
                    child: Text('Saat Seç'),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Açıklama'),
                maxLines: 3,
                onSaved: (value) => _description = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Kaydet'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final newRecord = HealthRecordModel(
                      id: DateTime.now().toString(),
                      petId: widget.pet.id,
                      doctorName: _doctorName,
                      visitDate: _visitDate,
                      description: _description,
                    );

                    healthRecordViewModel.addHealthRecord(
                        widget.pet.id, newRecord);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sağlık kaydı eklendi!')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
