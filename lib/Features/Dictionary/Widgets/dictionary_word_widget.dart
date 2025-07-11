import 'package:flutter/material.dart';

class DictionaryWordWidget extends StatelessWidget {
  final String word;
  final int index;
  final Color curColor;
  final bool isEntryHighlighted;
  final GlobalKey wordKey;
  final String? searchTerm;

  const DictionaryWordWidget({
    super.key,
    required this.word,
    required this.index,
    required this.curColor,
    required this.isEntryHighlighted,
    required this.wordKey,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context) {
    final isWordHighlighted =
        isEntryHighlighted &&
        searchTerm != null &&
        word.toLowerCase() == searchTerm;
    return Container(
      key: wordKey,
      decoration: BoxDecoration(
        color: isWordHighlighted ? Colors.orange.withAlpha(100) : Colors.black,
        border: Border.all(
          color: isWordHighlighted ? Colors.orange : curColor,
          width: 2,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Text(
        word,
        style: TextStyle(
          color: isWordHighlighted ? Colors.white : curColor,
          fontWeight: isWordHighlighted ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
