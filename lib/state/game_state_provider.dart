import 'package:fluttle/state/game_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:word_generator/word_generator.dart';

class GameStateProvider extends StateNotifier<GameState> {
  GameStateProvider() : super(GameState.initial());

  final _wordGenerator = WordGenerator();

  void initialiseGame() {
    String newWord = '';

    while (newWord.length != 5) {
      newWord = _wordGenerator.randomNoun();
    }

    state = GameState.inProgress(word: newWord);
  }

  void submitGuess(String guess) {
    final existingGuesses = List<String>.from(state.guesses);

    existingGuesses.add(guess);
    if (guess == state.word) {
      state = GameState.win();
    } else if (state.guesses.length >= 6) {
      state = GameState.lose();
    }
  }
}
