import 'package:fluttle/repos/random_word_interface.dart';
import 'package:word_generator/word_generator.dart';

class RandomWordRepo implements RandomWordInterface {
  final _wordGenerator = WordGenerator();

  @override
  String generateRandomWord({length = 5}) {
    String newWord = '';

    while (newWord.length != length) {
      newWord = _wordGenerator.randomNoun();
    }

    return newWord;
  }
}
