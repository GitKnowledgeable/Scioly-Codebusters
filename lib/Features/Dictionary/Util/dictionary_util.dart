import 'package:scioly_codebusters/library.dart';

String getPatternKey(String word) {
  Map<String, String> letterMap = {};
  int nextCharCode = 'A'.codeUnitAt(0);
  StringBuffer pattern = StringBuffer();

  for (var ch in word.toLowerCase().split('')) {
    if (ch == "'") {
      pattern.write("'");
      continue;
    }
    if (!letterMap.containsKey(ch)) {
      letterMap[ch] = String.fromCharCode(nextCharCode++);
    }
    pattern.write(letterMap[ch]);
  }
  return pattern.toString();
}

List<String> getSuggestedWords(
  List<Cell> cells,
  int wordStart,
  Map<String, List<String>> dictionary,
) {
  if (cells.isEmpty) {
    return [];
  }
  String typed = "";
  for (int j = wordStart; !cells[j].isException; j++) {
    typed += cells[j].text == "" ? "*" : cells[j].text;
  }
  final words = dictionary[getPatternKey(getWord(wordStart, cells))] ?? [];
  final newWords = [...words];
  for (String w in words) {
    for (int j = 0; j < typed.length; j++) {
      if (typed[j] != "*" && w[j].toUpperCase() != typed[j]) {
        newWords.remove(w);
      }
    }
  }
  return newWords;
}

int getWordStart(int i, List<Cell> cells) {
  if (cells.isEmpty || i < 0 || i >= cells.length) {
    return 0;
  }
  while (i >= 0 && (!cells[i].isException || cells[i].plainText == "'")) {
    i--;
  }
  return i + 1;
}

String getWord(int wordStart, List<Cell> cells) {
  if (cells.isEmpty || wordStart < 0 || wordStart >= cells.length) {
    return "";
  }
  String word = "";
  for (
    int i = wordStart;
    !cells[i].isException || cells[i].plainText == "'";
    i++
  ) {
    word += cells[i].plainText;
  }
  return word;
}
