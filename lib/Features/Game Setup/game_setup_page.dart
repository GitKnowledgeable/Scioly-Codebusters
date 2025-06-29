import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class GamePageSetup extends ConsumerWidget {
  final Language language;
  final String gameId;
  const GamePageSetup({
    super.key,
    required this.gameId,
    required this.language,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GameMode gameMode = ref.watch(gameModeProvider(gameId));
    String key = "$gameId (${toTitleCase(gameMode.name)})";
    final gmProvider = ref.read(gameModeProvider(gameId).notifier);
    final gProvider = ref.read(gameProvider(key).notifier);
    var cellCount = ref.watch(gameProvider(key).select((s) => s.cells.length));
    final stats = ref.watch(gameModeStatsProvider(key));
    final buttonMargin = padding + 14;

    return Container(
      decoration: AppTheme.backgroundGradient,
      child: Scaffold(
        backgroundColor: AppTheme.appBarBackground,
        appBar: AppBar(backgroundColor: AppTheme.appBarBackground),
        body: Column(
          children: [
            Center(
              child: Text(
                gameId.toUpperCase(),
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  shadows: [Shadow(color: AppTheme.logoGreen, blurRadius: 5)],
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "Select Game Mode".toUpperCase(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(insetPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: buttonMargin),
                    SizedBox(
                      width: double.infinity,
                      child: HomeButtonWidget(
                        btnText: "Assisted",
                        neonColor: gameMode == GameMode.assisted
                            ? Colors.lightGreenAccent
                            : Colors.grey,
                        initialAlpha: 0,
                        finalAlpha: 10,
                        onPressed: () {
                          gmProvider.setGameMode(GameMode.assisted);
                        },
                      ),
                    ),
                    SizedBox(height: buttonMargin),
                    SizedBox(
                      width: double.infinity,
                      child: HomeButtonWidget(
                        btnText: "Manual",
                        neonColor: gameMode == GameMode.manual
                            ? Colors.lightGreenAccent
                            : Colors.grey,
                        initialAlpha: 0,
                        finalAlpha: 10,
                        onPressed: () {
                          gmProvider.setGameMode(GameMode.manual);
                        },
                      ),
                    ),
                    SizedBox(height: buttonMargin),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: HomeButtonWidget(
                              btnText: "Stats",
                              neonColor: Colors.yellowAccent,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StatsPage(
                                      widgetKey: key,
                                      fastestAllTime: stats.fastestSolve,
                                      averageAllTime: stats.averageSolve,
                                      fastestLast10: stats.fastestInLast(10),
                                      averageLast10: stats.averageInLast(10),
                                      fastestPrevious10: stats.fastestInLast(
                                        20,
                                        skip: 10,
                                      ),
                                      averagePrevious10: stats.averageInLast(
                                        20,
                                        skip: 10,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: buttonMargin),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: HomeButtonWidget(
                              btnText: "How to Play",
                              neonColor: Colors.yellowAccent,
                              onPressed: () => null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: buttonMargin),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: HomeButtonWidget(
                              btnText: "New Puzzle",
                              neonColor: Colors.redAccent,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GamePage(
                                      gameId: gameId,
                                      gameMode: gameMode,
                                      language: language,
                                    ),
                                  ),
                                );
                                gProvider.buildCryptogram(
                                  gameMode,
                                  language,
                                  gameId,
                                );
                              },
                            ),
                          ),
                        ),
                        if (cellCount > 0) SizedBox(width: buttonMargin - 10),
                        if (cellCount > 0)
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: HomeButtonWidget(
                                btnText: "Continue",
                                neonColor: Colors.pinkAccent,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GamePage(
                                        gameId: gameId,
                                        gameMode: gameMode,
                                        language: language,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
