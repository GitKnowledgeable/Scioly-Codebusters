import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scioly_codebusters/library.dart';
import 'package:hive/hive.dart';

// List of all quotes
final quoteListProvider =
    StateNotifierProvider<QuoteListNotifier, List<SolvedQuote>>((ref) {
      return QuoteListNotifier();
    });

class QuoteListNotifier extends StateNotifier<List<SolvedQuote>> {
  late final Box<SolvedQuote> _box;

  QuoteListNotifier() : super([]) {
    _init(); // async initialization done separately
  }

  Future<void> _init() async {
    _box = Hive.box<SolvedQuote>('quotesBox');
    state = _box.values.toList();
  }

  Future<void> addQuote(SolvedQuote quote) async {
    await _box.add(quote);
    state = _box.values.toList();
  }

  Future<void> toggleFavorite(int index) async {
    final quote = state[index];
    quote.isFavorite = !quote.isFavorite;
    await quote.save();
    state = [...state]; // notify listeners
  }
}

// Favorites are derived from the main list
final favoriteQuotesProvider = Provider<List<SolvedQuote>>((ref) {
  final allQuotes = ref.watch(quoteListProvider);
  return allQuotes.where((q) => q.isFavorite).toList();
});
