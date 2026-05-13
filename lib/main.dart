import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/flashcard/data/models/flashcard_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register model adapter
  Hive.registerAdapter(FlashcardModelAdapter());

  // Open flashcard database box
  await Hive.openBox<FlashcardModel>('flashcards');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcard Quiz App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Flashcard App')),
        body: const Center(child: Text('Hive initialized successfully')),
      ),
    );
  }
}
