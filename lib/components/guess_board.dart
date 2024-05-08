import 'package:flutter/cupertino.dart';
import 'package:fluttle/components/word_row.dart';

class WordBoard extends StatelessWidget {
  const WordBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // Grab guesses
    final guesses = ['yeast', 'build', 'crown'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: guesses.map((guess) => WordRow(guess)).toList(),
    );
  }
}
