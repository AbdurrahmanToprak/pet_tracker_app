import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../base/viewmodels/pet_view_model.dart';
import '../../models/pet_model.dart';
import '../feeding/feeding_page.dart';
import '../health/health_record_page.dart';
import '../reminder/reminder_page.dart';
import 'package:pet_tracker_app/screens/home/update_pet_screen.dart';

class PetDetailPage extends StatefulWidget {
  final PetModel pet;

  const PetDetailPage({super.key, required this.pet});

  @override
  _PetDetailPageState createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {
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
      body: ListView(
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
          // Hayvan bilgisi
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

                    petViewModel.updatePet(pet.id, updatedPet);
                  }
                },
                child: const Text('Güncelle'),
              ),
              ElevatedButton(
                onPressed: () {
                  final index = petViewModel.pets.indexOf(pet);
                  if (index != -1) {
                    petViewModel.deletePet(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Evcil hayvan bilgisi başarıyla silindi'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Sil'),
              ),
            ],
          ),
          // Beslenme
          ListTile(
            title: const Text("Beslenme"),
            subtitle: const Text("Beslenme düzenini yönet"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedingPage(pet: pet),
                ),
              );
            },
          ),
          const Divider(),
          // Sağlık Kaydı
          ListTile(
            title: const Text("Sağlık Kayıtları"),
            subtitle: const Text("Veteriner ziyaretleri ve sağlık durumu"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HealthRecordPage(pet: pet),
                ),
              );
            },
          ),
          const Divider(),
          // Hatırlatıcılar
          ListTile(
            title: const Text("Hatırlatıcılar"),
            subtitle: const Text("Yemek, ilaç, egzersiz hatırlatıcıları"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReminderPage(pet: pet),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
