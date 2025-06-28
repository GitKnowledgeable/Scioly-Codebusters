import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerNotifier extends FamilyNotifier<int, String> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _tick;

  @override
  int build(String timerId) {
    return 0; // Initial time in seconds
  }

  void start() {
    _stopwatch.start();
    _startTicker();
  }

  void pause() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    }
    _stopTicker();
  }

  void resume() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _startTicker();
    }
  }

  void reset() {
    _stopwatch.reset();
    _stopTicker();
    state = 0;
  }

  void restart() {
    reset();
    start();
  }

  void _startTicker() {
    _tick?.cancel();
    _tick = Timer.periodic(const Duration(seconds: 1), (_) {
      state = _stopwatch.elapsed.inSeconds;
      if (state > 999) {
        state = 999;
      }
    });
  }

  void _stopTicker() {
    _tick?.cancel();
    _tick = null;
  }

  void onDispose() {
    _tick?.cancel();
  }

  int getTime() => _stopwatch.elapsed.inSeconds;
}

final timerProvider = NotifierProvider.family<TimerNotifier, int, String>(
  TimerNotifier.new,
);
