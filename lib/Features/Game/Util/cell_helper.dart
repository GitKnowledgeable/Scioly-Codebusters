import 'package:projects/library.dart';

extension CellHelpers on List<Cell> {
  List<Cell> markCorrect() => map(
    (cell) => cell.copyWith(isCorrect: cell.text == cell.plainText),
  ).toList();

  List<Cell> markIncorrect() =>
      map((cell) => cell.copyWith(isCorrect: false)).toList();

  List<Cell> markDuplicates() {
    final Map<String, Set<String>> textToCiphers = {};
    for (final cell in this) {
      textToCiphers.putIfAbsent(cell.text, () => <String>{}).add(cell.cipher);
    }
    final Set<String> duplicateTexts = textToCiphers.entries
        .where((entry) => entry.value.length > 1)
        .map((entry) => entry.key)
        .toSet();
    return map(
      (cell) => cell.copyWith(isDuplicate: duplicateTexts.contains(cell.text)),
    ).toList();
  }

  List<Cell> setLetter(int idx, String letter) {
    if (idx < 0 || idx >= length) return this;
    return map(
      (cell) => cell.copyWith(text: cell.isLit ? letter : cell.text),
    ).toList();
  }

  List<Cell> selectCell(int idx) {
    if (idx < 0 || idx >= length) return this;
    return map(
      (cell) => cell.copyWith(isSelected: false, isLit: false),
    ).toList()..[idx] = this[idx].copyWith(isSelected: true, isLit: true);
  }

  List<Cell> highlightCells(int idx) => map(
    (cell) => cell.copyWith(isLit: cell.cipher == this[idx].cipher),
  ).toList();

  List<Cell> reset() {
    return map(
      (cell) => cell.copyWith(
        text: cell.isException ? cell.text : "",
        isDuplicate: false,
        isCorrect: false,
      ),
    ).toList();
  }

  List<Cell> calculateRows(String arg) {
    final newCells = [...this];
    double rowSize = 0.0, wordSize = 0.0;
    int rowCount = 0, wordStart = 0;
    void updateRow(int start, int end) {
      if (rowSize + wordSize > maxLength) {
        rowSize = 0.0;
        rowCount++;
      }
      for (int j = start; j <= end; j++) {
        newCells[j] = newCells[j].copyWith(row: rowCount);
      }
      rowSize += wordSize;
    }

    for (int i = 0; i < newCells.length; i++) {
      wordSize += containerWidth + padding;
      if (newCells[i].text == " " || arg == "Patristocrat") {
        updateRow(wordStart, i);
        wordSize = 0.0;
        wordStart = i + 1;
      }
    }
    updateRow(wordStart, newCells.length - 1);
    return newCells;
  }
}
