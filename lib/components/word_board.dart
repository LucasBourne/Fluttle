import 'package:flutter/cupertino.dart';
import 'package:fluttle/components/word_row.dart';
import 'package:fluttle/state/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WordBoard extends HookConsumerWidget {
  const WordBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guesses = ref.watch(gameStateNotifierProvider).guesses;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: guesses.map((guess) => WordRow(guess)).toList(),
    );
  }
}
