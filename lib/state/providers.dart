import 'package:fluttle/state/game_state.dart';
import 'package:fluttle/state/game_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final gameStateNotifierProvider = StateNotifierProvider<GameStateProvider, GameState>(
  (ref) => GameStateProvider(),
);
