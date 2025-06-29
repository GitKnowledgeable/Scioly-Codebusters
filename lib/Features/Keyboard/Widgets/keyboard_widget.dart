import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class KeyboardWidget extends ConsumerWidget {
  final String gameKey;
  final Language language;
  const KeyboardWidget({
    super.key,
    required this.gameKey,
    required this.language,
  });

  static List<List<String>> rows = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider(gameKey));
    if (gameState.cells.isEmpty) return const SizedBox.shrink();
    if (language == Language.spanish && rows[2].length == 7) {
      rows[2].insert(6, 'Ñ');
    } else if (language == Language.english && rows[2].length == 8) {
      rows[2].remove('Ñ');
    }
    final pressedKeys = ref.watch(
      keyboardProvider(gameKey).select((s) => s.pressedKeys),
    );

    Widget buildKey(String key) {
      final isPressed = pressedKeys.containsKey(key);
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: spacing / 2,
          vertical: spacing / 2,
        ),
        child: SizedBox(
          width: keyWidth,
          height: double.infinity,
          child: KeyboardKeyWidget(
            keyValue: key,
            onPressed: () => ref
                .read(keyboardProvider(gameKey).notifier)
                .pressKey(key, true),
            isPressed: isPressed,
            color: AppTheme.backgroundColors[2],
          ),
        ),
      );
    }

    Widget buildRow(List<String> keys) => Expanded(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: keys.map(buildKey).toList(),
        ),
      ),
    );

    return SizedBox(
      height: keyboardH,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ...AppTheme.backgroundColors,
              const Color.fromARGB(255, 0, 29, 61),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ...rows.map(buildRow),
            const SizedBox(height: 8),
            Row(
              children: [
                SizedBox(
                  height: undoButtonHeight,
                  child: KeyboardKeyWidget(
                    keyValue: "<",
                    onPressed: () => ref
                        .read(gameProvider(gameKey).notifier)
                        .incrementCell(-1),
                    padding: padding + 10,
                    endScale: 1.05,
                    color: AppTheme.backgroundColors[2],
                  ),
                ),
                SizedBox(width: padding),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: undoButtonHeight,
                    child: KeyboardKeyWidget(
                      keyValue: "Reset",
                      onPressed: () => ref
                          .read(keyboardProvider(gameKey).notifier)
                          .resetPuzzle(),
                      padding: padding + 10,
                      endScale: 1.05,
                      color: AppTheme.backgroundColors[2],
                    ),
                  ),
                ),
                SizedBox(width: padding),
                SizedBox(
                  height: undoButtonHeight,
                  child: KeyboardKeyWidget(
                    keyValue: "Del",
                    onPressed: () => ref
                        .read(keyboardProvider(gameKey).notifier)
                        .pressKey("", true),
                    padding: padding + 10,
                    endScale: 1.05,
                    color: AppTheme.backgroundColors[2],
                  ),
                ),
                SizedBox(width: padding),
                SizedBox(
                  height: undoButtonHeight,
                  child: KeyboardKeyWidget(
                    keyValue: "Undo",
                    onPressed: () =>
                        ref.read(keyboardProvider(gameKey).notifier).undo(),
                    padding: padding + 10,
                    endScale: 1.05,
                    color: AppTheme.backgroundColors[2],
                  ),
                ),
                SizedBox(width: padding),
                SizedBox(
                  height: undoButtonHeight,
                  child: KeyboardKeyWidget(
                    keyValue: ">",
                    onPressed: () => ref
                        .read(gameProvider(gameKey).notifier)
                        .incrementCell(1),
                    padding: padding + 10,
                    endScale: 1.05,
                    color: AppTheme.backgroundColors[2],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
