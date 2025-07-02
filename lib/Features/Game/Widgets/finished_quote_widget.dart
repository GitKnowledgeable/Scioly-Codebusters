import 'package:flutter/material.dart';
import 'package:projects/library.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinishedQuoteWidget extends ConsumerWidget {
  final String quote;
  final String author;
  final String gameKey;
  const FinishedQuoteWidget({
    super.key,
    required this.quote,
    required this.author,
    required this.gameKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(gameProvider(gameKey).notifier);

    final time = ref.read(timerProvider(gameKey).notifier).getTime().toDouble();
    int rating = ref.watch(gameProvider(gameKey).select((s) => s.rating));
    List<Icon> stars = [];
    for (int i = 0; i < rating; i++) {
      stars.add(Icon(Icons.star, color: Colors.yellow));
    }
    for (int i = 0; i < (3 - rating); i++) {
      stars.add(Icon(Icons.star_border, color: Colors.yellow));
    }

    List<String> messages = ["Good job!", "Congratulations!", "Perfect!"];

    return Container(
      color: Colors.black.withAlpha(100),
      child: Center(
        child: Container(
          width: screenW - 50,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: AppTheme.logoGreen, width: 1),
            boxShadow: [BoxShadow(color: AppTheme.logoGreen, blurRadius: 5)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QuoteDisplayWidget(quote: quote, author: author),
              SizedBox(height: 5),
              Row(
                children: [
                  ...stars,
                  Spacer(),
                  Icon(Icons.timer_outlined, color: Colors.redAccent),
                  Text(
                    "${time.toString()}s",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                messages[rating - 1],
                style: TextStyle(fontSize: 18, color: AppTheme.logoGreen),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              StyledButtonWidget(
                value: "Play Again",
                bgColor: Colors.redAccent,
                onPressed: () {
                  Navigator.of(context).pop();
                  provider.destroy();
                },
              ),
              const SizedBox(height: 20),
              StyledButtonWidget(
                value: "View Quote",
                bgColor: AppTheme.logoGreen,
                onPressed: () {
                  provider.setPopup(false);
                },
              ),
              const SizedBox(height: 20),
              StyledButtonWidget(
                value: "Save Quote",
                bgColor: Colors.blueAccent,
                onPressed: () {
                  Null;
                },
              ),
              const SizedBox(height: 20),
              StyledButtonWidget(
                value: "Home",
                bgColor: Colors.yellowAccent,
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  provider.destroy();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
