import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';
import 'dart:math';

class MatrixBackgroundWidget extends ConsumerStatefulWidget {
  const MatrixBackgroundWidget({super.key});

  @override
  ConsumerState<MatrixBackgroundWidget> createState() =>
      _MatrixBackgroundWidgetState();
}

class _MatrixBackgroundWidgetState
    extends ConsumerState<MatrixBackgroundWidget> {
  final List<LineData> _fallingLines = [];

  Random random = Random();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startGeneratingLines();
    });
  }

  void _startGeneratingLines() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      final key = UniqueKey();
      final widget = VerticalFallingLine(key: key);
      setState(() {
        _fallingLines.add(LineData(widget));
      });

      Future.delayed(Duration(seconds: 10), () {
        if (!mounted) return;
        setState(() {
          _fallingLines.removeWhere((line) => line.key == key);
        });
      }); // Just deleting the created lines after 10 seconds
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: _fallingLines.map((line) => line.widget).toList());
  }
}

List<VerticalFallingLine> generateFallingWidgets(int len) {
  List<VerticalFallingLine> output = [];
  for (int i = 0; i < len; i++) {
    output.add(VerticalFallingLine(key: UniqueKey()));
  }
  return output;
}

class LineData {
  final Widget widget;
  final UniqueKey key;

  LineData(this.widget) : key = widget.key as UniqueKey;
}
