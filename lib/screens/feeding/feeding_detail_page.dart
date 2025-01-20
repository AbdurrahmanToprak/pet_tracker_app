import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/pet_model.dart';
import '../../models/feeding_model.dart';
import '../../base/viewmodels/feeding_view_model.dart';
import 'update_feeding_page.dart';

class FeedingDetailPage extends StatefulWidget {
  final PetModel pet;
  final FeedingModel feeding;

  const FeedingDetailPage({
    super.key,
    required this.pet,
    required this.feeding,
  });

  @override
  _FeedingDetailPageState createState() => _FeedingDetailPageState();
}

class _FeedingDetailPageState extends State<FeedingDetailPage> {
  late FeedingModel feeding;

  @override
  void initState() {
    super.initState();
    feeding = widget.feeding; // Başlangıçta mevcut beslenme kaydını al
  }

  @override
  Widget build(BuildContext context) {
    final feedingViewModel = Provider.of<FeedingViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beslenme Detayı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Yemek Türü: ${feeding.foodType}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Miktar: ${feeding.amount} gram',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Su: ${feeding.hasWater ? "Verildi" : "Verilmedi"}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text(
              'Tarih: ${feeding.mealTime.day}/${feeding.mealTime.month}/${feeding.mealTime.year} ${feeding.mealTime.hour}:${feeding.mealTime.minute}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Güncelle'),
                  onPressed: () {
                    // UpdateFeedingPage'e yönlendirme
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateFeedingPage(
                          pet: widget.pet,
                          feeding: feeding,
                        ),
                      ),
                    ).then((_) {
                      // Güncelleme işlemi tamamlandıktan sonra sayfayı yeniden yükleyin
                      // Yemek kaydını güncellemek için güncel veriyi alıyoruz
                      final updatedFeeding = feedingViewModel
                          .getFeedingsForPet(widget.pet.id)
                          .firstWhere((f) => f.id == feeding.id);
                      setState(() {
                        feeding = updatedFeeding;
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
                    feedingViewModel.deleteFeeding(feeding.id);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Beslenme kaydı silindi')),
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
