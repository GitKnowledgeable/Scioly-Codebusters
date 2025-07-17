import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scioly_codebusters/library.dart';

class CellWidget extends ConsumerWidget {
  final int index;
  final String gameKey;

  const CellWidget({super.key, required this.index, required this.gameKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cells = ref.watch(gameProvider(gameKey).select((s) => s.cells));
    final showCorrect = ref.watch(
      gameProvider(gameKey).select((s) => s.showCorrect),
    );

    //calculate colors
    var cellColor = gameCellColor.withAlpha(50);
    var textColor = Colors.white;
    var borderColor = gameCellColor;
    List<BoxShadow> shadows = [];

    // This should stay first, this is least important
    if (cells[index].isCorrect) {
      textColor = Colors.black;
      shadows = [BoxShadow(color: gameCellColor, blurRadius: 5)];
    } else if (showCorrect && cells[index].text != "") {
      cellColor = Colors.red;
      borderColor = Colors.red;
      textColor = Colors.black;
      shadows = [BoxShadow(color: Colors.red, blurRadius: 10)];
    }

    // This set of conditions if more important than the .isCorrect conditions
    if (cells[index].isSelected) {
      cellColor = Color.fromARGB(255, 3, 0, 175);
      // cellColor = Color(0xFFB71C1C);
      textColor = Colors.white;
    } else if (cells[index].isLit) {
      cellColor = Color.fromRGBO(43, 117, 255, 1);
      // cellColor = Color(0xFFF44336);
      textColor = Colors.white;
    }

    // Most important set of conditions, so at bottom
    if (cells[index].isDuplicate && !showCorrect) {
      textColor = Colors.red;
    } else if (cells[index].isDuplicate) {
      textColor = Colors.black;
    }

    if (!cells[index].isException) {
      return Column(
        children: [
          SizedBox(
            width: containerWidth,
            height: decorationHeight,
            child: Center(
              child: Text(
                cells[index].cipher,
                style: AppTheme.decorationTextStyle,
              ),
            ),
          ),
          SizedBox(width: containerWidth, height: padding),
          InkWell(
            onTap: () =>
                ref.read(gameProvider(gameKey).notifier).selectCell(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                color: cellColor,
                border: Border.all(color: borderColor, width: 1),
                boxShadow: shadows,
              ),
              child: Center(
                child: Text(
                  cells[index].text,
                  style: TextStyle(
                    fontSize: containerFS,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: containerWidth, height: padding),
          SizedBox(
            width: containerWidth,
            height: decorationHeight,
            child: Center(
              child: Text(
                "${cells[index].count}",
                style: AppTheme.decorationTextStyle,
              ),
            ),
          ),
        ],
      );
    } else {
      return SizedBox(
        width: containerWidth,
        height: containerHeight,
        child: Center(
          child: Text(cells[index].text, style: AppTheme.keyboardKeyTextStyle),
        ),
      );
    }
  }
}
