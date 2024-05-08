import 'package:fluttle/state/game_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:word_generator/word_generator.dart';

class GameStateProvider extends StateNotifier<GameState> {
  GameStateProvider() : super(GameState.initial());

  final _wordGenerator = WordGenerator();

  void initialiseGame() {
    state = GameState.inProgress(word: _getRandomWord);
  }

  void submitGuess([String? guess]) {
    if (state.word == null) {
      initialiseGame();
    }
    final existingGuesses = List<String>.from(state.guesses);

    if (guess == null) {
      existingGuesses.add(_getRandomWord);
    } else {
      existingGuesses.add(guess);
    }
    // if (guess == state.word) {
    //   state = GameState.win();
    // } else if (state.guesses.length >= 6) {
    //   state = GameState.lose();
    // }
    state = GameState.inProgress(word: state.word!, guesses: existingGuesses);
  }

  String get _getRandomWord {
    String newWord = '';

    while (newWord.length != 5) {
      newWord = _wordGenerator.randomNoun();
    }

    return newWord;
  }
}
