import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scioly_codebusters/library.dart';

final statsProvider = Provider.family<QuoteStats, String>((ref, gameModeKey) {
  final allQuotes = ref.watch(quoteListProvider);
  final quotes = allQuotes
      .where((q) => q.rating >= 2 && q.gameMode == gameModeKey)
      .toList();

  final now = DateTime.now();
  final startOfThisWeek = now.subtract(Duration(days: now.weekday - 1));
  final startOfLastWeek = startOfThisWeek.subtract(const Duration(days: 7));

  bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  List<SolvedQuote> thisWeek = quotes
      .where(
        (q) =>
            q.date.isAfter(startOfThisWeek) ||
            isSameDay(q.date, startOfThisWeek),
      )
      .toList();

  List<SolvedQuote> lastWeek = quotes
      .where(
        (q) =>
            (q.date.isAfter(startOfLastWeek) ||
                isSameDay(q.date, startOfLastWeek)) &&
            q.date.isBefore(startOfThisWeek),
      )
      .toList();

  double avg(List<SolvedQuote> qs) => qs.isEmpty
      ? 0
      : qs.map((q) => q.solveTime).reduce((a, b) => a + b) / qs.length;

  double fastest(List<SolvedQuote> qs) => qs.isEmpty
      ? 0
      : qs.map((q) => q.solveTime).reduce((a, b) => a < b ? a : b);

  return QuoteStats(
    avgSolveTimeAll: avg(quotes),
    avgSolveTimeThisWeek: avg(thisWeek),
    avgSolveTimeLastWeek: avg(lastWeek),
    fastestSolveTimeAll: fastest(quotes),
    fastestSolveTimeThisWeek: fastest(thisWeek),
    fastestSolveTimeLastWeek: fastest(lastWeek),
    totalSolvedAll: quotes.length,
    totalSolvedThisWeek: thisWeek.length,
    totalSolvedLastWeek: lastWeek.length,
  );
});
