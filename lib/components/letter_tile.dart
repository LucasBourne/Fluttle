import 'package:flutter/material.dart';

class LetterTile extends StatelessWidget {
  const LetterTile(this.letter, {super.key, required this.wordContainsLetter, required this.isInCorrectLocation});

  final String letter;
  final bool wordContainsLetter;
  final bool isInCorrectLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: _color,
      child: Center(
        child: Text(letter),
      ),
    );
  }

  Color? get _color {
    if (isInCorrectLocation) {
      return Colors.green;
    } else if (wordContainsLetter) {
      return Colors.amber;
    } else {
      return null;
    }
  }
}
