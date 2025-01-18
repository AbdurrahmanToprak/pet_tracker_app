import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base/viewmodels/pet_view_model.dart';
import 'models/pet_model.dart';
import 'screens/home/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter(); // Hive'ı başlat

  // Hive modelinizin adapter'ını kaydedin
  Hive.registerAdapter(PetModelAdapter());
  await Hive.openBox<PetModel>('pets');
  runApp(
    ChangeNotifierProvider(
      create: (context) => PetViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evcil Hayvan Takip',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
