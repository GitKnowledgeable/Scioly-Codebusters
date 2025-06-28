import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';
import 'package:flutter/services.dart';

class StyledButtonWidget extends ConsumerStatefulWidget {
  final String value;
  final Color color;
  final double padding;
  final double endScale;
  final double marginHorizontal;
  final double marginVertical;
  final Function onPressed;

  const StyledButtonWidget({
    super.key,
    required this.value,

    this.onPressed = _defaultOnPressed,
    this.endScale = 1.1,
    this.marginHorizontal = 0,
    this.marginVertical = 0,
    this.padding = 5.0,
    this.color = Colors.green,
  });

  @override
  ConsumerState<StyledButtonWidget> createState() => _StyledButtonWidgetState();

  static void _defaultOnPressed() {
    return;
  }
}

class _StyledButtonWidgetState extends ConsumerState<StyledButtonWidget>
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
              margin: EdgeInsets.symmetric(
                vertical: widget.marginVertical,
                horizontal: widget.marginHorizontal,
              ),
              decoration: BoxDecoration(
                color: widget.color.withAlpha(
                  (50 * _scaleAnimation.value * _scaleAnimation.value).toInt(),
                ),
                border: Border.all(color: widget.color, width: 1),
              ),
              child: Center(
                child: Text(
                  widget.value,
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
