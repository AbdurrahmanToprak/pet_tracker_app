import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'base/viewmodels/pet_view_model.dart';
import 'models/feeding_model.dart';
import 'models/health_record_model.dart';
import 'models/pet_model.dart';
import 'models/reminder_model.dart';
import 'screens/home/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(PetModelAdapter());
  Hive.registerAdapter(FeedingModelAdapter());
  Hive.registerAdapter(HealthRecordModelAdapter());
  Hive.registerAdapter(ReminderModelAdapter());

  await Hive.openBox<PetModel>('pets');
  await Hive.openBox<FeedingModel>('feedings');
  await Hive.openBox<HealthRecordModel>('healthRecords');
  await Hive.openBox<ReminderModel>('reminders');
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
