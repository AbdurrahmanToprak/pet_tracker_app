import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/pet_model.dart';
import '../../models/feeding_model.dart';
import '../../base/viewmodels/feeding_view_model.dart';

class AddFeedingPage extends StatefulWidget {
  final PetModel pet;

  AddFeedingPage({required this.pet});

  @override
  _AddFeedingPageState createState() => _AddFeedingPageState();
}

class _AddFeedingPageState extends State<AddFeedingPage> {
  final _formKey = GlobalKey<FormState>();
  String _foodType = '';
  DateTime _mealTime = DateTime.now();
  double _amount = 0.0;
  bool _hasWater = false;

  Future<void> _selectMealTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _mealTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_mealTime),
      );
      if (pickedTime != null) {
        setState(() {
          _mealTime = DateTime(
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
    final feedingViewModel =
        Provider.of<FeedingViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Beslenme Kaydı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Yemek Türü'),
                onSaved: (value) => _foodType = value!,
                validator: (value) => value == null || value.isEmpty
                    ? 'Yemek türü gerekli'
                    : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Miktar (gram)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _amount = double.parse(value!),
                validator: (value) =>
                    value == null || double.tryParse(value) == null
                        ? 'Geçerli bir miktar girin'
                        : null,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Yemek Saati: ${_mealTime.toLocal()}'),
                  TextButton(
                    onPressed: () => _selectMealTime(context),
                    child: Text('Saat Seç'),
                  ),
                ],
              ),
              SwitchListTile(
                title: Text('Su Verildi mi?'),
                value: _hasWater,
                onChanged: (value) => setState(() => _hasWater = value),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Kaydet'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final newFeeding = FeedingModel(
                      id: DateTime.now().toString(),
                      petId: widget.pet.id,
                      foodType: _foodType,
                      mealTime: _mealTime,
                      amount: _amount,
                      hasWater: _hasWater,
                    );

                    feedingViewModel.addFeeding(widget.pet.id, newFeeding);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Beslenme kaydı eklendi!')),
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
