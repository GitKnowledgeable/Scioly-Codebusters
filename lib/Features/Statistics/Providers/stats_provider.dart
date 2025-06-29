import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

final statsBoxProvider = Provider<Box<GameModeStats>>((ref) {
  return Hive.box<GameModeStats>('statsBox');
});

final gameModeStatsProvider =
    StateNotifierProvider.family<GameModeStatsNotifier, GameModeStats, String>((
      ref,
      gameMode,
    ) {
      final box = ref.watch(statsBoxProvider);
      return GameModeStatsNotifier(gameMode, box);
    });

class GameModeStatsNotifier extends StateNotifier<GameModeStats> {
  final String gameMode;
  final Box<GameModeStats> box;

  GameModeStatsNotifier(this.gameMode, this.box)
    : super(box.get(gameMode) ?? GameModeStats(solveRecords: []));

  void addSolve(double time) {
    state.addSolve(time);
    box.put(gameMode, state);
    state = GameModeStats(solveRecords: List.from(state.solveRecords));
  }
}
