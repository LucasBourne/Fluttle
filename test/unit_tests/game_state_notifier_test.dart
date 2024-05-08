import 'package:flutter_test/flutter_test.dart';
import 'package:fluttle/repos/random_word_interface.dart';
import 'package:fluttle/state/game_state.dart';
import 'package:fluttle/state/game_state_notifier.dart';
import 'package:mocktail/mocktail.dart';

class RandomWordRepo extends Mock implements RandomWordInterface {}

void main() {
  final randomWordRepo = RandomWordRepo();
  final gameSN = GameStateNotifier(randomWordRepo);

  group(
    'initialiseGame()',
    () {
      test(
        'Everything is reset when initialised',
        () {
          when(() => randomWordRepo.generateRandomWord()).thenReturn('house');

          gameSN.initialiseGame();

          expect(
            gameSN.state,
            const GameState(
              word: 'house',
              guesses: [],
              submittedKeys: {'greenKeys': [], 'yellowKeys': [], 'blackKeys': []},
            ),
          );
        },
      );
    },
  );
}
