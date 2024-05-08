import 'package:flutter/material.dart';

class LetterTile extends StatelessWidget {
  const LetterTile(this.letter, {super.key});

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(letter),
    );
  }
}
