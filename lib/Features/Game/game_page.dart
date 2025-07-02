import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class GamePage extends ConsumerWidget {
  final String gameId;
  final GameMode gameMode;
  final Language language;

  const GamePage({
    super.key,
    required this.gameId,
    required this.gameMode,
    required this.language,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = "$gameId (${toTitleCase(gameMode.name)})";
    final provider = ref.read(gameProvider(key).notifier);
    final scrollController = ref.watch(scrollProvider(key));
    final quote = ref.watch(gameProvider(key).select((s) => s.quote.ogQuote));
    final author = ref.watch(gameProvider(key).select((s) => s.quote.author));
    final bool isCorrect = ref.watch(
      gameProvider(key).select((s) => s.isCorrect),
    );
    final showComplete = ref.watch(
      gameProvider(key).select((s) => s.showComplete),
    );
    final showSuggestions = ref.watch(
      gameProvider(key).select((s) => s.showSuggestions),
    );
    return Container(
      decoration: AppTheme.backgroundGradient,
      child: Scaffold(
        backgroundColor: AppTheme.appBarBackground,
        appBar: AppBar(
          backgroundColor: AppTheme.appBarBackground,
          title: Text(
            gameId,
            style: TextStyle(
              shadows: [Shadow(color: AppTheme.logoGreen, blurRadius: 5)],
            ),
          ),
          actions: [
            if (isCorrect && !showComplete)
              StyledButtonWidget(
                value: "Continue",
                onPressed: () => provider.setPopup(true),
                marginHorizontal: 5,
                marginVertical: 10,
              ),
          ],
        ),
        body: Stack(
          children: [
            Stack(
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.fromLTRB(
                    insetPadding,
                    insetPadding + panelHeight,
                    insetPadding,
                    insetPadding +
                        keyboardH +
                        (containerHeight * 2), // Add enough bottom padding
                  ),
                  child: Column(
                    children: [
                      CryptogramGridWidget(gameKey: key),
                      if (isCorrect)
                        Column(
                          children: [
                            SizedBox(height: padding),
                            SizedBox(
                              width: maxLength,
                              child: Text(
                                quote,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                if (showSuggestions)
                  AnimatedBuilder(
                    animation: scrollController,
                    builder: (context, child) {
                      return DictionaryPopoverWidget(
                        gameId: gameId,
                        gameMode: gameMode,
                        dictionaryId: language.name,
                      );
                    },
                  ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: GamePageHeaderWidget(gameKey: key),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: KeyboardWidget(gameKey: key, language: language),
                ),
              ],
            ),
            if (showComplete)
              Container(
                color: Colors.black.withAlpha(128),
                child: Center(
                  child: Container(
                    width: screenW - 50,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: AppTheme.logoGreen, width: 1),
                      boxShadow: [
                        BoxShadow(color: AppTheme.logoGreen, blurRadius: 5),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        QuoteDisplayWidget(quote: quote, author: author),
                        SizedBox(height: 20),
                        const Text(
                          'Congratulations!',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.logoGreen,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        StyledButtonWidget(
                          value: "Play Again",
                          onPressed: () {
                            Navigator.of(context).pop();
                            provider.destroy();
                          },
                        ),
                        const SizedBox(height: 20),
                        StyledButtonWidget(
                          value: "View Quote",
                          onPressed: () {
                            provider.setPopup(false);
                          },
                        ),
                        const SizedBox(height: 20),
                        StyledButtonWidget(
                          value: "Save Quote",
                          onPressed: () {
                            Null;
                          },
                        ),
                        const SizedBox(height: 20),
                        StyledButtonWidget(
                          value: "Home",
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
                            provider.destroy();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
