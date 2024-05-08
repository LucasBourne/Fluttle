import 'package:fluttle/repos/random_word_repo.dart';
import 'package:fluttle/state/game_state.dart';
import 'package:fluttle/state/game_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _randomWordRepoProvider = Provider((ref) => RandomWordRepo());

final gameStateNotifierProvider = StateNotifierProvider<GameStateNotifier, GameState>(
  (ref) => GameStateNotifier(ref.watch(_randomWordRepoProvider)),
);
