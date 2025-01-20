import 'package:flutter/material.dart';
import 'package:pet_tracker_app/models/pet_model.dart';
import 'package:provider/provider.dart';
import '../../base/viewmodels/pet_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UpdatePetScreen extends StatefulWidget {
  final PetModel pet;

  const UpdatePetScreen({super.key, required this.pet});

  @override
  _UpdatePetScreenState createState() => _UpdatePetScreenState();
}

class _UpdatePetScreenState extends State<UpdatePetScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _breedController;
  late TextEditingController _weightController;
  String _selectedType = '';
  String _selectedHealthStatus = '';
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pet.name);
    _ageController = TextEditingController(text: widget.pet.age.toString());
    _breedController = TextEditingController(text: widget.pet.breed);
    _weightController =
        TextEditingController(text: widget.pet.weight.toString());
    _selectedType = widget.pet.type;
    _selectedHealthStatus = widget.pet.healthStatus;
    _imageFile = File(widget.pet.photoUrl);
  }

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
      appBar: AppBar(title: const Text('Evcil Hayvanı Güncelle')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Pet fotoğrafı
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
            const SizedBox(height: 20),
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
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isEmpty ||
                    _ageController.text.isEmpty ||
                    _breedController.text.isEmpty ||
                    _weightController.text.isEmpty ||
                    _selectedHealthStatus.isEmpty ||
                    _imageFile == null ||
                    _selectedType.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Lütfen tüm alanları doldurun')),
                  );
                } else {
                  final updatedPet = PetModel(
                    id: widget.pet.id,
                    name: _nameController.text,
                    type: _selectedType,
                    age: int.parse(_ageController.text),
                    breed: _breedController.text,
                    photoUrl: _imageFile!.path,
                    weight: double.parse(_weightController.text),
                    healthStatus: _selectedHealthStatus,
                  );
                  petViewModel.updatePet(widget.pet.id, updatedPet);

                  // mesaj
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Evcil hayvan bilgisi güncellendi'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  Navigator.pop(context, updatedPet);
                }
              },
              child: const Text('Güncelle'),
            ),
          ],
        ),
      ),
    );
  }
}
