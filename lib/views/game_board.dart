import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttle/components/keyboard.dart';
import 'package:fluttle/components/text_field.dart';
import 'package:fluttle/components/word_board.dart';
import 'package:fluttle/state/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameBoard extends HookConsumerWidget {
  GameBoard({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => ref
                    .read(gameStateNotifierProvider.notifier)
                    .initialiseGame(),
                child: const Icon(Icons.refresh),
              ),
              Text(
                  'Round ${ref.watch(gameStateNotifierProvider).guesses.length + 1}'),
            ],
          ),
        ),
        const Expanded(
          child: SingleChildScrollView(
            reverse: true,
            child: WordBoard(),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8),
          child: Divider(thickness: 3),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: GuessTextField(_controller),
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(gameStateNotifierProvider.notifier)
                      .submitGuess(_controller.value.text);
                  _controller.clear();
                },
                child: Text('submit'),
              )
            ],
          ),
        ),
        Keyboard(_controller),
      ],
    );
  }
}
