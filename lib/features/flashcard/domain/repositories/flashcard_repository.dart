import '../entities/flashcard_entity.dart';

abstract class FlashcardRepository {
  List<FlashcardEntity> getFlashcards();

  Future<void> addFlashcard(FlashcardEntity flashcard);

  Future<void> deleteFlashcard(int index);

  Future<void> updateFlashcard(int index, FlashcardEntity flashcard);
}
