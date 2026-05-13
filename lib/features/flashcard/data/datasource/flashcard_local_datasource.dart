import 'package:hive/hive.dart';

import '../models/flashcard_model.dart';

class FlashcardLocalDataSource {
  final Box<FlashcardModel> flashcardBox = Hive.box<FlashcardModel>(
    'flashcards',
  );

  // Get all flashcards
  List<FlashcardModel> getFlashcards() {
    return flashcardBox.values.toList();
  }

  // Add flashcard
  Future<void> addFlashcard(FlashcardModel flashcard) async {
    await flashcardBox.add(flashcard);
  }

  // Delete flashcard
  Future<void> deleteFlashcard(int index) async {
    await flashcardBox.deleteAt(index);
  }

  // Update flashcard
  Future<void> updateFlashcard(int index, FlashcardModel flashcard) async {
    await flashcardBox.putAt(index, flashcard);
  }
}
