import 'package:freezed_annotation/freezed_annotation.dart';
part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    String? word,
    @Default([]) List<String> guesses,
    @Default({
      greenKeys: [],
      yellowKeys: [],
      blackKeys: [],
    })
    Map<String, List<String>> submittedKeys,
  }) = _GameState;

  factory GameState.initial() => const GameState();
  factory GameState.inProgress({
    required String word,
    List<String> guesses = const [],
    Map<String, List<String>> submittedKeys = const {
      greenKeys: [],
      yellowKeys: [],
      blackKeys: [],
    },
  }) =>
      GameState(word: word, guesses: guesses, submittedKeys: submittedKeys);
  factory GameState.win() => const GameState();
  factory GameState.lose() => const GameState();
}

const greenKeys = 'greenKeys';
const yellowKeys = 'yellowKeys';
const blackKeys = 'blackKeys';
