import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class FlashcardWidget extends StatelessWidget {
  final String question;
  final String answer;

  const FlashcardWidget({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    final controller = FlipCardController();

    return Column(
      children: [
        SizedBox(
          height: 320,

          child: FlipCard(
            rotateSide: RotateSide.right,

            controller: controller,

            axis: FlipAxis.vertical,

            frontWidget: _buildFrontCard(),

            backWidget: _buildBackCard(),
          ),
        ),

        const SizedBox(height: 20),

        ElevatedButton.icon(
          onPressed: () {
            controller.flipcard();
          },

          icon: const Icon(Icons.flip),

          label: const Text('Flip Card'),
        ),
      ],
    );
  }

  Widget _buildFrontCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade700],
        ),

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),

            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Icon(Icons.help_outline, color: Colors.white, size: 60),

          const SizedBox(height: 20),

          Text(
            question,

            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),

            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade400, Colors.green.shade700],
        ),

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),

            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Icon(Icons.lightbulb_outline, color: Colors.white, size: 60),

          const SizedBox(height: 20),

          Text(
            answer,

            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),

            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
