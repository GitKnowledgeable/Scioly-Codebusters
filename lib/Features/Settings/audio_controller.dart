import 'dart:async';

import 'package:logging/logging.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:scioly_codebusters/library.dart';

class AudioController {
  static final Logger _log = Logger('AudioController');

  SoLoud? _soloud;

  SoundHandle? curHandle;
  bool bgPlaying = false;

  Future<void> initialize() async {
    _soloud = SoLoud.instance;
    await _soloud!.init();
  }

  void dispose() {
    _soloud?.deinit();
  }

  Future<void> playSound(String assetKey) async {
    final source = await _soloud!.loadAsset(assetKey);
    curHandle = await _soloud!.play(source);
    _log.warning('Not implemented yet.');
  }

  Future<void> playBgSound() async {
    if (curHandle == null) {
      final source = await _soloud!.loadAsset(bgMusicFile);
      curHandle = await _soloud!.play(source, looping: true);
      bgPlaying = true;
    }
  }

  void toggleBgSound() {
    if (curHandle != null) {
      _soloud!.pauseSwitch(curHandle ?? SoundHandle(0));
      bgPlaying = !bgPlaying;
    }
  }

  void setBgVolume(double vol) {
    if (curHandle != null) {
      _soloud!.setVolume(curHandle ?? SoundHandle(0), vol);
    }
  }

  bool isBgPlaying() {
    return bgPlaying;
  }

  Future<void> startMusic() async {
    _log.warning('Not implemented yet.');
  }
}
