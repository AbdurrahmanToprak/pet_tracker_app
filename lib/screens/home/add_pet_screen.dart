import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../base/viewmodels/pet_view_model.dart';
import '../../models/pet_model.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  _AddPetScreenState createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _breedController = TextEditingController();
  final _weightController = TextEditingController();
  final _healthStatusController = TextEditingController();

  File? _imageFile;
  String _selectedType = 'Köpek';
  String _selectedHealthStatus = 'İyi';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final petViewModel = Provider.of<PetViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Evcil Hayvan Ekle')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Ad'),
            ),
            DropdownButton<String>(
              value: _selectedType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedType = newValue!;
                });
              },
              items: <String>['Köpek', 'Kedi', 'Kuş', 'Diğer']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
              hint: const Text('Tür Seçiniz'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Yaş'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _breedController,
              decoration: const InputDecoration(labelText: 'Cins'),
            ),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Ağırlık'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            DropdownButton<String>(
              value: _selectedHealthStatus,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedHealthStatus = newValue!;
                });
              },
              items: <String>['İyi', 'Normal', 'Kötü']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
              hint: const Text('Sağlık Durumunu Seçiniz'),
            ),
            const SizedBox(height: 20),
            _imageFile == null
                ? const Text('Fotoğraf Seçilmedi')
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Fotoğraf Seç'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isEmpty ||
                    _ageController.text.isEmpty ||
                    _breedController.text.isEmpty ||
                    _weightController.text.isEmpty ||
                    _selectedHealthStatus.isEmpty ||
                    _imageFile == null ||
                    _selectedType.isEmpty) {
                  // uyarı verme
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Lütfen tüm alanları doldurun ve fotoğraf seçin')),
                  );
                } else {
                  final pet = PetModel(
                    id: '',
                    name: _nameController.text,
                    type: _selectedType,
                    age: int.parse(_ageController.text),
                    breed: _breedController.text,
                    photoUrl: _imageFile!.path,
                    weight: double.parse(_weightController.text),
                    healthStatus: _selectedHealthStatus,
                  );
                  petViewModel.addPet(pet);
                  Navigator.pop(context);
                }
              },
              child: const Text('Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
