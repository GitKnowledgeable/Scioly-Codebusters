import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class StatRowWidget extends ConsumerStatefulWidget {
  final String title;
  final Color neonColor;
  final String value;

  const StatRowWidget({
    super.key,
    required this.title,
    required this.neonColor,
    required this.value,
  });

  @override
  ConsumerState<StatRowWidget> createState() => _StatRowWidgetState();
}

class _StatRowWidgetState extends ConsumerState<StatRowWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Alignment> _gradientAnimation;
  late final Animation<double> _textAnimation;
  final gradientColors = [Colors.grey.withAlpha(50), Colors.transparent];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _gradientAnimation =
        Tween(begin: Alignment.centerLeft, end: Alignment.centerRight).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.linear),
        );
    _textAnimation = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
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
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: widget.neonColor.withAlpha(100),
                    width: 2,
                  ),
                ),

                gradient: LinearGradient(
                  colors: gradientColors,
                  stops: [1, 1],
                  begin: Alignment.centerLeft,
                  end: _gradientAnimation.value,
                ),
              ),
              child: Row(
                children: [
                  Transform.translate(
                    offset: Offset(_textAnimation.value, 0),
                    child: Text(
                      widget.title.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${widget.value}s",
                    style: TextStyle(
                      color: widget.neonColor,
                      fontSize: 18,
                      shadows: [
                        Shadow(color: widget.neonColor, blurRadius: 5),
                        Shadow(color: widget.neonColor, blurRadius: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
