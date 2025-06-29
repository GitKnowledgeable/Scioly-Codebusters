import 'dart:collection';
import 'package:projects/library.dart';

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
