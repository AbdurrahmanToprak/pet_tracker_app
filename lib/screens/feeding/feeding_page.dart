import 'package:flutter/material.dart';
import '../../models/pet_model.dart';
import '../../base/viewmodels/feeding_view_model.dart';
import 'package:provider/provider.dart';

import 'add_feeding_page.dart';

class FeedingPage extends StatelessWidget {
  final PetModel pet;

  FeedingPage({required this.pet});

  @override
  Widget build(BuildContext context) {
    final feedingViewModel = Provider.of<FeedingViewModel>(context);
    final feedings = feedingViewModel.getFeedingsForPet(pet.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('${pet.name} Beslenme Kaydı'),
      ),
      body: feedings.isEmpty
          ? Center(child: Text('Henüz bir beslenme kaydı yok.'))
          : ListView.builder(
              itemCount: feedings.length,
              itemBuilder: (context, index) {
                final feeding = feedings[index];
                return Card(
                  child: ListTile(
                    title: Text(feeding.foodType),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Miktar: ${feeding.amount}, Su: ${feeding.hasWater ? "Verildi" : "Verilmedi"}',
                        ),
                        Text(
                          'Tarih: ${feeding.mealTime.day}/${feeding.mealTime.month}/${feeding.mealTime.year} ${feeding.mealTime.hour}:${feeding.mealTime.minute}',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            feedingViewModel.deleteFeeding(feeding.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Beslenme kaydı silindi')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFeedingPage(pet: pet)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
