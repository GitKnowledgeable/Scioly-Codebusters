import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'library.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dictionary = PatternMap();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SolveRecordAdapter());
  Hive.registerAdapter(GameModeStatsAdapter());
  await Hive.openBox<GameModeStats>('statsBox');
  for (var word in wordList) {
    dictionary.addWord(word);
  }
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: HomePage(),
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
