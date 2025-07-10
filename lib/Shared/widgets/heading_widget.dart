import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadingWidget extends ConsumerWidget {
  final Color neonColor;
  final String title;
  final String num;
  final Icon? numIcon;
  final double fontSize;

  const HeadingWidget({
    super.key,
    required this.neonColor,
    required this.title,
    this.num = "",
    this.numIcon,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: neonColor, width: 2)),
      ),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        children: [
          Container(
            color: neonColor,
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: numIcon == null
                ? Text(
                    num,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: fontSize - 5,
                    ),
                  )
                : numIcon,
          ),

          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: neonColor,
              fontFamily: 'JetBrainsMonoBold',
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
