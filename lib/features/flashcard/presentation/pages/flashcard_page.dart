import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/flashcard_provider.dart';

class FlashcardPage extends StatefulWidget {
  const FlashcardPage({super.key});

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  bool showAnswer = false;

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
          ? const Center(child: Text('No Flashcards Yet'))
          : Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  // Flashcard
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),

                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,

                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Column(
                      children: [
                        Text(
                          flashcards[provider.currentIndex].question,

                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),

                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 20),

                        if (showAnswer)
                          Text(
                            flashcards[provider.currentIndex].answer,

                            style: const TextStyle(fontSize: 18),

                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showAnswer = !showAnswer;
                      });
                    },

                    child: Text(showAnswer ? 'Hide Answer' : 'Show Answer'),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      ElevatedButton(
                        onPressed: () {
                          provider.previousCard();

                          setState(() {
                            showAnswer = false;
                          });
                        },

                        child: const Text('Previous'),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          provider.nextCard();

                          setState(() {
                            showAnswer = false;
                          });
                        },

                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  // Add flashcard dialog
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

              const SizedBox(height: 10),

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
}
