import 'dart:collection';
import 'package:scioly_codebusters/library.dart';

class PatternMap {
  final SplayTreeMap<String, List<String>> _map = SplayTreeMap(
    (a, b) =>
        a.length == b.length ? a.compareTo(b) : a.length.compareTo(b.length),
  );

  PatternMap();
  PatternMap.fromList(List<String> list) {
    for (var word in list) {
      addWord(word);
    }
  }

  void addWord(String word) {
    final key = getPatternKey(word);
    _map.putIfAbsent(key, () => []);
    final list = _map[key]!;
    if (list.contains(word)) return;
    list.add(word);
  }

  PatternMap copy() {
    final newMap = SplayTreeMap<String, List<String>>(
      (a, b) =>
          a.length == b.length ? a.compareTo(b) : a.length.compareTo(b.length),
    );
    _map.forEach((key, value) {
      newMap[key] = List<String>.from(value);
    });
    final copy = PatternMap();
    newMap.forEach((key, value) {
      copy._map[key] = value;
    });
    return copy;
  }

  Map<String, List<String>> get map => _map;
}
