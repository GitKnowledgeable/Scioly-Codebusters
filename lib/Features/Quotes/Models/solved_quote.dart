import 'package:hive/hive.dart';
part 'solved_quote.g.dart'; // Needed for generated code

@HiveType(typeId: 2)
class SolvedQuote extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  String author;

  @HiveField(2)
  int rating;

  @HiveField(3)
  double solveTime;

  @HiveField(4)
  String gameMode;

  @HiveField(5)
  bool isFavorite;

  @HiveField(6)
  DateTime date;

  SolvedQuote({
    required this.text,
    required this.author,
    required this.rating,
    required this.solveTime,
    required this.gameMode,
    required this.date,
    this.isFavorite = false,
  });
}
