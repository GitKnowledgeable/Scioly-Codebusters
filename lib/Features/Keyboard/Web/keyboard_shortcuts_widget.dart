import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scioly_codebusters/library.dart';

class KeyboardShortcutsWidget extends ConsumerWidget {
  final String gameKey;
  final Language language;
  const KeyboardShortcutsWidget({
    super.key,
    required this.gameKey,
    required this.language,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Shortcuts(
      // Maps ctrl + Z and cmd + Z to undo last keyboard action
      // Maps ctrl + backspace to reset
      // Maps backspace to remove val at current selected cell
      // Maps left arrow key to moving to left cell
      // Maps right arrow key to moving to right cell
      // (defined in Actions folder)
      shortcuts: <SingleActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.keyZ, control: true):
            UndoCellIntent(),
        SingleActivator(LogicalKeyboardKey.keyZ, meta: true): UndoCellIntent(),
        SingleActivator(LogicalKeyboardKey.backspace, control: true):
            ResetCellIntent(),
        SingleActivator(LogicalKeyboardKey.backspace, meta: true):
            ResetCellIntent(),
        SingleActivator(LogicalKeyboardKey.backspace): DeleteCellIntent(),
        SingleActivator(LogicalKeyboardKey.arrowLeft): MoveCellIntent(key: '<'),
        SingleActivator(LogicalKeyboardKey.arrowRight): MoveCellIntent(
          key: '>',
        ),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          UndoCellIntent: UndoCellAction(gameKey: gameKey, ref: ref),
          ResetCellIntent: ResetCellAction(gameKey: gameKey, ref: ref),
          DeleteCellIntent: DeleteCellAction(gameKey: gameKey, ref: ref),
          KeyPressIntent: KeyPressAction(gameKey: gameKey, ref: ref),
          MoveCellIntent: MoveCellAction(gameKey: gameKey, ref: ref),
        },
        // Using Builder to provide innerContext which is able to use the above
        // actions mapping
        child: Builder(
          builder: (BuildContext innerContext) {
            return Focus(
              autofocus: true,
              // Takes care of normal key presses (a-z)
              onKeyEvent: (FocusNode node, KeyEvent event) {
                if (event is KeyDownEvent) {
                  final String key = event.logicalKey.keyLabel;
                  if (key.length == 1 &&
                      getAlphabet(language).contains(key) &&
                      // Make sure ctrl and cmd are not pressed down
                      !HardwareKeyboard.instance.isControlPressed &&
                      !HardwareKeyboard.instance.isMetaPressed) {
                    Actions.invoke(
                      innerContext,
                      KeyPressIntent(key: key.toUpperCase()),
                    );
                    return KeyEventResult.handled;
                  }
                }
                return KeyEventResult.ignored;
              },
              child: TextButton(
                onPressed: Actions.handler<UndoCellIntent>(
                  innerContext,
                  UndoCellIntent(),
                ),
                child: const Text(
                  'Press Ctrl + Z to undo; Press any key to type',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
