import 'package:flutter/material.dart';
import 'package:fluttle/components/letter_tile.dart';
import 'package:fluttle/state/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordRow extends HookConsumerWidget {
  const WordRow(this.guess, {super.key});

  final String guess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final letters = <Widget>[];

    for (int i = 0; i < guess.characters.length; i++) {
      final letter = guess.characters.toList()[i];

      letters.add(
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: LetterTile(
            letter,
            color: _getColor(ref, guess, i),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: letters,
    );
  }

  Color _getColor(WidgetRef ref, String guess, int guessIndex) {
    final gameState = ref.watch(gameStateNotifierProvider);
    final word = gameState.word;
    final guessLetter = guess[guessIndex];

    if (word![guessIndex] == guessLetter) {
      return Colors.green;
    } else if (word.contains(guessLetter)) {
      // Get indexes of all occurrences of letter
      final letterOccurrences = _getLetterOccurrenceIndexes(word, guessLetter);
      final guessOccurrences = _getLetterOccurrenceIndexes(guess, guessLetter);

      // If only one occurrence, safe to return here
      if (letterOccurrences.length == 1 && guessOccurrences.length == 1) {
        return Colors.amber;
      }

      // Else, check current position relative to the rest of the guessed letters
      int greenOccurrenceCount = 0;
      for (int i = 0; i < guess.length; i++) {
        if (guess[i] == word[i]) {
          greenOccurrenceCount++;
        }
      }

      if (greenOccurrenceCount < letterOccurrences.length) {
        return Colors.amber;
      }
    }

    return Colors.black12;
  }

  List<int> _getLetterOccurrenceIndexes(String word, String letter) {
    final indexes = <int>[];

    for (int i = 0; i < word.length; i++) {
      if (word[i] == letter) {
        indexes.add(i);
      }
    }

    return indexes;
  }
}
