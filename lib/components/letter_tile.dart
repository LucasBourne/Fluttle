import 'package:flutter/material.dart';

class LetterTile extends StatelessWidget {
  const LetterTile(
    this.letter, {
    super.key,
    required this.wordContainsLetter,
    required this.isInCorrectLocation,
  });

  final String letter;
  final bool wordContainsLetter;
  final bool isInCorrectLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
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
      return Colors.black12;
    }
  }
}
