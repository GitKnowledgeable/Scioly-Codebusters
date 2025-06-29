import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

class KeyboardKeyWidget extends ConsumerStatefulWidget {
  final String keyValue;
  final Color color;
  final double padding;
  final double endScale;
  final Function onPressed;
  final bool isPressed;

  const KeyboardKeyWidget({
    super.key,
    required this.keyValue,
    required this.onPressed,

    this.endScale = 1.1,
    this.padding = 5.0,
    this.isPressed = false,
    this.color = Colors.green,
  });

  @override
  ConsumerState<KeyboardKeyWidget> createState() => _KeyboardKeyWidgetState();
}

class _KeyboardKeyWidgetState extends ConsumerState<KeyboardKeyWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween(begin: 1.0, end: widget.endScale).animate(
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
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            child: Container(
              padding: EdgeInsets.all(widget.padding),
              decoration: BoxDecoration(
                color: widget.isPressed
                    ? widget.color.withAlpha(
                        (50 * _scaleAnimation.value).toInt(),
                      )
                    : widget.color.withAlpha(
                        (150 * _scaleAnimation.value * _scaleAnimation.value)
                            .toInt(),
                      ),
                border: widget.isPressed
                    ? Border.all(width: 0)
                    : Border.all(color: widget.color, width: 1),
              ),
              child: Center(
                child: Text(
                  widget.keyValue,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
