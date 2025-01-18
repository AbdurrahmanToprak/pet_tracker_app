import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_tracker_app/models/pet_model.dart';
import 'package:pet_tracker_app/screens/home/update_pet_screen.dart';
import 'package:provider/provider.dart';
import '../../base/viewmodels/pet_view_model.dart';

class PetDetailsScreen extends StatefulWidget {
  final PetModel pet;

  const PetDetailsScreen({super.key, required this.pet});

  @override
  _PetDetailsScreenState createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  late PetModel pet;

  @override
  void initState() {
    super.initState();
    pet = widget.pet;
  }

  @override
  Widget build(BuildContext context) {
    final petViewModel = Provider.of<PetViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text(pet.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Hayvan fotoğrafı
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.file(
                File(pet.photoUrl),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            // Hayvan Bilgisi alma
            Text('Ad: ${pet.name}', style: const TextStyle(fontSize: 18)),
            Text('Tür: ${pet.type}', style: const TextStyle(fontSize: 18)),
            Text('Yaş: ${pet.age}', style: const TextStyle(fontSize: 18)),
            Text('Cins: ${pet.breed}', style: const TextStyle(fontSize: 18)),
            Text('Ağırlık: ${pet.weight} kg',
                style: const TextStyle(fontSize: 18)),
            Text('Sağlık Durumu: ${pet.healthStatus}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final updatedPet = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdatePetScreen(pet: pet),
                      ),
                    );

                    if (updatedPet != null) {
                      setState(() {
                        pet = updatedPet;
                      });
                    }
                  },
                  child: const Text('Güncelle'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final index = petViewModel.pets.indexOf(pet);
                    if (index != -1) {
                      petViewModel.deletePet(index);
                      //bildirim
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Evcil hayvan bilgisi başarıyla silindi')),
                      );
                      Navigator.pop(context);
                    }
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
