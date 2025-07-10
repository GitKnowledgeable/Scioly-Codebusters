//import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scioly_codebusters/library.dart';

//double check everything is final for gameStates
class KeyboardProvider extends FamilyNotifier<Keyboard, String> {
  @override
  Keyboard build(String arg) {
    return Keyboard();
  }

  void pressKey(String key, bool saveHistory) {
    String letter = ref
        .read(gameProvider(arg).notifier)
        .setLetter(key, saveHistory);
    if (letter == key) return;
    final newHistory = saveHistory
        ? [...state.history, state.copyWith()]
        : state.history;
    var newPressed = Map<String, int>.from(state.pressedKeys);
    newPressed.update(key, (value) => value + 1, ifAbsent: () => 1);
    final gameMode = ref.watch(gameProvider(arg).select((s) => s.gameMode));
    if (gameMode == GameMode.manual) newPressed = {};
    if (newPressed.containsKey(letter)) {
      newPressed[letter] = newPressed[letter]! - 1;
      if (newPressed[letter] == 0) {
        newPressed.remove(letter);
      }
    }
    state = state.copyWith(pressedKeys: newPressed, history: newHistory);
  }

  void undo() {
    if (state.history.isNotEmpty) state = state.history.last;
    ref.read(gameProvider(arg).notifier).undo();
  }

  void reset() {
    state = Keyboard();
  }

  void resetPuzzle() {
    final newHistory = [...state.history, state.copyWith()];
    state = state.copyWith(pressedKeys: {}, history: newHistory);
    ref.read(gameProvider(arg).notifier).reset();
  }

  void saveHistory() {
    state = state.copyWith(history: [...state.history, state.copyWith()]);
    ref.read(gameProvider(arg).notifier).saveHistory();
  }
}

final keyboardProvider =
    NotifierProvider.family<KeyboardProvider, Keyboard, String>(
      KeyboardProvider.new,
    );
