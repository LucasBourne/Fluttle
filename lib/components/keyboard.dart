import 'package:flutter/material.dart';
import 'package:fluttle/state/game_state.dart';
import 'package:fluttle/state/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Keyboard extends HookConsumerWidget {
  const Keyboard(this.controller, {super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameStateNotifierProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTopRow(context, state),
        _buildMiddleRow(context, state),
        _buildBottomRow(context, state),
      ],
    );
  }

  Widget _buildTopRow(BuildContext context, GameState state) {
    final letters = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'];
    return _buildRow(context, letters, state);
  }

  Widget _buildMiddleRow(BuildContext context, GameState state) {
    final letters = ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'];
    return _buildRow(context, letters, state, leftOffset: 25);
  }

  Widget _buildBottomRow(BuildContext context, GameState state) {
    final letters = ['z', 'x', 'c', 'v', 'b', 'n', 'm'];
    return _buildRow(
      context,
      letters,
      state,
      leftOffset: 50,
      trailing: _KeyboardKey(
        gameState: state,
        controller: controller,
        icon: Icons.backspace,
        onTap: () {
          final textLength = controller.text.length;
          if (textLength == 0) {
            return;
          }
          controller.text = controller.text.substring(0, textLength - 1);
        },
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    List<String> letters,
    GameState state, {
    double? leftOffset,
    _KeyboardKey? trailing,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leftOffset != null) SizedBox(width: leftOffset),
        ...letters
            .map(
              (letter) => _KeyboardKey(
                letter: letter,
                gameState: state,
                controller: controller,
              ),
            )
            .toList(),
        if (trailing != null) trailing,
      ],
    );
  }
}

class _KeyboardKey extends StatelessWidget {
  const _KeyboardKey({
    required this.gameState,
    required this.controller,
    this.letter,
    this.icon,
    this.onTap,
  });

  final GameState gameState;
  final TextEditingController controller;
  final String? letter;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    assert(
      letter != null || icon != null,
      '_KeyboardKey widget must be supplied with either a letter or an icon',
    );

    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: screenSize.width / 12,
        height: screenSize.height / 19,
        decoration: BoxDecoration(
          color: letter != null
              ? _getColor(letter!, gameState) ?? Colors.white
              : Colors.white,
          border: Border.all(
            color: Colors.white54,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: InkWell(
          onTap: onTap != null
              ? onTap!
              : () {
                  final text = controller.value.text;
                  controller.text = '$text$letter';
                },
          child: Center(
            child: icon != null ? Icon(icon) : Text(letter!),
          ),
        ),
      ),
    );
  }

  Color? _getColor(String letter, GameState state) {
    if (state.submittedKeys?.greenKeys.contains(letter) ?? false) {
      return Colors.green;
    } else if (state.submittedKeys?.yellowKeys.contains(letter) ?? false) {
      return Colors.amber;
    } else if (state.submittedKeys?.blackKeys.contains(letter) ?? false) {
      return Colors.grey;
    }

    return null;
  }
}
