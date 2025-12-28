import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scioly_codebusters/library.dart';

class MoveCellAction extends Action<MoveCellIntent> {
  final String gameKey;
  final WidgetRef ref;

  MoveCellAction({required this.gameKey, required this.ref});

  @override
  void invoke(covariant MoveCellIntent intent) {
    // > = move right
    // < = move left
    print('Moving Command registered');
    if (intent.key == '>') {
      ref.read(gameProvider(gameKey).notifier).incrementCell(1);
    } else if (intent.key == '<') {
      ref.read(gameProvider(gameKey).notifier).incrementCell(-1);
    }
  }
}

class MoveCellIntent extends Intent {
  final String key;
  const MoveCellIntent({required this.key});
}
