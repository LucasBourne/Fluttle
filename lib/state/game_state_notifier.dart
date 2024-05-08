import 'package:fluttle/repos/random_word_interface.dart';
import 'package:fluttle/state/game_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier(this._randomWordRepo) : super(GameState.initial());

  final RandomWordInterface _randomWordRepo;

  void initialiseGame() {
    state = GameState.inProgress(
      word: _randomWordRepo.generateRandomWord(),
      guesses: [],
      submittedKeys: {greenKeys: [], yellowKeys: [], blackKeys: []},
    );
  }

  void submitGuess([String? guess]) {
    if (state.word == null) {
      initialiseGame();
    }
    final existingGuesses = List<String>.from(state.guesses);
    final randomWord = _randomWordRepo.generateRandomWord();

    if (guess == null) {
      existingGuesses.add(randomWord);
    } else {
      existingGuesses.add(guess);
    }

    final newSubmittedKeys = Map<String, List<String>>.from(state.submittedKeys);

    for (var i = 0; i < randomWord.length; i++) {
      final guessLetter = randomWord[i];
      if (state.word![i] == guessLetter) {
        newSubmittedKeys[greenKeys]!.add(guessLetter);
      } else if (state.word!.contains(guessLetter)) {
        newSubmittedKeys[yellowKeys]!.add(guessLetter);
      } else {
        newSubmittedKeys[blackKeys]!.add(guessLetter);
      }
    }
    // if (guess == state.word) {
    //   state = GameState.win();
    // } else if (state.guesses.length >= 6) {
    //   state = GameState.lose();
    // }
    state = GameState.inProgress(
      word: state.word!,
      guesses: existingGuesses,
      submittedKeys: newSubmittedKeys,
    );
  }
}
