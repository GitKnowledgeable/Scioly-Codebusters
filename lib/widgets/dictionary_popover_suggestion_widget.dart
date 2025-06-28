import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class DictionaryPopoverSuggestionWidget extends ConsumerStatefulWidget {
  final String text;
  final Function onPressed;
  const DictionaryPopoverSuggestionWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  ConsumerState<DictionaryPopoverSuggestionWidget> createState() =>
      _DictionaryPopoverSuggestionWidgetState();
}

class _DictionaryPopoverSuggestionWidgetState
    extends ConsumerState<DictionaryPopoverSuggestionWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _alphaColorAnimation;

  // final _buttonWidth = screenW * (2 / 3);
  late final List<Color> gradientColor;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _alphaColorAnimation = Tween(begin: 50.0, end: 75.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onEnter(PointerEnterEvent details) {
    _animationController.forward();
  }

  void _onExit(PointerExitEvent? details) {
    _animationController.reverse();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
    widget.onPressed();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return MouseRegion(
          onEnter: _onEnter,
          onExit: _onExit,
          child: GestureDetector(
            onTapUp: _onTapUp,
            onTapDown: _onTapDown,
            child: Container(
              height: containerHeight,
              margin: EdgeInsets.all(3),
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: BoxBorder.all(color: AppTheme.logoGreen, width: 1),
                color: AppTheme.logoGreen.withAlpha(
                  _alphaColorAnimation.value.toInt(),
                ),
              ),
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: AppTheme.logoGreen,
                    fontSize: 15,
                    shadows: [
                      Shadow(color: AppTheme.logoGreen, blurRadius: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
