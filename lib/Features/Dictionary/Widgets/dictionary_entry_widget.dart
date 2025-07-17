import 'package:flutter/material.dart';
import 'package:scioly_codebusters/library.dart';

double wordWidgetSpacing = 8.0;
double entryWidgetHeight =
    25 +
    10 +
    2 +
    14 +
    wordH +
    //4 +
    insetPadding * 2 +
    4 +
    24 +
    14; //number, padding, border, padding, ..., outside borders + spacing + shadows,

class DictionaryEntryWidget extends StatelessWidget {
  final MapEntry<String, List<String>> entry;
  final int index;
  final Color curColor;
  final bool isEntryHighlighted;
  final GlobalKey entryKey;
  final Map<String, GlobalKey> wordKeys;
  final String? searchTerm;

  const DictionaryEntryWidget({
    super.key,
    required this.entry,
    required this.index,
    required this.curColor,
    required this.isEntryHighlighted,
    required this.entryKey,
    required this.wordKeys,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: entryKey,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: curColor, width: borderWidth),
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
            spacing: wordWidgetSpacing,
            runSpacing: 4,
            children: entry.value
                .map(
                  (word) => DictionaryWordWidget(
                    word: word,
                    index: index,
                    curColor: curColor,
                    isEntryHighlighted: isEntryHighlighted,
                    wordKey: wordKeys.putIfAbsent(
                      '$index-$word',
                      () => GlobalKey(),
                    ),
                    searchTerm: searchTerm,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
