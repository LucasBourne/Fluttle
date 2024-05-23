import 'package:flutter/material.dart';
import 'package:fluttle/components/keyboard.dart';
import 'package:fluttle/components/guess_text_field.dart';
import 'package:fluttle/components/word_board.dart';
import 'package:fluttle/state/providers.dart';
import 'package:fluttle/views/game_board.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Fluttle. Definitely not inspired by Wordle.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: ElevatedButton(
                onPressed: () {
                  ref.read(gameStateNotifierProvider.notifier).initialiseGame();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => GameBoard()),
                  );
                },
                child: const Text('Play'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
