import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scioly_codebusters/library.dart';

class ResetCellAction extends Action<ResetCellIntent> {
  final String gameKey;
  final WidgetRef ref;

  ResetCellAction({required this.gameKey, required this.ref});

  @override
  void invoke(covariant ResetCellIntent intent) {
    ref.read(keyboardProvider(gameKey).notifier).resetPuzzle();
  }
}

class ResetCellIntent extends Intent {}
