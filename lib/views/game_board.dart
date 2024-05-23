import 'package:flutter/material.dart';
import 'package:fluttle/components/keyboard.dart';
import 'package:fluttle/components/guess_text_field.dart';
import 'package:fluttle/components/word_board.dart';
import 'package:fluttle/state/providers.dart';
import 'package:fluttle/views/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameBoard extends HookConsumerWidget {
  GameBoard({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ref.read(gameStateNotifierProvider.notifier).submitGuess(
                  onLose: (word) => _showLoseState(context, word),
                  onWin: (guessCount) => _showWinState(context, guessCount),
                  onValidWord: () => _controller.clear(),
                ),
        tooltip: 'Stuck? Try a random word',
        child: const Icon(Icons.casino_rounded),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 120, top: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => ref
                            .read(gameStateNotifierProvider.notifier)
                            .initialiseGame(),
                        child: const Icon(Icons.refresh),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        ),
                        child: const Icon(Icons.home),
                      ),
                    ],
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
                    child: GuessTextField(
                      _controller,
                      () => _submitGuess(ref, context),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _submitGuess(ref, context),
                    child: const Text('submit'),
                  )
                ],
              ),
            ),
            Keyboard(_controller),
          ],
        ),
      ),
    );
  }

  void _submitGuess(WidgetRef ref, BuildContext context) {
    ref.read(gameStateNotifierProvider.notifier).submitGuess(
          guess: _controller.value.text,
          onInvalidWord: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Please enter a valid 5 letter word',
                ),
                backgroundColor: Colors.amber,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          onValidWord: () => _controller.clear(),
          onLose: (word) {
            _showLoseState(context, word);
          },
          onWin: (guessCount) async {
            _showWinState(context, guessCount);
          },
        );
  }

  void _showLoseState(BuildContext context, String word) {
    _controller.clear();
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('You Lost!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Game over! The word was: \'$word\''),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Play again'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Go home'),
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showWinState(BuildContext context, int guessCount) {
    _controller.clear();
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('You Won!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Congratulations! You guessed the word in $guessCount ${guessCount == 1 ? 'guess' : 'guesses'}.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Play again'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Go home'),
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
