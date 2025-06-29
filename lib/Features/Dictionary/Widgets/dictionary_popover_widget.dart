import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class DictionaryPopoverWidget extends ConsumerWidget {
  final String gameId;
  final GameMode gameMode;
  const DictionaryPopoverWidget({
    super.key,
    required this.gameId,
    required this.gameMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameKey = "$gameId (${toTitleCase(gameMode.name)})";
    final keyboard = ref.read(keyboardProvider(gameKey).notifier);
    final provider = ref.read(gameProvider(gameKey).notifier);
    final scrollController = ref.watch(scrollProvider(gameKey));
    final selectedIdx = ref.watch(
      gameProvider(gameKey).select((s) => s.selectedIdx),
    );
    final cells = ref.watch(gameProvider(gameKey).select((s) => s.cells));
    final newWords = getSuggestedWords(cells, selectedIdx);
    int wordStart = getWordStart(selectedIdx, cells);

    return Positioned(
      bottom: keyboardH,
      left: 0,
      right: 0,
      child: Scrollbar(
        controller: scrollController,
        interactive: true,
        trackVisibility: true,
        thumbVisibility: true,
        child: Container(
          width: screenW,
          height: containerHeight * 2,
          color: Colors.black,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            primary: true,
            child: Row(
              children: [
                ...(newWords.map((word) {
                  return StyledButtonWidget(
                    value: word,
                    marginHorizontal: 3,
                    marginVertical: 3,
                    txtColor: AppTheme.logoGreen,
                    paddingVertical: 0,
                    height: containerHeight,
                    addTextShadow: true,
                    onPressed: () {
                      keyboard.saveHistory();
                      var curWord = word.toUpperCase().split("");
                      if (gameMode == GameMode.assisted) {
                        curWord = curWord.toSet().toList();
                      }
                      provider.selectCell(wordStart);
                      for (int j = 0; j < word.length; j++) {
                        keyboard.pressKey("", false);
                        provider.incrementCell(1);
                      }
                      provider.selectCell(wordStart);
                      for (String letter in curWord) {
                        keyboard.pressKey(letter, false);
                      }
                    },
                  );
                }).toList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
