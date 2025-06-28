import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

// Notifier that manages a ScrollController
class ScrollControllerNotifier
    extends AutoDisposeFamilyNotifier<ScrollController, String> {
  @override
  ScrollController build(String arg) {
    final controller = ScrollController();
    ref.onDispose(() => controller.dispose());
    return controller;
  }

  void scrollToSelected(double position) {
    if (!state.hasClients) return;
    var scrollHeight =
        state.position.viewportDimension -
        (containerHeight + 2 * decorationHeight) -
        keyboardH -
        panelHeight -
        containerHeight * 2;
    if ((position - state.offset) > scrollHeight) {
      state.animateTo(
        position - (scrollHeight / 2),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if ((position - state.offset) < 0) {
      state.animateTo(
        position,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}

final scrollProvider =
    AutoDisposeNotifierProvider.family<
      ScrollControllerNotifier,
      ScrollController,
      String
    >(ScrollControllerNotifier.new);
