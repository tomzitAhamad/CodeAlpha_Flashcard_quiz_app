import 'package:flutter/material.dart';

import '../../domain/entities/flashcard_entity.dart';
import '../../domain/repositories/flashcard_repository.dart';

class FlashcardProvider extends ChangeNotifier {
  final FlashcardRepository repository;

  FlashcardProvider(this.repository);

  List<FlashcardEntity> _flashcards = [];

  List<FlashcardEntity> get flashcards => _flashcards;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  // Load flashcards
  void loadFlashcards() {
    _flashcards = repository.getFlashcards();
    notifyListeners();
  }

  // Add flashcard
  Future<void> addFlashcard(String question, String answer) async {
    final flashcard = FlashcardEntity(question: question, answer: answer);

    await repository.addFlashcard(flashcard);

    loadFlashcards();
  }

  // Delete flashcard
  Future<void> deleteFlashcard(int index) async {
    await repository.deleteFlashcard(index);

    loadFlashcards();
  }

  // Update flashcard
  Future<void> updateFlashcard(
    int index,
    String question,
    String answer,
  ) async {
    final flashcard = FlashcardEntity(question: question, answer: answer);

    await repository.updateFlashcard(index, flashcard);

    loadFlashcards();
  }

  // Next card
  void nextCard() {
    if (_currentIndex < _flashcards.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  // Previous card
  void previousCard() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }
}
