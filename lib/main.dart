import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttle/components/word_board.dart';
import 'package:fluttle/state/providers.dart';
import 'package:fluttle/views/game_board.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluttle',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fluttle'),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useState(
      () {
        ref.read(gameStateNotifierProvider.notifier).initialiseGame();

        return null;
      },
    );

    return Scaffold(
      body: const GameBoard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(gameStateNotifierProvider.notifier).submitGuess(),
        tooltip: 'Stuck? Try a random word',
        child: const Icon(Icons.casino_rounded),
      ),
    );
  }
}
