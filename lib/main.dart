import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'base/services/reminder/notification_service.dart';
import 'base/viewmodels/feeding_view_model.dart';
import 'base/viewmodels/health_record_view_model.dart';
import 'base/viewmodels/pet_view_model.dart';
import 'base/viewmodels/reminder_view_model.dart';
import 'models/feeding_model.dart';
import 'models/health_record_model.dart';
import 'models/pet_model.dart';
import 'models/reminder_model.dart';
import 'screens/home/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await NotificationService.requestPermissions();

  tz.initializeTimeZones();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  Hive.registerAdapter(PetModelAdapter());
  Hive.registerAdapter(FeedingModelAdapter());
  Hive.registerAdapter(HealthRecordModelAdapter());
  Hive.registerAdapter(ReminderModelAdapter());

  await Future.wait([
    Hive.openBox<PetModel>('pets'),
    Hive.openBox<FeedingModel>('feedings'),
    Hive.openBox<HealthRecordModel>('healthRecords'),
    Hive.openBox<ReminderModel>('reminders'),
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FeedingViewModel()),
        ChangeNotifierProvider(create: (_) => HealthRecordViewModel()),
        ChangeNotifierProvider(create: (_) => PetViewModel()),
        ChangeNotifierProvider(create: (_) => ReminderViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evcil Hayvan Takip',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
