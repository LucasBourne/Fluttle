import 'package:flutter/material.dart';

class GuessTextField extends StatelessWidget {
  const GuessTextField(this.controller, this.onSubmitted, {super.key});

  final TextEditingController controller;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: 5,
      decoration: const InputDecoration(counterText: ''),
      onSubmitted: (_) => onSubmitted(),
      autofocus: true,
    );
  }
}
