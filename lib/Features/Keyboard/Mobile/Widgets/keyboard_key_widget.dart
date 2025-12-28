import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scioly_codebusters/library.dart';

class KeyboardKeyWidget extends ConsumerStatefulWidget {
  final String keyValue;
  final Color color;
  final double paddingHorizontal;
  final double paddingVertical;
  final double endScale;
  final Function onPressed;
  final bool isPressed;
  final int animDuration;

  const KeyboardKeyWidget({
    super.key,
    required this.keyValue,
    required this.onPressed,

    this.endScale = 1.1,
    this.paddingVertical = 5.0,
    this.paddingHorizontal = 5.0,
    this.isPressed = false,
    this.color = Colors.green,
    this.animDuration = 200,
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
      duration: Duration(milliseconds: widget.animDuration),
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

  void _onTap() async {
    await keyboardClickSound();
    _animationController.forward();
    widget.onPressed();
    Future.delayed(Duration(milliseconds: widget.animDuration), () {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return InkWell(
          // onTapDown: _onTapDown,
          // onTapUp: _onTapUp,
          onTap: _onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: widget.paddingVertical,
              horizontal: widget.paddingHorizontal,
            ),
            decoration: BoxDecoration(
              color: widget.isPressed
                  ? widget.color.withAlpha((50 * _scaleAnimation.value).toInt())
                  : widget.color.withAlpha(
                      (100 * _scaleAnimation.value * _scaleAnimation.value)
                          .toInt(),
                    ),
              border: widget.isPressed
                  ? Border.all(width: 0)
                  : Border.all(color: widget.color.withAlpha(150), width: 1),
            ),
            child: Center(
              child: Text(
                widget.keyValue,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        );
      },
    );
  }
}
