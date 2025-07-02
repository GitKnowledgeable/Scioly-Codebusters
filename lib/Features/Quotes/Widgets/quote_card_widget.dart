import 'package:projects/library.dart';
import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  final SolvedQuote quote;
  final VoidCallback onFavoriteToggle;
  final Color color;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.onFavoriteToggle,
    this.color = AppTheme.logoGreen,
  });

  @override
  Widget build(BuildContext context) {
    String day = weekday[quote.date.weekday] ?? "";
    String month = months[quote.date.month] ?? "";
    String date = "$day, $month ${quote.date.day.toString()}";

    List<Icon> stars = [];
    for (int i = 0; i < quote.rating; i++) {
      stars.add(Icon(Icons.star, color: Colors.amber));
    }
    for (int i = 0; i < (3 - quote.rating); i++) {
      stars.add(Icon(Icons.star_border, color: Colors.amber));
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color.withAlpha(200), width: 1),
        color: color.withAlpha(50),
      ),
      child: Column(
        children: [
          Text(
            date,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: padding),
          Text(quote.text, style: TextStyle(color: color)),
          SizedBox(height: padding),
          Row(
            children: [
              Text(
                quote.gameMode,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Spacer(),
              Text(
                "- ${quote.author}",
                style: TextStyle(color: color, fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: padding),
          Row(
            children: [
              ...stars,
              SizedBox(width: 10),
              Icon(Icons.timer_outlined, color: color, size: 20),
              SizedBox(width: 5),
              Text(quote.solveTime.toString(), style: TextStyle(color: color)),
              Spacer(),
              IconButton(
                icon: Icon(
                  quote.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: quote.isFavorite ? color : Colors.grey,
                ),
                onPressed: onFavoriteToggle,
              ),
            ],
          ),
        ],
      ),
      // child: ListTile(
      //   title: Text(quote.text, style: TextStyle(color: color)),
      //   subtitle: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         '\n  - ${quote.author}\n\n${quote.gameMode}',
      //         style: TextStyle(color: color),
      //       ),
      //       Row(
      //         children: [
      //           Row(
      //             children: List.generate(
      //               quote.rating,
      //               (index) => Icon(Icons.star, color: Colors.amber, size: 20),
      //             ),
      //           ),
      //           SizedBox(width: 20),
      //           Row(
      //             children: [
      //               Icon(Icons.timer, size: 20, color: color),
      //               Text('${quote.solveTime}s', style: TextStyle(color: color)),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      //   trailing: IconButton(
      //     icon: Icon(
      //       quote.isFavorite ? Icons.favorite : Icons.favorite_border,
      //       color: quote.isFavorite ? color : Colors.grey,
      //     ),
      //     onPressed: onFavoriteToggle,
      //   ),
      // ),
    );
  }
}
