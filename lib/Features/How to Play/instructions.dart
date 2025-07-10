import 'package:flutter/material.dart';
import 'package:scioly_codebusters/library.dart';

class Instructions extends StatelessWidget {
  final String gameId;
  const Instructions({super.key, required this.gameId});
  @override
  Widget build(BuildContext context) {
    switch (gameId) {
      case "Aristocrat":
        return AristocratInstructionsPage();
      case "Patristocrat":
        return PatristocratInstructionsPage();
      case "Xenocrypt":
        return XenocryptInstructionsPage();
    }
    return SizedBox.shrink();
  }
}
