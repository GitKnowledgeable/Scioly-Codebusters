import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';
import 'package:flutter/material.dart';

class FavoritesTab extends ConsumerWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteQuotesProvider);

    List<Color> colors = [
      AppTheme.logoGreen,
      Colors.redAccent,
      Colors.blueAccent,
      Colors.yellowAccent,
    ];

    return favorites.isEmpty
        ? const Center(child: Text("No favorite quotes yet."))
        : ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final quote = favorites[index];
              final quoteIndex = ref.read(quoteListProvider).indexOf(quote);
              return QuoteCard(
                quote: quote,
                color: colors[index],
                onFavoriteToggle: () => ref
                    .read(quoteListProvider.notifier)
                    .toggleFavorite(quoteIndex),
              );
            },
          );
  }
}
