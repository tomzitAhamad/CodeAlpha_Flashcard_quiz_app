import 'package:flashcard_quiz_app/features/flashcard/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/flashcard_provider.dart';
import '../widgets/flashcard_widget.dart';

class FlashcardPage extends StatefulWidget {
  const FlashcardPage({super.key});

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FlashcardProvider>(context);

    final flashcards = provider.flashcards;

    return Scaffold(
      appBar: AppBar(title: const Text('Flashcard Quiz App')),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddFlashcardDialog(context);
        },

        child: const Icon(Icons.add),
      ),

      body: flashcards.isEmpty
          ? const Center(
              child: Text(
                'No Flashcards Yet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  /// Flashcard Widget
                  FlashcardWidget(
                    question: flashcards[provider.currentIndex].question,

                    answer: flashcards[provider.currentIndex].answer,
                  ),

                  const SizedBox(height: 30),

                  /// Navigation Buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Previous',

                          icon: Icons.arrow_back,

                          onPressed: () {
                            provider.previousCard();
                          },
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: CustomButton(
                          text: 'Next',

                          icon: Icons.arrow_forward,

                          onPressed: () {
                            provider.nextCard();
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Delete Button
                  CustomButton(
                    text: 'Delete Flashcard',

                    icon: Icons.delete,

                    backgroundColor: Colors.red,

                    onPressed: () async {
                      await provider.deleteFlashcard(provider.currentIndex);
                    },
                  ),

                  const SizedBox(height: 12),

                  /// Edit Button
                  CustomButton(
                    text: 'Edit Flashcard',

                    icon: Icons.edit,

                    backgroundColor: Colors.orange,

                    onPressed: () {
                      final currentCard = flashcards[provider.currentIndex];

                      _showEditFlashcardDialog(
                        context,

                        provider.currentIndex,

                        currentCard.question,

                        currentCard.answer,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  /// Add Flashcard Dialog
  void _showAddFlashcardDialog(BuildContext context) {
    final questionController = TextEditingController();

    final answerController = TextEditingController();

    showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          title: const Text('Add Flashcard'),

          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              TextField(
                controller: questionController,

                decoration: const InputDecoration(labelText: 'Question'),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: answerController,

                decoration: const InputDecoration(labelText: 'Answer'),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () async {
                final question = questionController.text.trim();

                final answer = answerController.text.trim();

                if (question.isNotEmpty && answer.isNotEmpty) {
                  await Provider.of<FlashcardProvider>(
                    context,
                    listen: false,
                  ).addFlashcard(question, answer);

                  Navigator.pop(context);
                }
              },

              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  /// Edit Flashcard Dialog
  void _showEditFlashcardDialog(
    BuildContext context,
    int index,
    String currentQuestion,
    String currentAnswer,
  ) {
    final questionController = TextEditingController(text: currentQuestion);

    final answerController = TextEditingController(text: currentAnswer);

    showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          title: const Text('Edit Flashcard'),

          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              TextField(
                controller: questionController,

                decoration: const InputDecoration(labelText: 'Question'),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: answerController,

                decoration: const InputDecoration(labelText: 'Answer'),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () async {
                final updatedQuestion = questionController.text.trim();

                final updatedAnswer = answerController.text.trim();

                if (updatedQuestion.isNotEmpty && updatedAnswer.isNotEmpty) {
                  await Provider.of<FlashcardProvider>(
                    context,
                    listen: false,
                  ).updateFlashcard(index, updatedQuestion, updatedAnswer);

                  Navigator.pop(context);
                }
              },

              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
