import 'package:hive/hive.dart';

import '../../domain/entities/flashcard_entity.dart';

part 'flashcard_model.g.dart';

@HiveType(typeId: 0)
class FlashcardModel extends FlashcardEntity {
  @HiveField(0)
  final String question;

  @HiveField(1)
  final String answer;

  FlashcardModel({required this.question, required this.answer})
    : super(question: question, answer: answer);
}
