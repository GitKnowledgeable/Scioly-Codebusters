import 'package:flutter/material.dart';
import 'package:scioly_codebusters/library.dart';

class HomeLogo extends StatelessWidget {
  HomeLogo({super.key});

  final width = GameSetup.width * (1 / 2);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        border: Border.all(color: AppTheme.logoGreen, width: 2),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: AppTheme.backgroundColors,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.logoGreen.withAlpha(100),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(500),
        child: Image.asset("assets/image/scioly-logo.png", fit: BoxFit.cover),
      ),
      // child: Center(
      //   child: Text(
      //     "SCIOLY\nCODEBUSTERS",
      //     style: TextStyle(
      //       color: AppTheme.logoGreen,
      //       fontSize: 17,
      //       fontFamily: 'JetBrainsMonoBold',
      //       fontWeight: FontWeight.w800,
      //     ),
      //     textAlign: TextAlign.center,
      //   ),
      // ),
    );
  }
}
