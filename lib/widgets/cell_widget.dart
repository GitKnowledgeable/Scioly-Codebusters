import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class CellWidget extends ConsumerWidget {
  final int index;
  final String gameId;

  const CellWidget({super.key, required this.index, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cells = ref.watch(gameProvider(gameId).select((s) => s.cells));
    //calculate colors
    var cellColor = AppTheme.logoGreen.withAlpha(50);
    var textColor = Colors.white;
    List<BoxShadow> shadows = [];

    // This should stay first, this is least important
    if (cells[index].isCorrect) {
      textColor = Colors.black;
      shadows = [BoxShadow(color: AppTheme.logoGreen, blurRadius: 5)];
    }

    // This set of conditions if more important than the .isCorrect conditions
    if (cells[index].isSelected) {
      cellColor = Colors.orange;
      textColor = Colors.white;
    } else if (cells[index].isLit) {
      cellColor = Colors.teal.shade400;
      textColor = Colors.white;
      shadows = [BoxShadow(color: Colors.teal.shade900, blurRadius: 5)];
    }

    // Most important set of conditions, so at bottom
    if (cells[index].isDuplicate) {
      textColor = Colors.red;
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
          GestureDetector(
            onTap: () =>
                ref.read(gameProvider(gameId).notifier).selectCell(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                color: cellColor,
                border: Border.all(color: AppTheme.logoGreen, width: 1),
                boxShadow: shadows,
              ),
              child: Center(
                child: Text(
                  cells[index].text,
                  style: TextStyle(
                    fontSize: 18,
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
