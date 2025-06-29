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

class _StatBoxWidgetState extends ConsumerState<StatBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: widget.neonColor, width: 2),
        color: Colors.black,
        boxShadow: [BoxShadow(color: widget.neonColor, blurRadius: 5.0)],
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
    );
  }
}
