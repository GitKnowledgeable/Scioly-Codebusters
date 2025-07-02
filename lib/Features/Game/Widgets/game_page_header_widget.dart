import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class GamePageHeaderWidget extends ConsumerStatefulWidget {
  final String gameKey;
  const GamePageHeaderWidget({super.key, required this.gameKey});

  @override
  ConsumerState<GamePageHeaderWidget> createState() =>
      _GamePageHeaderWidgetState();
}

class _GamePageHeaderWidgetState extends ConsumerState<GamePageHeaderWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _alphaColorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _alphaColorAnimation = Tween(begin: 50.0, end: 100.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onEnter(PointerEnterEvent details) {
    if (mounted) _animationController.forward();
  }

  void _onExit(PointerExitEvent? details) {
    if (mounted) _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameProvider(widget.gameKey));
    if (gameState.cells.isEmpty) {
      return const SizedBox.shrink();
    }
    final provider = ref.read(gameProvider(widget.gameKey).notifier);
    final showCorrect = ref.watch(
      gameProvider(widget.gameKey).select((s) => s.showCorrect),
    );
    final showSuggestions = ref.watch(
      gameProvider(widget.gameKey).select((s) => s.showSuggestions),
    );

    final timerColor = Colors.redAccent;
    final showCorrectColor = AppTheme.logoGreen;
    final dictionaryToggleColor = showSuggestions
        ? Colors.lightBlueAccent
        : Colors.blueAccent;
    final hintColor = Colors.yellowAccent;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Center(
          child: Container(
            width: screenW,
            height: panelHeight + padding,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TimerWidget(timerId: widget.gameKey, color: timerColor),
                SizedBox(width: padding),
                Expanded(
                  child: Container(
                    height: panelHeight,
                    decoration: BoxDecoration(
                      border: BoxBorder.all(color: showCorrectColor, width: 1),
                      color: showCorrectColor.withAlpha(showCorrect ? 75 : 50),
                    ),
                    child: Center(
                      child: ListTileTheme(
                        horizontalTitleGap: 0,
                        child: CheckboxListTile(
                          title: Text(
                            'Show Correct',
                            style: TextStyle(
                              color: showCorrectColor,
                              fontFamily: 'JetBrainsMonoBold',
                              fontSize: widget.gameKey.contains("Patristocrat")
                                  ? 15
                                  : 12,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          checkColor: Colors.white,
                          activeColor: showCorrectColor,
                          side: BorderSide(color: showCorrectColor),
                          value: showCorrect,
                          onChanged: (bool? value) {
                            if (showCorrect) {
                              provider.markIncorrect();
                            } else {
                              provider.markCorrect();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                if (!widget.gameKey.contains("Patristocrat"))
                  SizedBox(width: padding),
                if (!widget.gameKey.contains("Patristocrat"))
                  GestureDetector(
                    onTap: () {
                      provider.setSuggestions(!showSuggestions);
                    },
                    child: Container(
                      padding: EdgeInsets.all(insetPadding),
                      decoration: BoxDecoration(
                        color: dictionaryToggleColor.withAlpha(50),
                        border: Border.all(
                          color: dictionaryToggleColor,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.menu_book_sharp,
                        color: dictionaryToggleColor,
                      ),
                    ),
                  ),
                SizedBox(width: padding),
                GestureDetector(
                  onTapUp: (TapUpDetails details) {
                    provider.hint();
                    if (mounted) _animationController.reverse();
                  },
                  onTapDown: (details) {
                    if (mounted) _animationController.forward();
                  },
                  child: MouseRegion(
                    onEnter: _onEnter,
                    onExit: _onExit,
                    child: Container(
                      height: panelHeight,
                      width: 100,
                      padding: EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        color: hintColor.withAlpha(
                          _alphaColorAnimation.value.toInt(),
                        ),
                        border: Border.all(color: hintColor, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          "Hint",
                          style: TextStyle(
                            color: hintColor,
                            fontSize: 20,
                            fontFamily: 'JetBrainsMonoBold',
                            shadows: [Shadow(color: hintColor, blurRadius: 5)],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
