class Keyboard {
  final Map<String, int> pressedKeys;
  final List<Keyboard> history; //stores previous states, not itself

  const Keyboard({this.pressedKeys = const {}, this.history = const []});

  Keyboard copyWith({Map<String, int>? pressedKeys, List<Keyboard>? history}) {
    return Keyboard(
      pressedKeys: pressedKeys ?? this.pressedKeys,
      history: history ?? this.history,
    );
  }
}
