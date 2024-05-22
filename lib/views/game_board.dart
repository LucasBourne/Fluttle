import 'package:flutter/material.dart';
import 'package:fluttle/components/keyboard.dart';
import 'package:fluttle/components/guess_text_field.dart';
import 'package:fluttle/components/word_board.dart';
import 'package:fluttle/state/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameBoard extends HookConsumerWidget {
  GameBoard({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 120, top: 48),
      child: Column(
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
                  'Round ${ref.watch(gameStateNotifierProvider).guesses.length + 1}',
                ),
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
                    ref.read(gameStateNotifierProvider.notifier).submitGuess(
                          guess: _controller.value.text,
                          onInvalidWord: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter a valid 5 letter word',
                                ),
                                backgroundColor: Colors.amber,
                              ),
                            );
                          },
                          onLose: (word) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'You lost! The word was: \'$word\'',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                          onWin: (guessCount) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'You won! It took you $guessCount guesses.',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                        );
                    _controller.clear();
                  },
                  child: const Text('submit'),
                )
              ],
            ),
          ),
          Keyboard(_controller),
        ],
      ),
    );
  }
}
