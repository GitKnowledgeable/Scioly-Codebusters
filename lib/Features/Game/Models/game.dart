import 'package:projects/library.dart';

enum GameMode { assisted, manual }

class Game {
  final int selectedIdx;
  final Quote quote;
  final bool isCorrect; //when true, can edit quote but timer stopped
  final bool showCorrect; //highlights correct values
  final bool showSuggestions; //shows dictionary suggestions
  final bool usedHints; //if true, auto 1 star
  final bool isPerfect; //if true and usedHints false, 3 star
  final bool showComplete; //shows end card
  final List<Game> history; //stores previous states, not itself
  final List<Cell> cells;
  final GameMode gameMode;
  final int rating;

  Game({
    required this.quote,
    this.selectedIdx = 0,
    this.isCorrect = false,
    this.showCorrect = false,
    this.usedHints = false,
    this.isPerfect = true,
    this.showComplete = false,
    this.showSuggestions = false,
    this.history = const [],
    this.cells = const [],
    this.gameMode = GameMode.assisted,
    this.rating = 2,
  });

  Game copyWith({
    int? selectedIdx,
    Quote? quote,
    bool? isCorrect,
    bool? showCorrect,
    bool? usedHints,
    bool? isPerfect,
    bool? showComplete,
    bool? showSuggestions,
    List<Game>? history,
    List<Cell>? cells,
    GameMode? gameMode,
    int? rating,
  }) {
    return Game(
      quote: quote ?? this.quote,
      selectedIdx: selectedIdx ?? this.selectedIdx,
      isCorrect: isCorrect ?? this.isCorrect,
      showCorrect: showCorrect ?? this.showCorrect,
      usedHints: usedHints ?? this.usedHints,
      isPerfect: isPerfect ?? this.isPerfect,
      showComplete: showComplete ?? this.showComplete,
      showSuggestions: showSuggestions ?? this.showSuggestions,
      history: history ?? this.history,
      cells: cells ?? this.cells,
      gameMode: gameMode ?? this.gameMode,
      rating: rating ?? this.rating,
    );
  }
}
