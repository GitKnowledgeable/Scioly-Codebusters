import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

//change width, replace boxes with padding, change file-> cryptogram_grid_widget
class CryptogramGridWidget extends ConsumerWidget {
  final String gameKey;
  const CryptogramGridWidget({super.key, required this.gameKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cells = ref.watch(gameProvider(gameKey).select((s) => s.cells));
    Map<int, List<Widget>> rows = {};
    for (int i = 0; i < cells.length; i++) {
      rows.putIfAbsent(cells[i].row, () => []);
      rows[cells[i].row]!.add(CellWidget(index: i, gameKey: gameKey));
      if (!cells[i].isException) {
        rows[cells[i].row]!.add(
          SizedBox(width: padding, height: containerHeight),
        );
      }
    }
    List<List<Widget>> grid = [];
    for (final rowWidgets in rows.values) {
      grid.add(rowWidgets);
      grid.add([SizedBox(width: maxLength, height: padding)]);
    }
    return Column(
      children: grid.map((rowWidgets) {
        return Row(children: rowWidgets);
      }).toList(),
    );
  }
}
