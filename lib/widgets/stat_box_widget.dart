import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class StatBoxWidget extends ConsumerStatefulWidget {
  final String title;
  final String num;
  final Color neonColor;
  final String fastest;
  final String average;

  const StatBoxWidget({
    super.key,
    required this.title,
    required this.num,
    required this.neonColor,
    required this.fastest,
    required this.average,
  });

  @override
  ConsumerState<StatBoxWidget> createState() => _StatBoxWidgetState();
}

class _StatBoxWidgetState extends ConsumerState<StatBoxWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _glowAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _glowAnimation = Tween(begin: 5.0, end: 15.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween(begin: 1.0, end: 1.01).animate(
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
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: widget.neonColor, width: 2),
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: widget.neonColor,
                      blurRadius: _glowAnimation.value,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(insetPadding),
                child: Column(
                  children: [
                    HeadingWidget(
                      neonColor: widget.neonColor,
                      title: widget.title,
                      num: widget.num,
                    ),
                    // padding
                    const SizedBox(height: 20),

                    StatRowWidget(
                      title: "Fastest",
                      neonColor: widget.neonColor,
                      value: widget.fastest,
                    ),
                    StatRowWidget(
                      title: "Average",
                      neonColor: widget.neonColor,
                      value: widget.average,
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
