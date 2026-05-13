import 'package:flashcard_quiz_app/features/flashcard/data/datasource/flashcard_local_datasource.dart';
import 'package:flashcard_quiz_app/features/flashcard/domain/repositories/flashcard_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'features/flashcard/data/models/flashcard_model.dart';

import 'features/flashcard/presentation/pages/flashcard_page.dart';
import 'features/flashcard/presentation/providers/flashcard_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(FlashcardModelAdapter());

  await Hive.openBox<FlashcardModel>('flashcards');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localDataSource = FlashcardLocalDataSource();

    final repository = FlashcardRepositoryImpl(localDataSource);

    return ChangeNotifierProvider(
      create: (_) => FlashcardProvider(repository)..loadFlashcards(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Flashcard Quiz App',

        theme: ThemeData(primarySwatch: Colors.blue),

        home: const FlashcardPage(),
      ),
    );
  }
}
