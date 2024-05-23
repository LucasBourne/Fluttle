import 'dart:ui';

import 'package:fluttle/repos/random_word_interface.dart';
import 'package:fluttle/state/game_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scrabble_word_checker/scrabble_word_checker.dart';

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier(this._randomWordRepo) : super(GameState.initial());

  final RandomWordInterface _randomWordRepo;

  final _wordChecker = ScrabbleWordChecker(language: ScrabbleLanguage.english);

  void initialiseGame() {
    state = GameState.inProgress(
      word: _randomWordRepo.generateRandomWord(),
      guesses: [],
    );
  }

  void submitGuess({
    required void Function(String word) onLose,
    required void Function(int rounds) onWin,
    required VoidCallback onValidWord,
    String? guess,
    VoidCallback? onInvalidWord,
  }) {
    if (state.word == null) {
      initialiseGame();
    }
    final existingGuesses = List<String>.from(state.guesses);

    if (guess != null && guess.length < 5) {
      onInvalidWord?.call();
      return;
    }

    final guessToSubmit = (guess?.substring(0, 5) ??
            _randomWordRepo.generateRandomWord(
              invalidLetters: state.submittedKeys?.blackKeys,
            ))
        .toLowerCase();

    if (!_wordChecker.isValidWord(guessToSubmit)) {
      onInvalidWord?.call();
      return;
    }

    onValidWord.call();

    existingGuesses.add(guessToSubmit);

    final newGreenKeys =
        List<String>.from(state.submittedKeys?.greenKeys ?? []);
    final newYellowKeys =
        List<String>.from(state.submittedKeys?.yellowKeys ?? []);
    final newBlackKeys =
        List<String>.from(state.submittedKeys?.blackKeys ?? []);

    for (var i = 0; i < guessToSubmit.length; i++) {
      final guessLetter = guessToSubmit[i];
      if (state.word![i] == guessLetter) {
        newGreenKeys.add(guessLetter);
      } else if (state.word!.contains(guessLetter)) {
        newYellowKeys.add(guessLetter);
      } else {
        newBlackKeys.add(guessLetter);
      }
    }
    if (guessToSubmit == state.word) {
      onWin.call(state.guesses.length);
      state = GameState.win();
      return;
    } else if (state.guesses.length >= 6) {
      onLose.call(state.word!);
      state = GameState.lose();
      return;
    }
    state = GameState.inProgress(
      word: state.word!,
      guesses: existingGuesses,
      submittedKeys: SubmittedKeys(
        greenKeys: newGreenKeys,
        yellowKeys: newYellowKeys,
        blackKeys: newBlackKeys,
      ),
    );
  }
}
