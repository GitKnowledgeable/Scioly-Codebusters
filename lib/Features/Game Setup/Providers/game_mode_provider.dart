import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scioly_codebusters/library.dart';

class GameModeProvider extends FamilyNotifier<GameMode, String> {
  @override
  GameMode build(String arg) {
    return GameMode.assisted;
  }

  void setGameMode(GameMode gameMode) {
    state = gameMode;
  }
}

final gameModeProvider =
    NotifierProvider.family<GameModeProvider, GameMode, String>(
      GameModeProvider.new,
    );
