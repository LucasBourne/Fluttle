import 'package:flutter/material.dart';

class GuessTextField extends StatelessWidget {
  const GuessTextField(this.controller, {super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: 5,
      decoration: const InputDecoration(counterText: ''),
    );
  }
}
