import 'package:flashcard_quiz_app/features/flashcard/data/datasource/flashcard_local_datasource.dart';
import 'package:flashcard_quiz_app/features/flashcard/data/models/flashcard_model.dart';

import '../../domain/entities/flashcard_entity.dart';
import '../../domain/repositories/flashcard_repository.dart';

class FlashcardRepositoryImpl implements FlashcardRepository {
  final FlashcardLocalDataSource localDataSource;

  FlashcardRepositoryImpl(this.localDataSource);

  @override
  List<FlashcardEntity> getFlashcards() {
    return localDataSource.getFlashcards();
  }

  @override
  Future<void> addFlashcard(FlashcardEntity flashcard) async {
    final model = FlashcardModel(
      question: flashcard.question,
      answer: flashcard.answer,
    );

    await localDataSource.addFlashcard(model);
  }

  @override
  Future<void> deleteFlashcard(int index) async {
    await localDataSource.deleteFlashcard(index);
  }

  @override
  Future<void> updateFlashcard(int index, FlashcardEntity flashcard) async {
    final model = FlashcardModel(
      question: flashcard.question,
      answer: flashcard.answer,
    );

    await localDataSource.updateFlashcard(index, model);
  }
}
