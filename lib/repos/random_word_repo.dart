import 'package:flutter/widgets.dart';
import 'package:fluttle/repos/random_word_interface.dart';
import 'package:word_generator/word_generator.dart';

class RandomWordRepo implements RandomWordInterface {
  final _wordGenerator = WordGenerator();

  @override
  String generateRandomWord({length = 5, List<String>? invalidLetters}) {
    String newWord = '';

    while (newWord.length != length ||
        !_containsValidLetters(newWord, invalidLetters)) {
      newWord = _wordGenerator.randomNoun();
    }

    return newWord;
  }

  bool _containsValidLetters(String word, List<String>? invalidLetters) {
    if (word.isEmpty) {
      return false;
    }
    if (invalidLetters == null) {
      return true;
    }

    final characterLists = [word.characters, invalidLetters];
    final common = characterLists.fold<Set>(
      characterLists.first.toSet(),
      (a, b) => a.intersection(b.toSet()),
    );
    return common.isEmpty;
  }
}
