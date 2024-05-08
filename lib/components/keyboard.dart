import 'package:flutter/material.dart';
import 'package:fluttle/state/game_state.dart';
import 'package:fluttle/state/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Keyboard extends HookConsumerWidget {
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameStateNotifierProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTopRow(state),
        _buildMiddleRow(state),
        _buildBottomRow(state),
      ],
    );
  }

  Widget _buildTopRow(GameState state) {
    final letters = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'];
    return _buildRow(letters, state);
  }

  Widget _buildMiddleRow(GameState state) {
    final letters = ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'];
    return _buildRow(letters, state, leftOffset: 25);
  }

  Widget _buildBottomRow(GameState state) {
    final letters = ['z', 'x', 'c', 'v', 'b', 'n', 'm'];
    return _buildRow(letters, state, leftOffset: 50);
  }

  Widget _buildRow(List<String> letters, GameState state, {double? leftOffset}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leftOffset != null) SizedBox(width: leftOffset),
        ...letters
            .map(
              (letter) => Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  width: 65,
                  height: 85,
                  decoration: BoxDecoration(
                    color: _getColor(letter, state) ?? Colors.white,
                    border: Border.all(
                      color: Colors.white54,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Center(child: Text(letter)),
                ),
              ),
            )
            .toList(),
      ],
    );
  }

  Color? _getColor(String letter, GameState state) {
    if (state.submittedKeys[greenKeys]?.contains(letter) ?? false) {
      return Colors.green;
    } else if (state.submittedKeys[yellowKeys]?.contains(letter) ?? false) {
      return Colors.amber;
    } else if (state.submittedKeys[blackKeys]?.contains(letter) ?? false) {
      return Colors.grey;
    }

    return null;
  }
}
