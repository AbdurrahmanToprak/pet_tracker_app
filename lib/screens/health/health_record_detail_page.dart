import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/health_record_model.dart';
import '../../models/pet_model.dart';
import '../../base/viewmodels/health_record_view_model.dart';
import 'update_health_record_page.dart';

class HealthRecordDetailPage extends StatefulWidget {
  final PetModel pet;
  final HealthRecordModel record;

  const HealthRecordDetailPage({
    super.key,
    required this.pet,
    required this.record,
  });

  @override
  State<HealthRecordDetailPage> createState() => _HealthRecordDetailPageState();
}

class _HealthRecordDetailPageState extends State<HealthRecordDetailPage> {
  late HealthRecordModel record;

  @override
  void initState() {
    super.initState();
    record = widget.record;
  }

  @override
  Widget build(BuildContext context) {
    final healthRecordViewModel = Provider.of<HealthRecordViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sağlık Kaydı Detayı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Doktor: ${record.doctorName}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Ziyaret Tarihi: ${record.visitDate.toLocal()}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Açıklama: ${record.description}',
                style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Güncelle'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateHealthRecordPage(
                          pet: widget.pet,
                          record: record,
                        ),
                      ),
                    ).then((_) {
                      final updatedHealthRecord = healthRecordViewModel
                          .getHealthRecordsForPet(widget.pet.id)
                          .firstWhere((h) => h.id == record.id);
                      setState(() {
                        record = updatedHealthRecord;
                      });
                    });
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Sil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    healthRecordViewModel.deleteHealthRecord(record.id);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sağlık kaydı silindi')),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
