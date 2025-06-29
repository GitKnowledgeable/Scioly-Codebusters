import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class HomeButtonWidget extends ConsumerStatefulWidget {
  final String btnText;
  final String num;
  final Color neonColor;
  final Function onPressed;

  final int initialAlpha;
  final int finalAlpha;
  const HomeButtonWidget({
    super.key,
    required this.btnText,
    required this.neonColor,
    required this.onPressed,
    this.num = "",
    this.initialAlpha = 10,
    this.finalAlpha = 255,
  });

  @override
  ConsumerState<HomeButtonWidget> createState() => _HomeButtonWidgetState();
}

class _HomeButtonWidgetState extends ConsumerState<HomeButtonWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Alignment> _leftAlignmentAnimation;
  late final Animation<Alignment> _rightAlignmentAnimation;
  late final Animation<double> _glowAnimation;
  late final Animation<double> _stopsAnimation;

  final _buttonWidth = screenW * (2 / 3);
  late final List<Color> gradientColor;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _leftAlignmentAnimation =
        Tween(begin: Alignment.centerLeft, end: Alignment.centerRight).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
        );

    _rightAlignmentAnimation =
        Tween(begin: Alignment.centerRight, end: Alignment.centerLeft).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
        );

    _glowAnimation = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _stopsAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    gradientColor = [
      widget.neonColor.withAlpha(widget.initialAlpha),
      widget.neonColor.withAlpha(widget.finalAlpha),
    ];
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
        return GestureDetector(
          onTapUp: _onTapUp,
          onTapDown: _onTapDown,
          child: Container(
            width: _buttonWidth,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: widget.neonColor.withAlpha(
                    (_glowAnimation.value * 20).round(),
                  ),
                  blurRadius: _glowAnimation.value,
                  spreadRadius: 0,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: _leftAlignmentAnimation.value,
                colors: gradientColor,
                stops: [_stopsAnimation.value, 1 - _stopsAnimation.value],
              ),
              border: Border.all(color: widget.neonColor, width: 2),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: _rightAlignmentAnimation.value,
                  colors: gradientColor,
                  stops: [_stopsAnimation.value, 1 - _stopsAnimation.value],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Row(
                  children: [
                    Text(
                      widget.num,
                      style: TextStyle(
                        fontFamily: 'JetBrainsMono',
                        fontSize: 10,
                        color: widget.neonColor,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(color: widget.neonColor, blurRadius: 10),
                          Shadow(color: Colors.black, blurRadius: 5),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.btnText,
                          style: TextStyle(
                            fontFamily: 'JetBrainsMonoBold',
                            fontSize: 15,
                            color: widget.neonColor,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(color: widget.neonColor, blurRadius: 10),
                              Shadow(color: Colors.black, blurRadius: 5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      widget.num != "" ? '>' : '',
                      style: TextStyle(
                        fontFamily: 'JetBrainsMono',
                        fontSize: 15,
                        color: widget.neonColor,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(color: widget.neonColor, blurRadius: 10),
                          Shadow(color: Colors.black, blurRadius: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
