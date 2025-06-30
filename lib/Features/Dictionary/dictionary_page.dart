import 'package:flutter/material.dart';
import 'package:projects/library.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryPage extends ConsumerWidget {
  final String dictionaryId;
  DictionaryPage({super.key, required this.dictionaryId});
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref
        .watch(patternMapProvider(dictionaryId))
        .map
        .entries
        .toList();
    final colors = [
      AppTheme.logoGreen,
      Colors.yellowAccent,
      Colors.blueAccent,
      Colors.redAccent,
    ];

    return Container(
      decoration: AppTheme.backgroundGradient,
      child: Scaffold(
        backgroundColor: AppTheme.appBarBackground,
        appBar: AppBar(
          title: const Text('Pattern Map'),
          backgroundColor: AppTheme.appBarBackground,
        ),
        body: Scrollbar(
          controller: _scrollController,
          child: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            separatorBuilder: (_, _) => const SizedBox(height: 24),
            itemBuilder: (context, index) {
              final entry = entries[index];
              final curColor = colors[index % colors.length];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: curColor, width: 2),
                  boxShadow: [BoxShadow(color: curColor, blurRadius: 10)],
                ),
                padding: EdgeInsets.all(insetPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingWidget(
                      neonColor: curColor,
                      title: entry.key,
                      num: (index + 1).toString(),
                      fontSize: 25,
                    ),
                    const SizedBox(height: padding + 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: entry.value
                          .map(
                            (word) => Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(color: curColor, width: 2),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 20,
                              ),
                              child: Text(
                                word,
                                style: TextStyle(color: curColor),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
