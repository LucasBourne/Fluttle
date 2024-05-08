import 'package:flutter/material.dart';
import 'package:fluttle/components/letter_tile.dart';

class WordRow extends StatelessWidget {
  const WordRow(this.guess, {super.key});

  final String guess;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: guess.characters.map((letter) => LetterTile(letter)).toList(),
    );
  }
}
