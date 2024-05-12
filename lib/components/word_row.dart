import 'package:flutter/material.dart';
import 'package:fluttle/components/letter_tile.dart';
import 'package:fluttle/state/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordRow extends HookConsumerWidget {
  const WordRow(this.guess, {super.key});

  final String guess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateNotifierProvider);

    final letters = <Widget>[];

    for (int i = 0; i < guess.characters.length; i++) {
      final letter = guess.characters.toList()[i];

      letters.add(
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: LetterTile(
            letter,
            isInCorrectLocation: letter == gameState.word?[i],
            wordContainsLetter: gameState.word?.contains(letter) ?? false,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: letters,
    );
  }
}
