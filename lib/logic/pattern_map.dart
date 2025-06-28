import 'dart:collection';

import 'package:projects/library.dart';

String getPatternKey(String word) {
  Map<String, String> letterMap = {};
  int nextCharCode = 'A'.codeUnitAt(0);
  StringBuffer pattern = StringBuffer();

  for (var ch in word.toLowerCase().split('')) {
    if (!letterMap.containsKey(ch)) {
      letterMap[ch] = String.fromCharCode(nextCharCode++);
    }
    pattern.write(letterMap[ch]);
  }
  return pattern.toString();
}

List<String> getSuggestedWords(List<Cell> cells, int selectedIdx) {
  int wordStart = getWordStart(selectedIdx, cells);
  String typed = "";
  for (int j = wordStart; !cells[j].isException; j++) {
    typed += cells[j].text == "" ? "*" : cells[j].text;
  }
  final words = dictionary.map[getPatternKey(getWord(wordStart, cells))] ?? [];
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
  while (!cells[i].isException && i >= 0) {
    i--;
  }
  return i + 1;
}

String getWord(int wordStart, List<Cell> cells) {
  String word = "";
  for (int j = wordStart; !cells[j].isException; j++) {
    word += cells[j].plainText;
  }
  return word;
}

class PatternMap {
  final SplayTreeMap<String, List<String>> _map = SplayTreeMap(
    (a, b) =>
        a.length == b.length ? a.compareTo(b) : a.length.compareTo(b.length),
  );

  void addWord(String word) {
    final key = getPatternKey(word);
    _map.putIfAbsent(key, () => []);
    // Insert word in sorted order
    final list = _map[key]!;
    int idx = list.indexWhere((w) => word.compareTo(w) < 0);
    if (idx == -1) {
      list.add(word);
    } else {
      list.insert(idx, word);
    }
  }

  Map<String, List<String>> get map => _map;
}
