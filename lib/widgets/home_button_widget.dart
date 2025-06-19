import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class HomeButtonWidget extends ConsumerStatefulWidget {
  final String btnText;
  final String num;
  final Color neonColor;
  final Function onPressed;
  const HomeButtonWidget({
    Key? key,
    required this.btnText,
    required this.neonColor,
    required this.num,
    required this.onPressed,
  }) : super(key: key);

  @override
  ConsumerState<HomeButtonWidget> createState() => _HomeButtonWidgetState();
}

class _HomeButtonWidgetState extends ConsumerState<HomeButtonWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Alignment> _leftAlignmentAnimation;
  late final Animation<Alignment> _rightAlignmentAnimation;
  late final Animation<double> _glowAnimation;

  final _buttonWidth = LayoutConfig.width * (2 / 3);

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
                  colors: [widget.neonColor, Colors.transparent],
                  stops: [1, 1],
                ),
                border: Border.all(color: widget.neonColor, width: 2),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: _rightAlignmentAnimation.value,
                    colors: [widget.neonColor, Colors.transparent],
                    stops: [1, 1],
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
                        '>',
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
          ),
        );
      },
    );
  }
}
