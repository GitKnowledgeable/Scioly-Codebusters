import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scioly_codebusters/library.dart';

class Settings extends ConsumerStatefulWidget {
  final AudioController? audioCont;
  const Settings({super.key, this.audioCont});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  double curSliderVal = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            "Settings",
            style: TextStyle(
              shadows: [Shadow(color: AppTheme.logoGreen, blurRadius: 5)],
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(insetPadding),
          child: Column(
            children: [
              HeadingWidget(
                neonColor: AppTheme.logoGreen,
                title: "Background Music",
                numIcon: Icon(Icons.music_note, color: Colors.black),
              ),
              Slider(
                value: curSliderVal,
                thumbColor: widget.audioCont?.isBgPlaying() ?? false
                    ? AppTheme.logoGreen
                    : Colors.grey,
                activeColor: widget.audioCont?.isBgPlaying() ?? false
                    ? AppTheme.logoGreen
                    : Colors.grey,
                onChanged: (value) {
                  if (widget.audioCont?.isBgPlaying() ?? false) {
                    widget.audioCont?.setBgVolume(value);
                    setState(() {
                      curSliderVal = value;
                    });
                  }
                },
              ),
              StyledButtonWidget(
                value: "Toggle Background Music",
                onPressed: () {
                  widget.audioCont?.toggleBgSound();
                  setState(() {});
                },
                bgColor: widget.audioCont?.isBgPlaying() ?? false
                    ? Colors.redAccent
                    : AppTheme.logoGreen,
                paddingVertical: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
