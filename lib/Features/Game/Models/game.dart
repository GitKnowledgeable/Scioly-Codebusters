import 'package:projects/library.dart';

enum GameMode { assisted, manual }

class Game {
  final int selectedIdx;
  final Quote quote;
  final bool isCorrect;
  final bool showCorrect;
  final bool usedHints;
  final bool isPerfect;
  final bool showComplete;
  final List<Game> history; //stores previous states, not itself
  final List<Cell> cells;
  final GameMode gameMode;

  Game({
    required this.quote,
    this.selectedIdx = 0,
    this.isCorrect = false,
    this.showCorrect = false,
    this.usedHints = false,
    this.isPerfect = true,
    this.showComplete = false,
    this.history = const [],
    this.cells = const [],
    this.gameMode = GameMode.assisted,
  });

  Game copyWith({
    int? selectedIdx,
    Quote? quote,
    bool? isCorrect,
    bool? showCorrect,
    bool? usedHints,
    bool? isPerfect,
    bool? showComplete,
    List<Game>? history,
    List<Cell>? cells,
    GameMode? gameMode,
  }) {
    return Game(
      quote: quote ?? this.quote,
      selectedIdx: selectedIdx ?? this.selectedIdx,
      isCorrect: isCorrect ?? this.isCorrect,
      showCorrect: showCorrect ?? this.showCorrect,
      usedHints: usedHints ?? this.usedHints,
      isPerfect: isPerfect ?? this.isPerfect,
      showComplete: showComplete ?? this.showComplete,
      history: history ?? this.history,
      cells: cells ?? this.cells,
      gameMode: gameMode ?? this.gameMode,
    );
  }
}
