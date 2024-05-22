// ignore_for_file: prefer_const_constructors
import 'package:freezed_annotation/freezed_annotation.dart';
part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    String? word,
    SubmittedKeys? submittedKeys,
    @Default([]) List<String> guesses,
  }) = _GameState;

  factory GameState.initial() => GameState();
  factory GameState.inProgress({
    required String word,
    List<String> guesses = const [],
    SubmittedKeys submittedKeys = const SubmittedKeys(),
  }) =>
      GameState(word: word, guesses: guesses, submittedKeys: submittedKeys);
  factory GameState.win() => GameState();
  factory GameState.lose() => GameState();
}

class SubmittedKeys {
  const SubmittedKeys({
    this.greenKeys = const [],
    this.yellowKeys = const [],
    this.blackKeys = const [],
  });

  final List<String> greenKeys;
  final List<String> yellowKeys;
  final List<String> blackKeys;
}
