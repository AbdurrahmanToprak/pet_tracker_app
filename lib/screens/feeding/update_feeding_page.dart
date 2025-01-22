import 'package:flutter/material.dart';
import '../../models/pet_model.dart';
import '../../models/feeding_model.dart';
import '../../base/viewmodels/feeding_view_model.dart';
import 'package:provider/provider.dart';

class UpdateFeedingPage extends StatefulWidget {
  final PetModel pet;
  final FeedingModel feeding;

  const UpdateFeedingPage(
      {super.key, required this.pet, required this.feeding});

  @override
  State<UpdateFeedingPage> createState() => _UpdateFeedingPageState();
}

class _UpdateFeedingPageState extends State<UpdateFeedingPage> {
  late TextEditingController foodTypeController;
  late TextEditingController amountController;
  late TextEditingController mealTimeController;
  late bool hasWater;

  @override
  void initState() {
    super.initState();

    foodTypeController = TextEditingController(text: widget.feeding.foodType);
    amountController =
        TextEditingController(text: widget.feeding.amount.toString());
    mealTimeController = TextEditingController(
        text:
            "${widget.feeding.mealTime.day}/${widget.feeding.mealTime.month}/${widget.feeding.mealTime.year} ${widget.feeding.mealTime.hour}:${widget.feeding.mealTime.minute}");
    hasWater = widget.feeding.hasWater;
  }

  @override
  void dispose() {
    foodTypeController.dispose();
    amountController.dispose();
    mealTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedingViewModel =
        Provider.of<FeedingViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beslenme Güncelle'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: foodTypeController,
              decoration: const InputDecoration(labelText: 'Yemek Türü'),
            ),
            TextField(
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Miktar (gram)'),
            ),
            TextField(
              controller: mealTimeController,
              decoration: const InputDecoration(labelText: 'Tarih ve Saat'),
              readOnly: true,
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: widget.feeding.mealTime,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (selectedDate != null) {
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(widget.feeding.mealTime),
                  );
                  if (selectedTime != null) {
                    final newMealTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );
                    setState(() {
                      mealTimeController.text =
                          "${newMealTime.day}/${newMealTime.month}/${newMealTime.year} ${newMealTime.hour}:${newMealTime.minute}";
                    });
                  }
                }
              },
            ),
            SwitchListTile(
              title: const Text('Su Verildi mi?'),
              value: hasWater,
              onChanged: (value) {
                setState(() {
                  hasWater = value;
                });
              },
            ),
            const SizedBox(height: 20), // To ensure enough space for the button
            ElevatedButton(
              onPressed: () {
                final updatedFeeding = FeedingModel(
                  id: widget.feeding.id,
                  petId: widget.feeding.petId,
                  foodType: foodTypeController.text,
                  amount: double.tryParse(amountController.text) ??
                      widget.feeding.amount,
                  hasWater: hasWater,
                  mealTime: widget.feeding.mealTime,
                );

                feedingViewModel.updateFeeding(
                    widget.feeding.id, updatedFeeding);

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Beslenme kaydı güncellendi')),
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
