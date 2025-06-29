import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class GamePageHeaderWidget extends ConsumerStatefulWidget {
  final GameProvider provider;
  final bool showCorrect;
  final String gameKey;
  const GamePageHeaderWidget({
    super.key,
    required this.provider,
    required this.showCorrect,
    required this.gameKey,
  });

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
      // Or whatever condition means "empty"
      return const SizedBox.shrink();
    }
    final showCorrect = ref.watch(
      gameProvider(widget.gameKey).select((s) => s.showCorrect),
    );
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
                TimerWidget(timerId: widget.gameKey),
                Expanded(
                  child: Container(
                    height: panelHeight,
                    margin: EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      border: BoxBorder.all(
                        color: AppTheme.logoGreen,
                        width: 1,
                      ),
                      color: AppTheme.logoGreen.withAlpha(
                        showCorrect ? 75 : 50,
                      ),
                    ),
                    child: Center(
                      child: ListTileTheme(
                        horizontalTitleGap: 0,
                        child: CheckboxListTile(
                          title: Text(
                            'Show Correct',
                            style: TextStyle(
                              color: AppTheme.logoGreen,
                              fontFamily: 'JetBrainsMonoBold',
                              fontSize: 15,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          checkColor: Colors.white,
                          activeColor: AppTheme.logoGreen,
                          side: const BorderSide(color: AppTheme.logoGreen),
                          value: showCorrect,
                          onChanged: (bool? value) {
                            if (showCorrect) {
                              widget.provider.markIncorrect();
                            } else {
                              widget.provider.markCorrect();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTapUp: (TapUpDetails details) {
                    widget.provider.hint();
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
                        color: AppTheme.logoGreen.withAlpha(
                          _alphaColorAnimation.value.toInt(),
                        ),
                        border: Border.all(color: AppTheme.logoGreen, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          "Hint",
                          style: TextStyle(
                            color: AppTheme.logoGreen,
                            fontSize: 20,
                            fontFamily: 'JetBrainsMonoBold',
                            shadows: [
                              Shadow(color: AppTheme.logoGreen, blurRadius: 5),
                            ],
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
