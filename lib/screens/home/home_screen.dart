import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_tracker_app/widgets/app_header.dart';
import 'package:pet_tracker_app/widgets/custom_button.dart';
import '../../base/viewmodels/pet_view_model.dart';
import 'add_pet_screen.dart';
import 'pet_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final petViewModel = Provider.of<PetViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(
              title: 'Evcil Hayvan Takip',
              subtitle: 'Evcil hayvanlarınızı kolayca yönetin',
            ),
            Expanded(
              child: petViewModel.pets.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Henüz evcil hayvan eklenmedi.',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: 'Evcil Hayvan Ekle',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddPetScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: petViewModel.pets.length,
                      itemBuilder: (context, index) {
                        final pet = petViewModel.pets[index];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: pet.photoUrl.isNotEmpty
                                ? FileImage(File(pet.photoUrl))
                                : null,
                            child: pet.photoUrl.isEmpty
                                ? const Icon(Icons.pets)
                                : null,
                          ),
                          title: Text(pet.name),
                          subtitle: Text('${pet.type} - ${pet.breed}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PetDetailPage(pet: pet),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPetScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
