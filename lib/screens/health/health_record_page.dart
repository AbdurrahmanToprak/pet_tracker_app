import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/health_record_model.dart';
import '../../models/pet_model.dart';
import '../../base/viewmodels/health_record_view_model.dart';
import 'add_health_record_page.dart';

class HealthRecordPage extends StatelessWidget {
  final PetModel pet;

  const HealthRecordPage({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final healthRecordViewModel = Provider.of<HealthRecordViewModel>(context);
    final petHealthRecords =
        healthRecordViewModel.getHealthRecordsForPet(pet.id);

    return Scaffold(
      appBar: AppBar(title: Text('${pet.name} Sağlık Kayıtları')),
      body: petHealthRecords.isEmpty
          ? Center(child: Text('Henüz bir sağlık kaydı yok.'))
          : ListView.builder(
              itemCount: petHealthRecords.length,
              itemBuilder: (context, index) {
                final record = petHealthRecords[index];
                return Card(
                  child: ListTile(
                    title: Text('Doktor: ${record.doctorName}'),
                    subtitle:
                        Text('Ziyaret Tarihi: ${record.visitDate.toLocal()}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        healthRecordViewModel.deleteHealthRecord(record.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sağlık kaydı silindi')),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddHealthRecordPage(pet: pet),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
