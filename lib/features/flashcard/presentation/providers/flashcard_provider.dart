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

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  /// Load Flashcards
  void loadFlashcards() {
    _flashcards = repository.getFlashcards();

    // Prevent invalid index
    if (_currentIndex >= _flashcards.length) {
      _currentIndex = _flashcards.isEmpty ? 0 : _flashcards.length - 1;
    }

    notifyListeners();
  }

  /// Add Flashcard
  Future<void> addFlashcard(String question, String answer) async {
    final flashcard = FlashcardEntity(question: question, answer: answer);

    await repository.addFlashcard(flashcard);

    loadFlashcards();
  }

  /// Delete Flashcard
  Future<void> deleteFlashcard(int index) async {
    await repository.deleteFlashcard(index);

    loadFlashcards();

    // Extra safety
    if (_currentIndex >= _flashcards.length) {
      _currentIndex = _flashcards.isEmpty ? 0 : _flashcards.length - 1;
    }

    notifyListeners();
  }

  /// Update Flashcard
  Future<void> updateFlashcard(
    int index,
    String question,
    String answer,
  ) async {
    final flashcard = FlashcardEntity(question: question, answer: answer);

    await repository.updateFlashcard(index, flashcard);

    loadFlashcards();
  }

  /// Next Card
  void nextCard() {
    if (_currentIndex < _flashcards.length - 1) {
      _currentIndex++;

      notifyListeners();
    }
  }

  /// Previous Card
  void previousCard() {
    if (_currentIndex > 0) {
      _currentIndex--;

      notifyListeners();
    }
  }
}
