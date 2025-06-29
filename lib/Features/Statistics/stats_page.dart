import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projects/library.dart';

part 'Models/stats.g.dart';

class StatsPage extends StatelessWidget {
  final String widgetKey;
  final double fastestAllTime;
  final double averageAllTime;
  final double fastestLast10;
  final double averageLast10;
  final double fastestPrevious10;
  final double averagePrevious10;

  const StatsPage({
    super.key,
    required this.widgetKey,
    required this.fastestAllTime,
    required this.averageAllTime,
    required this.fastestLast10,
    required this.averageLast10,
    required this.fastestPrevious10,
    required this.averagePrevious10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.backgroundGradient,
      child: Scaffold(
        backgroundColor: AppTheme.appBarBackground,
        appBar: AppBar(backgroundColor: AppTheme.appBarBackground),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(insetPadding),
            child: Column(
              children: [
                Text(
                  "Solve Statistics - $widgetKey",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    shadows: [Shadow(color: AppTheme.logoGreen, blurRadius: 5)],
                  ),
                ),
                const SizedBox(height: padding + 10),
                StatBoxWidget(
                  title: "All Time",
                  num: "01",
                  neonColor: Colors.pinkAccent,
                  fastest: fastestAllTime.toStringAsFixed(2),
                  average: averageAllTime.toStringAsFixed(2),
                ),
                const SizedBox(height: padding + 10),

                StatBoxWidget(
                  title: "Last 10",
                  num: "02",
                  neonColor: Colors.yellowAccent,
                  fastest: fastestLast10.toStringAsFixed(2),
                  average: averageLast10.toStringAsFixed(2),
                ),
                const SizedBox(height: padding + 10),

                StatBoxWidget(
                  title: "Previous 10",
                  num: "03",
                  neonColor: Colors.lightBlueAccent,
                  fastest: fastestPrevious10.toStringAsFixed(2),
                  average: averagePrevious10.toStringAsFixed(2),
                ),
                const SizedBox(height: padding + 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@HiveType(typeId: 0)
class SolveRecord {
  @HiveField(0)
  final double solveTime;

  @HiveField(1)
  final DateTime timestamp;

  SolveRecord({required this.solveTime, required this.timestamp});
}

@HiveType(typeId: 1)
class GameModeStats {
  @HiveField(0)
  final List<SolveRecord> solveRecords;

  GameModeStats({required this.solveRecords});

  double get fastestSolve => solveRecords.isEmpty
      ? 0
      : solveRecords.map((r) => r.solveTime).reduce((a, b) => a < b ? a : b);

  double get averageSolve => solveRecords.isEmpty
      ? 0
      : solveRecords.map((r) => r.solveTime).reduce((a, b) => a + b) /
            solveRecords.length;

  double fastestInLast(int count, {int skip = 0}) {
    if (solveRecords.isEmpty) return 0;
    final lastN = solveRecords.skip(skip).take(count).toList();
    if (lastN.isEmpty) return 0;
    return lastN.map((r) => r.solveTime).reduce((a, b) => a < b ? a : b);
  }

  double averageInLast(int count, {int skip = 0}) {
    if (solveRecords.isEmpty) return 0;
    final lastN = solveRecords.skip(skip).take(count).toList();
    if (lastN.isEmpty) return 0;
    return lastN.map((r) => r.solveTime).reduce((a, b) => a + b) / lastN.length;
  }

  void addSolve(double time) {
    solveRecords.insert(
      0,
      SolveRecord(solveTime: time, timestamp: DateTime.now()),
    );
  }
}
