import 'package:freezed_annotation/freezed_annotation.dart';
part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({String? word, @Default([]) List<String> guesses}) = _GameState;

  factory GameState.initial() => const GameState();
  factory GameState.inProgress({required String word, List<String> guesses = const []}) =>
      GameState(word: word, guesses: guesses);
  factory GameState.win() => const GameState();
  factory GameState.lose() => const GameState();
}
