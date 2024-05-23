import 'package:flutter/material.dart';

class LetterTile extends StatelessWidget {
  const LetterTile(this.letter, {super.key, required this.color});

  final String letter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Center(
        child: Text(letter),
      ),
    );
  }
}
