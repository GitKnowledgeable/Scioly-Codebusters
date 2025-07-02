import 'package:flutter/material.dart';
import 'package:projects/library.dart';

class QuoteDisplayWidget extends StatelessWidget {
  final String quote;
  final String author;
  const QuoteDisplayWidget({
    super.key,
    required this.quote,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.logoGreen.withAlpha(20),
        border: Border.all(color: AppTheme.logoGreen.withAlpha(30), width: 1),
      ),
      child: Stack(
        children: [
          Text(
            '"$quote"\n',
            style: TextStyle(
              color: AppTheme.logoGreen,
              fontFamily: "JetBrainsMonoBold",
              fontStyle: FontStyle.italic,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              "-$author",
              style: TextStyle(
                color: AppTheme.logoGreen,
                fontFamily: "JetBrainsMonoBold",
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
