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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: guess.characters.map(
        (letter) {
          final letterIndex = guess.characters.toList().indexOf(letter);

          return LetterTile(
            letter,
            isInCorrectLocation: letter == gameState.word?[letterIndex],
            wordContainsLetter: gameState.word?.contains(letter) ?? false,
          );
        },
      ).toList(),
    );
  }
}
